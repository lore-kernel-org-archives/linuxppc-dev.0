Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4F002C0138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 21:06:40 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 07:06:34 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0F8886E803A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 07:06:29 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MB6Sgl159302
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 07:06:28 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MB6ICJ028051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 05:06:18 -0600
Date: Mon, 22 Apr 2013 19:06:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130422110617.GA21476@shangw.(null)>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
 <20130421233436.GB22246@concordia>
 <20130422014533.GA7902@shangw.(null)>
 <20130422025636.GB24739@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130422025636.GB24739@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 12:56:37PM +1000, Michael Ellerman wrote:
>On Mon, Apr 22, 2013 at 09:45:33AM +0800, Gavin Shan wrote:
>> On Mon, Apr 22, 2013 at 09:34:36AM +1000, Michael Ellerman wrote:
>> >On Fri, Apr 19, 2013 at 05:32:45PM +0800, Gavin Shan wrote:
>> >> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
>> >> steps to handle the P/Q bits in IVE before EOIing the corresponding
>> >> interrupt. The patch changes the EOI handler to cover that.
>> 
>> Thanks for your time to review it, Michael. By the way, I think I need
>> rebase the patch since the patch fb1b55d654a7038ca6337fbf55839a308c9bc1a7
>> ("Using bitmap to manage MSI") has been merged to linux-next.
>> 
>> >> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
>> >> index 48861d3..289355e 100644
>> >> --- a/arch/powerpc/sysdev/xics/icp-native.c
>> >> +++ b/arch/powerpc/sysdev/xics/icp-native.c
>> >> @@ -27,6 +27,10 @@
>> >>  #include <asm/xics.h>
>> >>  #include <asm/kvm_ppc.h>
>> >>  
>> >> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
>> >> +extern int pnv_pci_msi_eoi(unsigned int hw_irq);
>> >> +#endif
>> >
>> >You don't need to #ifdef the extern. But it should be in a header, not
>> >here.
>> >
>> 
>> Ok. I'll put it into asm/xics.h, but I want to confirm we needn't
>> #ifdef when moving it to asm/xics.h?
>
>No you don't need it #ifdef'd. It's just extra noise in the file, and
>doesn't really add anything IMHO.
>

Michael, I'm a bit confused about your point. asm/xics.h is shared between
PowerNV and pSeries platform, and pnv_pci_msi_eoi() is only implemented on
PowerNV platform, so the code should look like this (with newly introduced
option - CONFIG_POWERNV_MSI)

#ifdef CONFIG_POWERNV_MSI
extern int pnv_pci_msi_eoi(unsigned int hw_irq);
#endif

Thanks,
Gavin
