Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 00ECFDE4D5
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 06:40:17 +1000 (EST)
Received: by gxk14 with SMTP id 14so2671427gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 13:40:16 -0700 (PDT)
Message-ID: <fa686aa40808141340o42250512nd2d34ee3a5f37a10@mail.gmail.com>
Date: Thu, 14 Aug 2008 14:40:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH v2] powerpc: add ioremap_early() function for mapping
	IO regions before MMU_init()
In-Reply-To: <4A0D4C49-48F8-4E0D-9C42-EB0503EA4BCB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
	<1C19524E-8400-4F61-AEB1-19CF20E71098@kernel.crashing.org>
	<fa686aa40808140800s417af75ex76ae73ec990be58d@mail.gmail.com>
	<9E78DE5E-7B94-4990-81CB-1EBF806923C1@kernel.crashing.org>
	<fa686aa40808140943v218d826p9ac6dc683a5ccff4@mail.gmail.com>
	<4A0D4C49-48F8-4E0D-9C42-EB0503EA4BCB@kernel.crashing.org>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 1:59 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Aug 14, 2008, at 11:43 AM, Grant Likely wrote:
>
>> On Thu, Aug 14, 2008 at 10:24 AM, Kumar Gala <galak@kernel.crashing.org>
>> wrote:
>>>>>
>>>>> what happens if we run out of bats?
>>>>
>>>> Then it returns NULL and the caller must handle it.  The board port
>>>> maintainer needs understand the board/CPU/SoC and not depend on more
>>>> BATs than are available.  They also need to understand that there is a
>>>> tradeoff between BATs for IO and BATs for RAM.  If the board port uses
>>>> up all the BATs for IO, then RAM above 256MB ends up getting mapped
>>>> with PTEs and there is a performance hit.  My expectation is that only
>>>> platform code will use this facility.  Device drivers should continue
>>>> to use ioremap() and will gain the benefit of the BATs if platform
>>>> code already set them up.  I can add some text to the documentation to
>>>> describe this.
>>>>
>>>> I'm not going to make any attempt to fallback to PTEs for IO when
>>>> there isn't enough BATs.  Doing so adds an order of magnitude more
>>>> complexity.
>>>
>>> that's fine.. I just didn't look at setbat() to see it errors out.
>>>
>>> Also can we get rid of LOAD_BAT in head_32.S?
>>
>> Mostly.  It is still needed for BAT0 when setting up RAM, but the rest
>> of it can be dumped.
>
> Can we not do BAT0 in C code?

Not easily.  Currently BAT0 gives us the first 16M of RAM during early
boot.  The new code protects BAT0 and makes sure it can only be used
for mapping RAM.  If it got chosen for an IO mapping, then it would
get blown away immediately and the kernel would crash.  Its okay for
BAT0 to be used for RAM because RAM doesn't need to be immediately
mapped.  It can wait just setup the data and wait for LOAD_BAT to fix
it up.

An alternate solution is to reserve a second BAT higher up to use as
the 'real' RAM mapping so that 'real' mapping of RAM could be
performed immediately while leaving the old one intact.  That would
eliminate the need for LOAD_BAT, but it also leaves only 2 BAT slots
available for IO and memory above 256M.  On the other hand, it might
be okay to release the reserved BATs after the first real RAM mapping
is established, but doing so adds some complexity to the handling of
__map_without_bats because the initial mapping still needs to be
disabled in head_32.S.

g.
