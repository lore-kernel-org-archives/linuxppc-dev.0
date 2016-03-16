Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ4ry0XKhzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 19:48:33 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 16 Mar 2016 08:48:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B9E2B17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 08:48:57 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2G8mQ1a8585714
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 08:48:26 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2G8mP3u017945
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 04:48:26 -0400
Message-ID: <56E91E2D.60004@linux.vnet.ibm.com>
Date: Wed, 16 Mar 2016 09:49:49 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
Subject: Re: [PATCH] cxl: Configure the PSL for dual port CAPI on Naples
References: <1458052008-29254-1-git-send-email-felix@linux.vnet.ibm.com>
 <1458090911.9668.15.camel@neuling.org>
In-Reply-To: <1458090911.9668.15.camel@neuling.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> On Tue, 2016-03-15 at 15:26 +0100, Philippe Bergheaud wrote:
> 
>>Naples CPUs have two CAPI ports.  
> 
> 
> Naples is an internal name, don't use that.  Use POWER8NVL is the name
> we use in the kernel.
> 
> alsi, it's a "chip" that has two CAPI ports, not the CPU.
> 
OK, I will rephrase.
> 
>>Configure the PSL to route data to
>>the port corresponding to the PHB index.
> 
> 
> Isn't this capp unit in reality, not phb index?
> 
Yes, I meant capp unit port.
> 
>>Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
>>---
>> drivers/misc/cxl/pci.c | 15 ++++++++++++++-
>> 1 file changed, 14 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
>>index 0c6c17a1..3db0a0b 100644
>>--- a/drivers/misc/cxl/pci.c
>>+++ b/drivers/misc/cxl/pci.c
>>@@ -340,12 +340,15 @@ static void dump_afu_descriptor(struct cxl_afu
>>*afu)
>> #undef show_reg
>> }
>> 
>>+#define CPU_IS_NAPLES() (cur_cpu_spec->pvr_value == 0x004c0000)
> 
> 
> Use pvr_version_is(PVR_POWER8NVL))
> 
OK.
> 
>>+
>> static int init_implementation_adapter_regs(struct cxl *adapter,
>>struct pci_dev *dev)
>> {
>> 	struct device_node *np;
>> 	const __be32 *prop;
>> 	u64 psl_dsnctl;
>> 	u64 chipid;
>>+	u64 phb_index;
>> 
>> 	if (!(np = pnv_pci_get_phb_node(dev)))
>> 		return -ENODEV;
>>@@ -355,10 +358,20 @@ static int
>>init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
>> 	if (!np)
>> 		return -ENODEV;
>> 	chipid = be32_to_cpup(prop);
>>-	of_node_put(np);
>> 
>> 	/* Tell PSL where to route data to */
>> 	psl_dsnctl = 0x02E8900002000000ULL | (chipid << (63-5));
>>+	if (CPU_IS_NAPLES()) {
>>+		prop = of_get_property(np, "ibm,phb-index", NULL);
>>+		if (!prop) {
>>+			of_node_put(np);
>>+			return -ENODEV;
>>+		}
>>+		phb_index = be32_to_cpup(prop);
>>+		psl_dsnctl |= (phb_index << (63-11));
> 
> 
> Looking at the psl docs, cappunitid in the dsndctl is bits 6 to 13.  So
> why 11 here?
> 
Because on POWER8NVL, dsndctl bit 11 == phb_index == cappunitid.
Bits 6-10 and 12-13 do not change between POWER8 and POWER8NVL.

> Can you abstract this better and make it clear what's happening?  Try
> something like this:
> 
> int capp_unit()
> {
> 
> 	if (!pvr_version_is(PVR_POWER8NVL))
> 	/* For chips other than POWER8NVL, we only have CAPP 0
>          * irrespective of which PHB is used */
> 		return 0;
> 
> 	/* For POWER8NVL, assume CAPP 0 is attached to PHB0 and 
>          * CAPP 1 is attached to PHB1*/
> 	prop = of_get_property(np, "ibm,phb-index", NULL);
> 	if (!prop) {
> 		of_node_put(np);
> 		return -ENODEV;
> 	}
> 	return be32_to_cpup(prop);
> }
> 
> Then you can do something like (although you need to fix the error
> case)
>         psl_dsnctl |= (capp_unit(p) << (63-13));
> 
> Mikey
> 
OK. I will. Thank you.

Philippe
> 
>>+	}
>>+	of_node_put(np);
>>+
>> 	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
>> 	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
>> 	/* snoop write mask */
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
