Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from pike.sandelman.ca (pike.sandelman.ca [205.150.200.164])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "pike.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DCE5F67C1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 00:39:23 +1000 (EST)
To: "Absolut Hunter" <absoluthunter@comcast.net>
In-Reply-To: Message from "Absolut Hunter" <absoluthunter@comcast.net>
	of "Mon,
	11 Jul 2005 07:02:14 PDT." <20050711140714.C743F67C23@ozlabs.org>
References: <20050711140714.C743F67C23@ozlabs.org> 
Date: Mon, 11 Jul 2005 10:39:15 -0400
Message-ID: <12069.1121092755@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.4.25 / MPC8280 / ram config vs Linux instability? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Absolut" == Absolut Hunter <absoluthunter@comcast.net> writes:
    Absolut> A useful piece to this might be that I am attempting to map
    Absolut> these two memory regions contiguously, so that Linux
    Absolut> doesn't see any memory holes.

    Absolut> 0-2MB SRAM 2MB-34MB SDRAM

  Likely you can't do that, because you must map the blocks at a
multiple of their address. (I'm not an expert at PPC mappings, but this
is typically the case)

  So you can do:
	 0x000000000	   SRAM		(has a hole from 2MB->32Mb)
	 0x002000000	   SDRAM

  or:
	 0x000000000	   SDRAM
	 0x002000000	   SRAM

    Absolut> I would be open to any other ways that SRAM / SDRAM might
    Absolut> be mapped to work, and still provide a performance increase
    Absolut> for the kernel.

  I think that you would be better to lock the relevant interrupt code
into the cache, if that is possible.
   
- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
]                    I'm a dad: http://www.sandelman.ca/lrmr/                 [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQtKEkYqHRg3pndX9AQFm6wP8C6xu9Wwbbv/eCr3UaZDcn4mEx35F28s1
eAdYxTqKREhewSJZH1QGn2QGBXxHKMlnBWttgmSYb814aXDeEzEKm3pLg45cB9nj
kU49kcDuyJ8Ug62/dFg9iZn4udfuJJHeaDNGITEwj2ov0RCENdJLsnCO33tZOjEs
Mz9qUutzG4g=
=DGvh
-----END PGP SIGNATURE-----
