Message-ID: <392E2B84.EA7BE0DB@da-san.com>
Date: Fri, 26 May 2000 16:45:08 +0900
From: Seungdong Lee <sdlee@da-san.com>
MIME-Version: 1.0
To: Marcus Sundberg <marcus@cendio.se>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com> <3926CD15.441C87AB@embeddededge.com> <vehfbtasi8.fsf@lipta.cendio.se> <39289DA5.F0A5B8FF@da-san.com> <vevh07dj26.fsf@lipta.cendio.se>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Seungdong Lee <sdlee@da-san.com> writes:
>
> > Marcus Sundberg wrote:
> > > I'm not very familiar with 82x0 processors, but doesn't 8240 use a
> > > 603-core? When I worked with a 603ev running at 200 MHz I got
> > > something like 133 BogoMIPS, so then the above value would be correct.
> > >
> >
> > Good information.
> > But, why it is 133 BogoMIPS?
>
> Because that's what a 200 MHz PowerPC 603 gives you.
> Checking the BogoMIPS howto will show you one report of a 603,
> running at 100 MHz and giving 66 BogoMIPS, which is at par with
> our results.
>
> > I still think that the correct value is 400.
>
> Unless you have tried other 603-based sytems you have no reason to
> think so. I repeat my statement from the previous post:
>
> > > The BogoMIPS can be used for rough sanity-checks when comparing
> > > processors with identical cores and different clocks. For anything
> > > else it's completely useless.
>
> //Marcus
> --
> -------------------------------+-----------------------------------
>         Marcus Sundberg        |       Phone: +46 707 452062
>   Embedded Systems Consultant  |      Email: marcus@cendio.se
>        Cendio Systems AB       |       http://www.cendio.com

Hi guys, I got a reply from Motorola about instruction timing of bdnz. Conclusion is that it needs 3 cycles in 603.
E-mail from Motorola is attached.

-- Seungdong Lee


DigitalDNA Help wrote:

> Dear Seungdong Lee,
>
> in reply to your Service Request SR 1-UC2R (see details below):
>
> Instruction flow is discribed in "MPC603e & EC603e RISC Microprocessors
> User's Manual" Chapter 6.3.
>
> BDNZ command executes as follow : fetch, dispatch, execute, writeback.
> Last three steps are necessary to modify CTR. While first command
> doesn't complete execute phase, next BDNZ command can't be dispatched
> since they use CTR register both. So instruction takes up 3 cycles.
>
> I should note that if your loop isn't the void one then BDNZ latency can
> occupy even 0 cycles. For example:
>
> _L: add
>     subf
>     subf
>     bdnz _L
>
> While executing of subf, bdnz will be prefetched and executed, moreover
> due to static branch prediction add command will be speculatively
> executed without awaiting of branch being executed. BDNZ effective cycle
> time equals 0.
>
> ------- Details of your request: -------
>
> Date Opened :   05/25/2000 00:10:46
> Product :       XPC8240LZU200C
> Category:       Technical Request
>
> ---------- Subject ----------
> 8240 or 603e instruction timing
>
> ---------- Description ----------
>    mtctr r3
> 1: bdnz 1b
>
> If r3 is 200*1000*1000,
> how long does it take for MPC8240/200MHz CPU to execute bdnz loop?
> I think that it should take only 1 second. But, the result is 3
> seconds. Can you explain my result?
>
> Manual says that branch instruction consumes only 1 CPU clock.
> Apparently it is not true in my case. I found that other 603 based board
> shows similar result. BogoMIPS value from Linux community can be the
> evidence. BogoMIPS is 2*(loops per second)/1000000.
>
> Platform           BogoMIPS  Reported by
> PowerPC 603/100    66.56     A. Costa
> <c_chaos@chaosnet.wahnapitae.on.ca>
> PowerPC 603/200    131.19    Marcus Sundberg <marcus@cendio.se>
>
> MPC8240/200        131.48    This is my result.
>
> Expected value is 400 in my case.
>
> Can I have any reasonable explanation about this?
> Thanks.
>
> -- Seungdong Lee
> ------- End of request details -------
>
>
> To review or update this Service Request, or to enter a new Service Request, please access Motorola's Customer Support web site at
> http://www.motorola.com/semiconductors/support
>
> If there is ever an occasion when you cannot access Motorola's Customer Support web site, you can also contact us by sending an email to
> DigitalDNA.Help@motorola.com
> or by calling us at one of the following numbers:
>
> Americas                1-800-521-6274          7AM-6PM Phoenix
> Asia                    +852-2666-8307          8AM-6PM Hong Kong
> Japan                   0120-191-014            8AM-5PM Tokyo
> Europe                  +49-89-92103-559        9AM-5PM Munich
>
> Regards,
> Motorola Semiconductors Customer Support


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
