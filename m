Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C51C3DDD06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 18:12:25 +1100 (EST)
From: "Lorenz Kolb" <linuxppcemb@lkmail.de>
To: "'Leonid'" <Leonid@a-k-a.net>,
	<linuxppc-embedded@ozlabs.org>
References: <mailman.120.1171370674.21008.linuxppc-embedded@ozlabs.org>
	<000001c74fa0$ce627870$10b2a8c0@lorenzulm>
	<406A31B117F2734987636D6CCC93EE3CF9D7A1@ehost011-3.exch011.intermedia.net>
Subject: Re: RE: How can I boot a program from flash on ML403?
Date: Thu, 15 Feb 2007 08:12:11 +0100
Message-ID: <000001c750d0$9e609d60$10b2a8c0@lorenzulm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <406A31B117F2734987636D6CCC93EE3CF9D7A1@ehost011-3.exch011.intermedia.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

> I use the same scheme (called 3-stage boot) but I don't see what is dirty
about it. For testing/debugging you even can load u-boot directly into
memory using XMD. Of course, image must be compiled to run from memory, not
flash.

actually I call it dirty as SREC is a quite stupid format (for a bootloader,
as it has to be decoded first) and so the loader wastes a lot of time at
least for productive use we do not want this three stage boot.

Actually my partner and I even fitted an u-boot directly into BRAM (if it is
loaded via XMD), unfortunately the binutils of ELDK from W. Denk screwed the
elf (sections were out of segment) and even after fixing that manually (with
a hex editor) data2mem from Xilinx messes something up.

> BTW, do you (or anybody) have XTEMAC drivers for ML403 u-boot?

Actually we did not yet focus on that, we currently mount our NFS by placing
a small initrd image on flash that loads drivers for opb_ethernet and mounts
an nfs volume an chroots to it.

Best Regards,

Lorenz
