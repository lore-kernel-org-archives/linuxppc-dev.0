Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11AF7B6F6F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 19:22:18 +1000 (EST)
Received: by pwj3 with SMTP id 3so299659pwj.15
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 02:22:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DA3DAF6.9090909@embedded-sol.com>
References: <071A08F2C6A57E4E94D980ECA553F87417069A@039-SN1MPN1-004.039d.mgd.msft.net>
	<45903308677306428B6EE7E6FF5A520410B713@039-SN1MPN1-004.039d.mgd.msft.net>
	<4DA3DAF6.9090909@embedded-sol.com>
Date: Wed, 13 Apr 2011 11:22:14 +0200
Message-ID: <BANLkTimicG2n=h0pX0JpLZffM0q+-P6o1Q@mail.gmail.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Felix Radensky <felix@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix,

On Tue, Apr 12, 2011 at 6:54 AM, Felix Radensky <felix@embedded-sol.com> wrote:
> On 04/12/2011 07:05 AM, Aggrwal Poonam-B10812 wrote:
>> As such there is no hardware fix related to this issue between RevC to
>> RevD. The solution was a software patch to resolve the issue related to
>> IRQ0.
>
> Are you sure ? Please take a look at Freescale document titled
> "P1020E/P2020E RDB System Errata".
> There's errata CE10, IRQ0 held low. It is fixed in Rev D. Vivek Mahajan, who
> looked at the issue back
> in 2009, estimated that problem can be related to missing pull-up on IRQ0.
> This is exactly what is
> fixed in Rev D.
>

That's my understanding as well.

Check if R420 and R423 are populated. These are the required pull-ups.
On Rev D they are populated. You might be able to add them yourself.

Even if you have an Rev A-C PCB, this fix can already be applied; it
was on my board! (the bottom of the board mentions the schematic
revision)

The resistors have a silkscreen designator block called X, the
resistors are situated to the left and bottom of the silkscreen X.
IIRC, between the flash and Px020 part.

On the left side of R420 (or R423) I measured the block wave from the
RTC, which fires the 32kHz interrupt rate on IRQ0. This fixed by the
u-boot patch.

Regards,

Leon.
