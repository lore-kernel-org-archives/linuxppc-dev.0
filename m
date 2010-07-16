Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id 6C6BCB6F29
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:18:53 +1000 (EST)
Received: by ywa6 with SMTP id 6so256499ywa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 11:18:51 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100716180701.GA26854@n2100.arm.linux.org.uk>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<20100716180701.GA26854@n2100.arm.linux.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Jul 2010 12:18:29 -0600
Message-ID: <AANLkTilfgiQyvcBhEmdc5P8HXSUHgAG7SUa0Mz4ev6ze@mail.gmail.com>
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

On Fri, Jul 16, 2010 at 12:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 16, 2010 at 11:57:55AM -0600, Grant Likely wrote:
>> Last missing piece is being able to do "select FOO =3D n", which Stephen
>> is currently working on.
>
> I thought Linus' idea was to use:
>
> KBUILD_KCONFIG=3Dfile make allnoconfig

That was more a prototype of the idea; but it's a pretty cumbersome
user interface.  :-)  By changing the makefile to look for kconfig
fragments in the configs directory, the user interface for choosing a
config remains exactly the same.

As for the allnoconfig bit....

> in which case any option which would be presented to the user which hasn'=
t
> been selected by 'file' ends up being set to n. =A0That means there's no
> need for a special "select FOO=3Dn" construct.

...Linus chimed in on this that he doesn't actually care much.  I
think defconfig with an empty initial config file makes a lot more
sense than allnoconfig so that we're using the default values from the
normal Kconfig files.

> See one of Linus' replies on June 3:
> Message-ID: <alpine.LFD.2.00.1006031317410.8175@i5.linux-foundation.org>

See this response:
Message-ID: <AANLkTik-QCXFnjma3J28B9h27uajOcDhthTGz99zKgVi@mail.gmail.com>

http://news.gmane.org/find-root.php?message_id=3D%3cAANLkTik%2dQCXFnjma3J28=
B9h27uajOcDhthTGz99zKgVi%40mail.gmail.com%3e

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
