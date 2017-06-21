Return-Path: <thomas.besemer@gmail.com>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtJLc2ZL1zDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 07:51:04 +1000 (AEST)
Received: by mail-oi0-x231.google.com with SMTP id c189so75223791oia.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 14:51:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zid1skw3.fsf@concordia.ellerman.id.au>
References: <CAO7m3AnPKavoBjmHJwuQ1y5ctyNk08eYB35M00ZiGgOwN4udvQ@mail.gmail.com>
 <87zid1skw3.fsf@concordia.ellerman.id.au>
From: Thomas Besemer <thomas.besemer@gmail.com>
Date: Wed, 21 Jun 2017 14:51:01 -0700
Message-ID: <CAO7m3Anq5JOYKkM-myWH_=AAncbzzQ8pfGJt93GKkhAON7QiZg@mail.gmail.com>
Subject: Re: Network TX Stall on 440EP Processor
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael -

>
> Thomas Besemer <thomas.besemer@gmail.com> writes:
> > I'm working on a project that is derived from the Yosemite
> > PPC 440EP board.  It's a legacy project that was running the
> > 2.6.24 Kernel, and network traffic was stalling due to transmission
> > halting without an understandable error (in this error condition, the
> > various
> > status registers of network interface showed no issues), other
> > than TX stalling due to Buffer Descriptor Ring becoming full.
>
> I'm not really familiar with these boards, and I'm not a network guy
> either, so hopefully someone else will have some ideas :)
>
> This is the EMAC driver you're using, which is old but still used so
> shouldn't have completely bit rotted.
>
> I think the "Buffer Descriptor Ring becoming full" indicates the
> hardware has stopped sending packets that the kernel has put in the
> ring?
>
> So did the driver get the ring handling wrong somehow and the device
> thinks the ring is empty but we think it's full?
>

Thanks for the feedback.  I'm continuing to look into it, but I should add
to this discussion that when TX stalls, the Ready bit (bit 0) is set in the
TX Status/Control field of all the Buffer Descriptors.  This is what is
perplexing, as TX is enabled, and all BD's are marked as having
valid data.

I've looked to see if there are PLB errors, but cannot see any, and the
MAL/EMAC registers all seem valid.  It simply appears that it stops
sending data for no reason.
