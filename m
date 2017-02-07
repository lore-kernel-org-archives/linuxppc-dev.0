Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ0k42NmHzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 10:22:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17NDUia070212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 18:22:33 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fphqjnff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 18:22:33 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 09:22:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3441F2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 10:22:28 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17NMKtl23330894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 10:22:28 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17NLtac003479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 10:21:55 +1100
Date: Wed, 8 Feb 2017 10:21:30 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 imunsie@au1.ibm.com
Subject: Re: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
 <871svab6fj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871svab6fj.fsf@concordia.ellerman.id.au>
Message-Id: <20170207232130.GB10885@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 10:12:48PM +1100, Michael Ellerman wrote:
>Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

.../...

>> The effect of this patch is to copy the memory resources from the *real* 
>> PHB to the vPHB, as given through the device tree. It shouldn't have any 
>> practical effect other than squashing this message.
>
>It sounds a bit backward to me. If we don't need the resources then
>why have them?
>
>If we have code that thinks that's an error, than maybe that's what
>needs fixing, or special casing for the vPHB?
>

Yeah, vPHB is a special case. There are basically two stages in PCI enumeration:
probing and then resource assignment. vPHB is different from *real* PHB as the
resource assignment is skipped on it. So vPHB doesn't need any resources to be
populated. However, there is a check in probing stage and it's where the warning
message comes from.

   drivers/misc/cxl/vphb.c::cxl_pci_vphb_add()
   arch/powerpc/kernel/pci-common.c::pcibios_scan_phb()
                                     pcibios_setup_phb_resources()

   static void pcibios_setup_phb_resources(struct pci_controller *hose,
                                        struct list_head *resources)
   {
       :
       for (i = 0; i < 3; ++i) {
            res = &hose->mem_resources[i];
            if (!res->flags) {
                if (i == 0)
                    printk(KERN_ERR "PCI: Memory resource 0 not set for "
                        "host bridge %s (domain %d)\n",
                        hose->dn->full_name, hose->global_number);
                continue;
            }
       :
   }

Alternatively, we can replace prink(KERN_ERR) with pr_debug(). It's going to
affect all PHBs including the real ones. Andrew and Michael, what do you think? :-)

Thanks,
Gavin 
