Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9AD5CB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 17:37:33 +1000 (EST)
Message-ID: <4A56EFB5.1020309@grandegger.com>
Date: Fri, 10 Jul 2009 09:37:25 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Bestcomm trouble with NAPI for MPC5200 FEC
References: <4A565423.6010207@grandegger.com>
	<fa686aa40907091422v3e93fc50j5fc30f99077a8df6@mail.gmail.com>
In-Reply-To: <fa686aa40907091422v3e93fc50j5fc30f99077a8df6@mail.gmail.com>
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

Grant Likely wrote:
> On Thu, Jul 9, 2009 at 2:33 PM, Wolfgang Grandegger<wg@grandegger.com> wrote:
>> Hello,
>>
>> I'm currently trying to implement NAPI for the FEC on the MPC5200 to
>> solve the well known problem, that network packet storms can cause
>> interrupt flooding, which may totally block the system.
> 
> Good to hear it!  Thanks for this work.
> 
>> The NAPI
>> implementation, in principle, is straight forward and works
>> well under normal and moderate network load. It just calls disable_irq()
>> in the receive interrupt handler to defer packet processing to the NAPI
>> poll callback, which calls enable_irq() when it has processed all
>> packets. Unfortunately, under heavy network load (packet storm),
>> problems show up:
>>
>> - With DENX 2.4.25, the Bestcomm RX task gets and remains stopped after
>>  a while under additional system load. I have no idea how and when
>>  Bestcom tasks are stopped. In the auto-start mode, the firmware should
>>  poll forever for the next free descriptor block.

Do you know when the Bestcomm firmware does stop the task? I have the
impression that it happens when all buffer descriptors are used (RX
queue full).

>> - With 2.6.31-rc2, the RFIFO error occurs quickly which does reset the
>>  FEC and Bestcomm (unfortunately, this does trigger an oops because
>>  it's called from the interrupt context, but that's another issue).
>>
>> I'm realized that working with Bestcomm is a pain :-( but so far I have
>> little knowledge of the Bestcomm limitations and quirks. Any idea what
>> might go wrong or how to implement NAPI for that FEC properly.
> 
> Yes, I have a few ideas.  First, I suspect that the FEC rx queue isn't
> big enough and I wouldn't be surprised if the RFIFO error is occurring
> because Bestcomm gets overrun.  This scenario needs to be handled more
> gracefully.

The RFIFO error does not show up with DENX 2.4.25 and therefore I'm not
sure if overruns are a real problem.

> Second, I think resetting the PHY should be removed from the reset
> path.  The phy doesn't at all need to be reset and doing this would
> avoid the OOPS condition.  Also, in the RFIFO error path needs to be
> audited to make sure that all the good received packets are processed
> correctly before resetting the BCOM engine and to make sure that
> skbufs are not getting leaked.

Agreed, the manual says: "When this occurs, software must ensure both
the FIFO Controller and BestComm are soft-reset."

> Essentially, I think that the RFIFO error condition is currently
> handled in far too heavy handed a manner and it should not be
> expensive to recover from.

Yep, it looks like.

Wolfgang.
