From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.20030828152509.pochini@shiny.it>
References: <XFMail.20030828152509.pochini@shiny.it>
Message-Id: <1062078425.1290.139.camel@gaston>
Mime-Version: 1.0
Date: Thu, 28 Aug 2003 15:47:06 +0200
Subject: Re: Random crashes
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-08-28 at 15:25, Giuliano Pochini wrote:
> On 28-Aug-2003 Benjamin Herrenschmidt wrote:
> >> > Strange. I haven't been reported such problems. Can you try an older kernel
> >> > just in case ? Could also be bad ram...
> >>
> >> I tried 2.4.22 and I replaced the RAM. Nothing. Digging in the oops
> >> collection I found this one which doesn't look very nice:
> >>
> >> Jul 23 21:37:55 localhost kernel: Machine check in kernel mode.
> >> Jul 23 21:37:55 localhost kernel: Caused by (from SRR1=20009030): L1 Data Cache error
> >>
> >> I'll send the machine back for repair, altought I think they'll not even
> >> notice the problem because it happens sporadically :(((
> >
> > Well... I'm not 100% sure the message is correct, though from what you say,
> > it seems indeed there is a CPU fault...
>
> Yes, but it happened only once. All the others were "normal" segfaults, in both
> userspace and kernel space and hard lockups.

Did you try a few things like running single CPU and not enabling IRQ
distribution on all CPUs ?

> .../...
>
> Unrelated thing: tlbli instruction can cause problems on 7455 (bug.20).
> arch/ppc/kernel/head.S does not use the suggested workaround.

We don't use tlbli on 745x, only on 603s.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
