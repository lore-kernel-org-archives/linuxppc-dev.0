Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E94F67BF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Oct 2006 23:20:46 +1000 (EST)
Message-ID: <4534D8A5.7060206@varma-el.com>
Date: Tue, 17 Oct 2006 17:20:37 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Andrea Galbusera <andrea.galbusera@teamware.it>
Subject: Re: JFFS2 on Lite5200
References: <1161081183.22948.58.camel@localhost.localdomain>
In-Reply-To: <1161081183.22948.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dedekind@yandex.ru, linux-mtd@lists.infradead.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Andrea,

Andrea Galbusera wrote:
> Hello.
> 
> I'm currently using linux-2.6.16 from denx on a Lite5200 V2.0. I need to
> access a JFFS2 filesystem on the onboard flash ( 16MB Am29L652D ).
> 
> I see the flash using physmap driver and cmdline partitions.
> I experience a problem when creating files on JFFS2 with filename longer
> than a few characters. They appear to be created correctly with the
> content I want, but, after unmounting and remounting the filesystem they
> result unreadable and ls complains with "no such file or
> directory" (short-named files are ok).
--snip--

OMG, again same question,

Andrea, check ml archive, I already sent patch half-year ago
(http://ozlabs.org/pipermail/linuxppc-embedded/2006-April/022566.html)
Problem is in alignment/memcpy: JFFS2 code assumed that memory at
unaligned addresses could be touched, but access to an external MMIO
on MPC5200 _must_ be aligned (i.e. you could not read u32 from odd address).

P.S. Artem, I repeat, I sent this patch _HALF_YEAR_AGO_
how about to fix scan.c?

--
Regards
Andrey
