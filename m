Message-Id: <5.1.0.14.2.20031012235137.02e9d9a8@mail.ebshome.net>
Date: Mon, 13 Oct 2003 00:03:38 -0700
To: "Jacky Lam" <jackylam@astri.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Walnut PCI bridge can't be detected
Cc: <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <002801c39153$f76fd3c0$2803050a@JackyLam>
References: <001d01c39133$20f088a0$2803050a@JackyLam>
 <5.1.0.14.2.20031012203903.02e546d8@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:33 PM 10/12/2003, Jacky Lam wrote:

> > Also, according to the log you posted bus enumeration was successful and
> > your device (es1371) was found. So I don't think you have a problem with a
> > bridge.
> >
> > FYI, bridge is not responsible for delivering IRQs from your card. IRQ
> > lines from the PCI slots are directly wired to the UIC (see
> > walnut::ppc405_map_irq for actual mapping).
>
>     Yes, I know. Let me clarify my question again...Sorry for my blur
>question.
>     What I mean is:
>         Will there some miss configuration of bridge which will affect the
>behavior of PCI cards/slots?

Well, simple answer is "yes". But usually such misconfiguration will
completely disable kernel access to PCI peripherals or lockup the box
(which is not your case). This is why I think it's unlikely.

4xx bridges are quite simple to configure and default setup should be OK,
especially on reference platform like Walnut.

Broken (on PPC) driver is more probable cause for your problems.

> > If you still suspect that you have bridge problem, just insert some other
> > PCI card which is know to be supported by PPC kernel and see...
>
>     Yes. Is there a list of popular PCI cards which are supported by PPC
>kernel directly without need of any modifications?

I'm not aware of any list available on-line.

Personally I successfully used SCSI card from LSI.
IIRC some NICs were reported to work on 4xx ref platforms (e.g. tulip).

I think MV guys here can answer this question better :)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
