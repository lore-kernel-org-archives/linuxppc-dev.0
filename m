MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Data Cache Issues
Date: Mon, 15 Apr 2002 10:47:10 -0500
Message-ID: <D3A72C5007329A4F991C0DD87202259F096AFF@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Ppcboot-Users (E-mail)" <ppcboot-users@lists.sourceforge.net>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I now understand that the entire IMMAP region is mapped as uncacheable. Are there any other regions that are mapped this way for the 8xx chip? Where can I find this info in the kernel code?

Thank you.
Navin.

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Saturday, April 13, 2002 10:29 AM
To: Navin Boppuri
Cc: Wolfgang Denk; Ppcboot-Users (E-mail); Linuxppc-Embedded (E-mail)
Subject: Re: Data Cache Issues


Navin Boppuri wrote:

> What am I missing here?

The knowledge of how caches and MMUs work on PowerPC.

If you don't have the MMU enabled, your cache mode covers the entire address
space.  Since PPCboot doesn't enable the MMU, you can't cache just some of the
data space.  To have the IMMR region uncacheable, you need all data access
set that way.

The Linux kernel runs with the MMU enabled, so you can select cache atrributes
on individual pages.

Some boot roms run with the MMU and data caches enabled.  In any case you have
to enter Linux with the MMU disabled and the caches coherent with memory.  If
you care to actually learn about all of the Linux bootloaders, you will notice
some of them disable the MMUs and ensure the caches are coherent early in their
operation.  This was one of the reasons for requiring all Linux booting to use
a piggyback loader, as we discussed moving all of the MMU and data cache
initialization into the boot loaders.  We wanted to take advantage of some of
these boot rom performance enhancements, and likely enter Linux with MMUs and
caches enabled.  The whole of the bi_recs discussion is totally missing the
point of why a piggyback loader is so useful to Linux.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
