Date: Thu, 1 Aug 2002 23:36:49 -0700
Subject: Re: symbol card with orinoco_cs on mpc823
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc-embedded@lists.linuxppc.org
To: David Gibson <david@gibson.dropbear.id.au>
From: Matthew Locke <mlocke@mvista.com>
In-Reply-To: <20020802062324.GD5012@zax>
Message-Id: <39044C84-A5E2-11D6-A3EA-0003939A0A86@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thursday, August 1, 2002, at 11:23 PM, David Gibson wrote:

>
> On Fri, Aug 02, 2002 at 02:01:52PM +0800, shaowei dai wrote:
>>
>> Hello,
>>
>> Has anybody tried orinodo_cs 0.11b or 0.12b with success on symbol
>> Spectrum24 High rate11M card on mpc platform?
>> I've tried 2.4.18-pre3 and 2.4.19-rc3 kernel with orinoco driver. It
>> works
>> fine with intersil card. But
>> when i try it on symbol card, it always crashes. After tracing down i
>> find
>> it is caused by hermes_init(). It seems the
>> call to hermes_write_regn(hw,INTEN,0)  cause the crash. The ksymoops
>> also
>> suggest this function. It is just an io write. What can be wrong? And
>> most
>> strange thing is why it doesn't cause any trouble in normal intersil
>> card.
>
> That's wierd - it is just a register write, so this sounds like a
> low-level problem.  Is something about the card confusing the PCMCIA
> system so it's reporting the wrong IO addresses?  Or maybe the timing
> is a little bit different and something in the slot driver can't cope.
>

I would guess timing.  I have seen problems between different cards with
the same chipset fail on 8xx.  Usually timing is the culprit.

> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.
> http://www.ozlabs.org/people/dgibson
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
