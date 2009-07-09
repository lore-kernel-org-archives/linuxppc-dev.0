Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 88A17B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 07:22:26 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <4A565423.6010207@grandegger.com>
References: <4A565423.6010207@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 9 Jul 2009 15:22:03 -0600
Message-ID: <fa686aa40907091422v3e93fc50j5fc30f99077a8df6@mail.gmail.com>
Subject: Re: Bestcomm trouble with NAPI for MPC5200 FEC
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 9, 2009 at 2:33 PM, Wolfgang Grandegger<wg@grandegger.com> wrot=
e:
> Hello,
>
> I'm currently trying to implement NAPI for the FEC on the MPC5200 to
> solve the well known problem, that network packet storms can cause
> interrupt flooding, which may totally block the system.

Good to hear it!  Thanks for this work.

> The NAPI
> implementation, in principle, is straight forward and works
> well under normal and moderate network load. It just calls disable_irq()
> in the receive interrupt handler to defer packet processing to the NAPI
> poll callback, which calls enable_irq() when it has processed all
> packets. Unfortunately, under heavy network load (packet storm),
> problems show up:
>
> - With DENX 2.4.25, the Bestcomm RX task gets and remains stopped after
> =A0a while under additional system load. I have no idea how and when
> =A0Bestcom tasks are stopped. In the auto-start mode, the firmware should
> =A0poll forever for the next free descriptor block.
>
> - With 2.6.31-rc2, the RFIFO error occurs quickly which does reset the
> =A0FEC and Bestcomm (unfortunately, this does trigger an oops because
> =A0it's called from the interrupt context, but that's another issue).
>
> I'm realized that working with Bestcomm is a pain :-( but so far I have
> little knowledge of the Bestcomm limitations and quirks. Any idea what
> might go wrong or how to implement NAPI for that FEC properly.

Yes, I have a few ideas.  First, I suspect that the FEC rx queue isn't
big enough and I wouldn't be surprised if the RFIFO error is occurring
because Bestcomm gets overrun.  This scenario needs to be handled more
gracefully.

Second, I think resetting the PHY should be removed from the reset
path.  The phy doesn't at all need to be reset and doing this would
avoid the OOPS condition.  Also, in the RFIFO error path needs to be
audited to make sure that all the good received packets are processed
correctly before resetting the BCOM engine and to make sure that
skbufs are not getting leaked.

Essentially, I think that the RFIFO error condition is currently
handled in far too heavy handed a manner and it should not be
expensive to recover from.

Thanks for this work!
g..

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
