Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5FB862C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 17:17:08 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 11 Oct 2013 02:17:05 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 246316E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 02:17:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9B6H3Fs55312412
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 06:17:03 GMT
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r9B6H1E0001605
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 02:17:02 -0400
Date: Fri, 11 Oct 2013 14:16:54 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 3/6] powerpc/pci: use pci_is_pcie() to simplify code
Message-ID: <20131011061654.GA561@shangw.(null)>
References: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
 <1378367730-25996-3-git-send-email-wangyijing@huawei.com>
 <20130906203035.GA27940@google.com>
 <1381470596.5630.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381470596.5630.61.camel@pasglop>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Yijing Wang <wangyijing@huawei.com>, Paul Mackerras <paulus@samba.org>,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 11, 2013 at 04:49:56PM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2013-09-06 at 14:30 -0600, Bjorn Helgaas wrote:
>> On Thu, Sep 05, 2013 at 03:55:27PM +0800, Yijing Wang wrote:
>> > Use pci_is_pcie() to simplify code.
>> > 
>> > Acked-by: Kumar Gala <galak@kernel.crashing.org>
>> > Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> > Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > Cc: linux-kernel@vger.kernel.org
>> > ---
>> >  arch/powerpc/kernel/eeh.c     |    3 +--
>> >  arch/powerpc/sysdev/fsl_pci.c |    2 +-
>> >  2 files changed, 2 insertions(+), 3 deletions(-)
>> 
>> Ben, Paul, this has no dependencies on anything new to PCI or any
>> other patches in this series, so you can take it through the POWERPC
>> tree.  If you don't want to do that, let me know and I can take it.
>> 
>> If you want it:
>> 
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>It's also quite broken :-)
>
>See below:
>
>> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> > index 55593ee..6ebbe54 100644
>> > --- a/arch/powerpc/kernel/eeh.c
>> > +++ b/arch/powerpc/kernel/eeh.c
>> > @@ -189,8 +189,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
>> >  	}
>> >  
>> >  	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
>> > -	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
>> > -	if (cap) {
>> > +	if (pci_is_pcie(dev)) {
>> >  		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
>> >  		printk(KERN_WARNING
>> >  		       "EEH: PCI-E capabilities and status follow:\n");
>
>So we remove reading of "cap", but slightly further down the code does:
>
>		for (i=0; i<=8; i++) {
>			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
>			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
>			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
>		}
>
>Which actually *uses* the value of "cap" ... oops :-)
>

It's my fault and I should have looked into the changes more closely.
How about changing it like this:

	cap = pci_is_pcie(dev) ? pci_pcie_cap(dev) :
	      pci_find_capability(dev, PCI_CAP_ID_EXP);
	if (cap) {
		...
	}

It would save some PCI-CFG access cycles for most cases :-)

>> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>> > index 46ac1dd..5402a1d 100644
>> > --- a/arch/powerpc/sysdev/fsl_pci.c
>> > +++ b/arch/powerpc/sysdev/fsl_pci.c
>> > @@ -41,7 +41,7 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
>> >  	u8 hdr_type;
>> >  
>> >  	/* if we aren't a PCIe don't bother */
>> > -	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
>> > +	if (!pci_is_pcie(dev))
>> >  		return;
>> >  
>> >  	/* if we aren't in host mode don't bother */

Thanks,
Gavin
