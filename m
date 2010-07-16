Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 443FEB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:18:05 +1000 (EST)
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id o6GIHUKh031693
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jul 2010 11:17:30 -0700
Received: by gwaa20 with SMTP id a20so1354007gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 11:17:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100716180701.GA26854@n2100.arm.linux.org.uk>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<20100716180701.GA26854@n2100.arm.linux.org.uk>
Date: Fri, 16 Jul 2010 11:17:24 -0700
Message-ID: <AANLkTik_pGP2oI0UQmjiz7BndmvFXDs1G2b9Au15y6n1@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 16, 2010 at 11:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> I thought Linus' idea was to use:
>
> KBUILD_KCONFIG=file make allnoconfig

See an earlier reply - that is indeed what I suggested, and yes, it
avoids the need to be able to "unselect" things.

However, it turns out that even then you do want to extend the Kconfig
language with the ability to select particular values. Not for boolean
(or even tristate things), but for things that select an integer or
string value etc.

So the "select OPTION=xyz" syntax ends up being a good thing even for
the "-n" (allnoconfig) case too.

And while I think the allnoconfig model has some advantages (the
Kconfig input file ends up being independent of the default values),
that very fact ends up being a disadvantage too (the Kconfig input
file likely ends up being larger, since _hopefully_ the defaults are
sane).

So I'm not at all married to the "allnoconfig" model. It's one way of
doing things, but I think the argument that we should start with the
defaults and modify those instead is not an invalid one.

                     Linus
