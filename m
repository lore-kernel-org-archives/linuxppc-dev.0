Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 3D3B2B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 12:55:38 +1100 (EST)
Received: by wyb42 with SMTP id 42so6730078wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Oct 2010 18:55:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1286327715-sup-584@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-6-git-send-email-imunsie@au1.ibm.com>
	<AANLkTins34TrEWj618_4XBRwGGFqRSehwWEp7jBubvsu@mail.gmail.com>
	<1286327715-sup-584@au1.ibm.com>
Date: Tue, 5 Oct 2010 21:55:35 -0400
Message-ID: <AANLkTimNeWEo5P0wXzszBiSYdh81=uhARA8KZPr7rcPf@mail.gmail.com>
Subject: Re: [PATCH 05/18] powerpc: Wire up 44x little endian boot for
	remaining 44x targets
From: Josh Boyer <jwboyer@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 5, 2010 at 9:28 PM, Ian Munsie <imunsie@au1.ibm.com> wrote:
> Excerpts from Josh Boyer's message of Fri Oct 01 21:27:37 +1000 2010:
>> > From: Ian Munsie <imunsie@au1.ibm.com>
>> >
>> > I haven't tested booting a little endian kernel on any of these target=
s,
>> > but they all claim to be 44x so my little endian trampoline should wor=
k
>> > on all of them, so wire it up on:
>> >
>> > bamboo
>> > katmai
>> > kilauea
>> > rainer
>> > sam440ep
>> > sequoia
>> > warp
>> > yosemite
>> > ebony
>>
>> I see no reason to do this at all. =A0If you haven't tested them and
>> there is no demand, there's no reason to wire them up. =A0Some might
>> actively want to disallow LE mode anyway, like the Warp or Sam440EP.
>
> I wasn't aware that the Warp and Sam440EP disallowed LE mode - I'll
> definitely unwire them and move the ARCH_SUPPORTS_LITTLE_ENDIAN to just
> the sub-arch's that support it.

Well, Warp and Sam440EP are production boards for actual companies.
The rest are all just eval boards.  I don't know if the board
maintainers care either way, I was just using them as examples of
cases where someone might.

> As for the other boards, I would like to wire them up if they are able
> to support LE mode - If anyone has one handy I would love to hear if
> they are able to begin booting a LE kernel with these patches, or when &
> how they fail.

I'd avoid anything with an FPU until that gets tested.  So no bamboo,
sequoia, canyonlands, etc.

I noticed that canyonlands isn't even covered.  I'm guessing that's
because we don't need to create a wrapper for it because U-Boot does
direct loading of vmlinux and the DTB itself.  Has anyone done any
work with getting U-Boot to work in LE mode or at least load LE
vmlinux images?  The majority of new boards are going to be using
U-Boot and it's ability to load the DTB/FDT, so that would be
something that needs addressing.

josh
