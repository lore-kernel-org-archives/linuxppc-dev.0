Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6CE336874D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 09:13:15 +1100 (EST)
Date: Fri, 18 Nov 2005 23:13:09 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051118221309.GA12724@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051118075158.GB14865@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Nov 18, Olaf Hering wrote:

>  On Fri, Nov 18, Paul Mackeras wrote:
> 
> 
> > +++ merge-hack/arch/powerpc/boot/zImage.lds	2005-11-16 23:16:48.000000000 +1100
> 
> This change makes arch/powerpc/boot/README obsolete. 
> Last time I looked, the COFF loader liked only .text, .data and .bss.
> But maybe hack-coff needs some tweaking to modify also other sections.

I tried to keep the kernel in its own section. But the firmware does not
fully setup the memory range for that section. claim and map calls for
that area are not enough.
So we either need a ld script for coff with kernel and initrd in the
.data section. Or we write a tool to extract the vmlinux.gz and initrd
based on nm or readelf -a output.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
