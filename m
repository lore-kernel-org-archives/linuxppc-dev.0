Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1DF8167A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 10:20:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 8 Mar 2005 17:20:38 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592EB@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
> Sent: Tuesday, March 08, 2005 17:14
> To: Rune Torgersen
> Cc: linuxppc-embedded@ozlabs.org; Matt Porter
> Subject: Re: Lots of memory on 826x
>=20
> Hmm, I think there is an expectation that virt->phys is a simple=20
> translation (ie, subtract KERNELBASE) for lowmem.  lowmem most parts=20
> tops out at 768M.  So changing VMALLOC_START would break that.

Yep noticed..... (tried changing it...)

>=20
> Is there an issue with moving the IMMR virt address up higher?
Not really. Will have to redo a whole lot of address maps for some
external devices, but not too bad...

I did change the kernel start address, and that seems to work better,
except that things is still broken when CONFIG_HIGHMEM is set
When that option is set, it maps the highmem to 0xFE000000, which is in
the IO area mapped for IMMR and other memory mapped devices.
(0xF0000000-0xFFFFFFFF)

This can be changed by CONFIG_HIGHMEM_START. Any good ideas on where to
move it to?

(Maybe change IMMR/IO to 0xF8000000 and up, and set HIGHMEM_START to
0xF0000000?)
