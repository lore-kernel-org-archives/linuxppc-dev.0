Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id AA6EDB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 06:37:29 +1000 (EST)
Received: by gxk26 with SMTP id 26so1627822gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 13:37:27 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <alpine.LFD.2.00.1007161629270.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
	<AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
	<1279310976.18579.8.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimKpmZaGRYfYs8HGDz-_VG8ePXN6bZvl2-YcNdR@mail.gmail.com>
	<alpine.LFD.2.00.1007161629270.10598@xanadu.home>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Jul 2010 14:37:07 -0600
Message-ID: <AANLkTinTBh2axb6UKETVoVJvOyAf_HTsTAU84yeAjUTR@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 16, 2010 at 2:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 16 Jul 2010, Grant Likely wrote:
>
>> On Fri, Jul 16, 2010 at 2:09 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Fri, 2010-07-16 at 19:46 +0100, Linus Torvalds wrote:
>> >> On Fri, Jul 16, 2010 at 11:40 AM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> >> >
>> >> > DOH.
>> >>
>> >> Well, it's possible that the correct approach is a mixture.
>> >>
>> >> Automatically do the trivial cases (recursive selects, dependencies
>> >> that are simple or of the form "x && y" etc), and warn about the case=
s
>> >> that aren't trivial (where "not trivial" may not necessarily be about
>> >> fundamentally ambiguous ones, but just "complex enough that I won't
>> >> even try").
>> >
>> > There is still a risk with this approach when the Kconfig isn't entire=
ly
>> > correct. For example, on ARM we have (I pushed a patch already):
>> >
>> > config CPU_32v6K
>> > =A0 =A0 =A0 =A0depends on CPU_V6
>> >
>> > config CPU_V7
>> > =A0 =A0 =A0 =A0select CPU_32v6K
>> >
>> > In this simple approach, we end up selecting CPU_V6 when we only need
>> > CPU_V7. There other places like this in the kernel.
>> >
>> > Of course, kbuild could still warn but if people rely on this feature =
to
>> > select options automatically I suspect they would ignore the warnings.
>>
>> In my first patch, I made Kconfig problems errors instead of warnings.
>> =A0That would prevent people from ignoring them.
>
> ACK.

It would also flush out any current Kconfig dependency issues.

g.
