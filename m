Message-ID: <4072E904.7010409@fh-landshut.de>
Date: Tue, 06 Apr 2004 19:29:40 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch Preview for MVME2100
References: <Pine.LNX.4.33.0404041321400.21042-200000@lux32.if.fh-landshut.de> <20040405172348.GS31152@smtp.west.cox.net> <4071A024.6020005@fh-landshut.de> <20040405183052.GU31152@smtp.west.cox.net>
In-Reply-To: <20040405183052.GU31152@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

Applied changes today, and the serial console is coming along nicely,
can log into my board, use ethernet, boot off NFS. :)

I'm very happy and very grateful. Thank you!

>>Maybe the CONFIG_EPIC_SERIAL_MODE should be set, shouldn't it? Will add
>>it tomorrow. Should I add that cascade hookup stuff even if there is no
>>cascaded 8259?
>>
>>
>
>You don't need to call openpic_hookup_cascade, if there is no cascade.
>You only want to set EPIC_SERIAL_MODE if the controller really is in
>serial mode.
>
>
>
As far as I can see from the (sometimes very unspecific) documentation
for the MVME2100 and from the probing in the Linux kernel there doesn't
seem to be an external interrupt (= no 8259) on-board. So I guess I
could drop CONFIG_EPIC_SERIAL_MODE, because I don't need to probe for
interrupts on that source, do I? (I'm a bit confused about that, because
I delved a bit in the MPC107, the LoPEC board, the MPC8240 and the
MVME2100 manuals without very clear info about that)

Can I drop

       /* Map serial interrupts 0-15 */
       openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);

too? No connected 8259 should mean no interrupt sources there, I guess.

>No.  The '0's are wrong.  You only need to describe, in terms of
>level/edge, documented interrupts.  You then make multiple calls to
>openpic_set_sources(), to skip over the non-existant interrupts.
>
>
>
For initial testing I have still 0s in there - for the unused interrupts
within the range after the external interrupts. I get a bad interrupt at
1 - this would be the first interrupt in the cascade I guess, but
interrupts of the ethernet and the UART serial (17  - 2nd internal
interrupt and 29 - 13th internal interrupt) work just fine - console is
responsive, ethernet is stable and fine.

A very big "Thank" You! indeed. Your advice was indispensable for my
work and it was to the point, too.

I will try to clean up that patch, with an eye to the Sandpoint and
LoPEC platforms for guidelines, and I hope I can find the time to port
it to 2.6.x, too. Unfortunately this is a very tightly scheduled project
with very ambitious goals (evaluating VME bus with realtime Linux at
minimum on the MVME2100, and possibly on the MVME5500 and VMIVME7050 as
well), so this could be some time in the future. But cleaning up my
current patch is certainly necessary and is already my task for the next
time, so that I'll do for sure.

With kind regards,
Oliver Korpilla


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
