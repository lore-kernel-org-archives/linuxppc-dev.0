Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 512141007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:52:11 +1000 (EST)
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id o6GIppJQ003517
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jul 2010 11:51:52 -0700
Received: by gxk26 with SMTP id 26so1564508gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 11:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.1007161439240.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
Date: Fri, 16 Jul 2010 11:46:17 -0700
Message-ID: <AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 16, 2010 at 11:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> DOH.

Well, it's possible that the correct approach is a mixture.

Automatically do the trivial cases (recursive selects, dependencies
that are simple or of the form "x && y" etc), and warn about the cases
that aren't trivial (where "not trivial" may not necessarily be about
fundamentally ambiguous ones, but just "complex enough that I won't
even try").

Maybe a full "solver" is unnecessary, for example, but just a simple
"automatically enable the direct dependencies and scream when it's not
simple any more" would take care of 99% of the common cases, and then
warn when it needs some manual help.

So it's not a strict "one or the other" issue. The solution could be
"some of both".

                     Linus
