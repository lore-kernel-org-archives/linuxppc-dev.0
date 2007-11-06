Return-Path: <SRS0=kYWG=P7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id BD2ECDDD0D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 17:50:32 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: mmap question on ppc440
Date: Tue, 6 Nov 2007 07:50:21 +0100
References: <472F8503.2080705@harris.com> <20071105151659.3ea601e4@weaponx>
In-Reply-To: <20071105151659.3ea601e4@weaponx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711060750.21750.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 05 November 2007, Josh Boyer wrote:
> > I am attempting to access the CPLD on the AMCC Sequoia board from
> > user-land.  I open /dev/mem, and mmap it, then try to access the
> > resulting pointer.  That works fine when accessing physical addresses
> > that correspond to RAM, but as soon as I try to access the CPLD at
> > physical address 0xc0000000, I get an infinite machine check.
>
> That's because the CPLD is actually at physical address 0x1C0000000.
> Yay for 36-bit physical addresses.

Right. Are you using arch/ppc or arch/powerpc? If it's arch/ppc you could
give the following patch a try:

@@ -275,6 +275,14 @@
 {
        size_t size = vma->vm_end - vma->vm_start;

+#if defined(CONFIG_44x) && !defined(CONFIG_PPC_MERGE)
+       /*
+        * 2006-08-07: sr
+        * Needed on 44x-er systems for 36bit addresses (like pci on 440gx)
+        */
+       vma->vm_pgoff = (fixup_bigphys_addr(vma->vm_pgoff << PAGE_SHIFT, size) >> PAGE_SHIFT);
+#endif
+
        if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
                return -EINVAL;


Best regards,
Stefan
