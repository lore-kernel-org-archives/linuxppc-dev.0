Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 4A2B01007E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:52:51 +1000 (EST)
Received: by gxk26 with SMTP id 26so1565184gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 11:52:49 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100716183028.GB26854@n2100.arm.linux.org.uk>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Jul 2010 12:52:29 -0600
Message-ID: <AANLkTilSHe2KD-2LJeUZp-I30LgfjCCPuJnObVzG4Bzo@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, Jul 16, 2010 at 12:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 16, 2010 at 02:19:31PM -0400, Nicolas Pitre wrote:
>> For example, if I want CONFIG_MTD_CMDLINE_PARTS=3Dy, the system may be
>> smart enough to notice and automatically enable CONFIG_MTD and
>> CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.
>
> How do you sort out something like this:
>
> config FOO
> =A0 =A0 =A0 =A0bool "Foo"
> =A0 =A0 =A0 =A0depends on (A && B) || C
>
> Do you enable A and B, A, B and C or just C?
>
> Bear in mind that A could be 'X86', 'M68K' or any other arch specific
> symbol.
>
> I prefer the warning method because it prompts you to investigate what's
> changed and sort out the problem by ensuring that the appropriate symbols
> are also selected. =A0The automatic selection of dependencies method carr=
ies
> the risk that it'll do the wrong thing with the above scenario.

Good point.

g.
