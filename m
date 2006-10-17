Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E518167C04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Oct 2006 23:54:05 +1000 (EST)
Message-ID: <4534E078.9030301@varma-el.com>
Date: Tue, 17 Oct 2006 17:54:00 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: dedekind@infradead.org
Subject: Re: JFFS2 on Lite5200
References: <1161081183.22948.58.camel@localhost.localdomain>	
	<4534D8A5.7060206@varma-el.com> <1161092193.3260.61.camel@sauron>
In-Reply-To: <1161092193.3260.61.camel@sauron>
Content-Type: text/plain; charset=UTF-8
Cc: Andrea Galbusera <andrea.galbusera@teamware.it>,
	linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Artem Bityutskiy wrote:
> On Tue, 2006-10-17 at 17:20 +0400, Andrey Volkov wrote:
>> P.S. Artem, I repeat, I sent this patch _HALF_YEAR_AGO_
>> how about to fix scan.c?
> 
> Andrey,
> 
> I am not JFFS2 maintainer, David Woodhouse is.
Ok, I'll keep it in mind.

> 
> Just looked into your patch. I agree that it may make sense to teach
> JFFS2 to use only aligned addresses, but your patch changes
> include/asm-ppc/io.h which is probably not MTD's business. 
> It probably
> makes sense to submit these changes to a PPC maintainer separately.
> 
> A question - does this mean that one can write only 4-byte chunks to
> this NOR (?) flash?
> 
No, MPC5200 could write any size chunks, but it must be aligned (same
restrictions as in SH4), and this restriction applied only to LPB, but
not SDRAM.

Also, I've in view that jffs2(jffs3 ?) read/write stuff already used
functions which MTD drivers exported, but jffs2_scan_dirent_node and
friends - doesn't.

Andrey
