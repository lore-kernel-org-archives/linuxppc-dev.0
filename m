Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt10s1yPpzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:19:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Besemer <thomas.besemer@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Network TX Stall on 440EP Processor
In-Reply-To: <CAO7m3AnPKavoBjmHJwuQ1y5ctyNk08eYB35M00ZiGgOwN4udvQ@mail.gmail.com>
References: <CAO7m3AnPKavoBjmHJwuQ1y5ctyNk08eYB35M00ZiGgOwN4udvQ@mail.gmail.com>
Date: Wed, 21 Jun 2017 20:19:40 +1000
Message-ID: <87zid1skw3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

Thomas Besemer <thomas.besemer@gmail.com> writes:
> I'm working on a project that is derived from the Yosemite
> PPC 440EP board.  It's a legacy project that was running the
> 2.6.24 Kernel, and network traffic was stalling due to transmission
> halting without an understandable error (in this error condition, the
> various
> status registers of network interface showed no issues), other
> than TX stalling due to Buffer Descriptor Ring becoming full.

I'm not really familiar with these boards, and I'm not a network guy
either, so hopefully someone else will have some ideas :)

This is the EMAC driver you're using, which is old but still used so
shouldn't have completely bit rotted.

I think the "Buffer Descriptor Ring becoming full" indicates the
hardware has stopped sending packets that the kernel has put in the
ring?

So did the driver get the ring handling wrong somehow and the device
thinks the ring is empty but we think it's full?

cheers
