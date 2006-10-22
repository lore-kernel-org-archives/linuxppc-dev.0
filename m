Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from cod.sandelman.ca (newcod.sandelman.ca [192.139.46.42])
	by ozlabs.org (Postfix) with ESMTP id 3C31467BBC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Oct 2006 11:07:12 +1000 (EST)
Received: from sandelman.ottawa.on.ca (extrud198.sandelman.ca
	[205.150.200.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "marajade.sandelman.ca.",
	Issuer "Michael Richardson" (verified OK))
	by cod.sandelman.ca (Postfix) with ESMTP id 5B32112BA1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 20:36:06 -0400 (EDT)
Received: from sandelman.ottawa.on.ca (unknown [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 1CC134E76F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 20:36:02 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to reserve memory in linux? 
In-Reply-To: Message from "Ming Liu" <eemingliu@hotmail.com> of "Sat,
	21 Oct 2006 14:22:25 -0000."
	<BAY110-F2BA131ED0055064C26658B2020@phx.gbl>
References: <BAY110-F2BA131ED0055064C26658B2020@phx.gbl> 
Date: Sat, 21 Oct 2006 20:36:01 -0400
Message-ID: <10436.1161477361@sandelman.ottawa.on.ca>
Sender: mcr@sandelman.ottawa.on.ca
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
Hash: SHA1


On x86, many BIOSs reported the wrong amount of memory.
Either they screwed up and reported too much (which means the system
would crash if it tried to use), or failed to report more than 64MB
of ram through that interface.

(Which was the physical limit on one generation of systems due to number
of pins that came out of processors/support chips/etc.) 

The point of mem= is to let you override it.
It only became useful later on to people who wanted contiguous DMA
regions.  Frankly: it's a terrible hack.  

On any reasonable embedded system you should get yourself sufficiently
involved in the linux memory management, and do it early enough
(i.e. not as a module. Why would you need modules on a single-purpose
embedded system, except because you want to play non-GPL games).

The question about whether or not the MMU is setup is nonsense --- you
don't understand the system properly. mem= is telling the system how
much PHYSICAL memory there is, not how much virtual address space setup.

On some architectures, the kernel gets a 1:1 mapping of all virtual to
physical, on others, you don't.  You can trivially add new mappings to
head.S, if you need them very early on, or you can map the physical
spaces afterward if you can deal later on.

- -- 
]            Bear: "Me, I'm just the shape of a bear."          |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBRTq834CLcPvd0N1lAQJdpQgAo0+sYTTi/FBgyFA3Lyn6HTNZ6xHQ0BMf
40h1B2qXvB0cWeGaHndfXFe04r3w0w/z0RKsjE5ultVxGO/WNBb8gCYDbmA/M4y0
DuTjMh+unn63o7iVwtJbPeSWA8T5KK8RW1y0NNRnwVzMkjzxo2IZbGblwreSXJWg
MF1Hsh79MTfIlpel7BkxFmcBWTUj16W0XQljmyBW6F5zK7DZ5di2WYbWKM+khzVs
ydlems1Nns8Qk8bI8s0Jq8NBx+J1VSV95qRvCtLIAfVyiO9lRZgeozvsB3Ri0cbA
C4usgAL4yUgUPG3DeN9PfL+uVELzWo1CyB7JOiyYDGYDKswau8vmoA==
=4THO
-----END PGP SIGNATURE-----
