Return-Path: <annamaya@yahoo.com>
Received: from web53810.mail.yahoo.com (web53810.mail.yahoo.com
	[206.190.36.205]) by ozlabs.org (Postfix) with SMTP id 2750667A83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jan 2005 09:42:03 +1100 (EST)
Message-ID: <20050124224201.22433.qmail@web53810.mail.yahoo.com>
Date: Mon, 24 Jan 2005 14:42:01 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: annamaya <annamaya@yahoo.com>, Mark Chambers <mchambers@microfirst.com>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <20050124151131.769.qmail@web53802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Kernel booting issues on a MPC8270 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I finally figured out my problem had to do with the
fact that my MPC8270 processor was not supported in
the cpu table. I was able to find the definition for
82xx, HiP7 603e entry for CPU table in the 2.4.24 from
denx and copied that table into the cpu table of the
MVista kernel. Otherwise, the cpu_spec[] structure was
defaulting to some entry that set the
CPU_FTR_HPTE_TABLE option in the cpu_spec which
resulted in execution of some code in
cacheable_memzero() routine that resulted in resetting
my CPU and my board. 

Sorry for all the noise but I thought I should share
my debug experience here since someone else might go
through this trying to run MVista kernel on a HiP7
82xx processor.

And for the record, the kernel from denx works great.
I was just trying to figure out why the MVista one
wasn't working.

Thanks for everyone's input on this.

--- annamaya <annamaya@yahoo.com> wrote:

> As someone who has worked on the 8xx processors
> before, I went looking for the DER for the 8270 but
> was unable to find such a register. If someone can
> point me to such a register on the 8270, I would
> really appreciate it.
> 
> It looks like single-stepping doesn't work till
> later
> in the Kernel. Anyways, I found out after much
> debugging that it wasn't the first instruction that
> the break was occuring but the code made it all the
> way to the "cacheable_memzero" routine and fails in
> the "dcbz" instruction. The cpu gets reset as soon
> as
> I try to single-step this instruction. Any ideas as
> to
> why this is happening?
> 
> --- Mark Chambers <mchambers@microfirst.com> wrote:
> 
> > I'm not familiar with the 8270 per se, but on the
> > 8xx you've got this Debug
> > Enable Register (DER) where you set different bits
> > for things you want the
> > processor to jump into debug mode when they
> happen. 
> > You might need to play
> > with that to get the BDI to catch whatever is
> > happening.  It's probably set
> > in the BDI config file somewhere.
> > 
> > ----- Original Message ----- 
> > From: "annamaya" <annamaya@yahoo.com>
> > To: "annamaya" <annamaya@yahoo.com>;
> > <linuxppc-embedded@ozlabs.org>
> > Sent: Friday, January 21, 2005 4:20 PM
> > Subject: Re: Kernel booting issues on a MPC8270
> > board
> > 
> > 
> > > I am sorry but I dont believe the "mfpvr"
> > instruction
> > > has anything to do with it. I thought removing
> it
> > was
> > > getting rid of the problem but I was wrong. The
> > board
> > > still gets reset when the very first instruction
> > is
> > > executed. I am stumped.
> > >
> > > --- annamaya <annamaya@yahoo.com> wrote:
> > >
> > > > I debugged this problem a little more and
> > realized
> > > > that the reset was happenning right after the
> > > > execution of the first kernel instruction at
> > > > 0x0000000c. The instruction at this location
> was
> > > > "mfpvr r28". I traced this back to a snippet
> of
> > code
> > > > that was dealing with pipeline depth issues on
> > the
> > > > MPC8260. Once I commented this code out, more
> > > > instructions were issued but the reboot
> happens
> > > > elsewhere. I am not able to pin-point the
> > location
> > > > of
> > > > the debug since my BDI fails to catch the
> reset
> > when
> > > > it happens. Can someone point me to the cause
> of
> > > > this
> > > > situation? Thanks in advance.
> > > >
> > > > --- annamaya <annamaya@yahoo.com> wrote:
> > > >
> > > > > I am trying to boot a mvista Linux Kernel
> ver.
> > > > > 2.4.20
> > > > > on  a MPC8270 board. I am using the
> > embed_config()
> > > > > in
> > > > > zImage to pass the board info since the
> > bootloader
> > > > > is
> > > > > not ppcboot. After the message, "Now booting
> > the
> > > > > kernel", the board just reboots, as if
> someone
> > > > > yanked
> > > > > the reset line. I have BDI hooked up but it
> > > > doesn't
> > > > > seem to catch the reset point in the code.
> And
> > I
> > > > am
> > > > > unable to trace this to anything in the
> code.
> > Any
> > > > > suggestions? Thanks in advance.
> > > > >
> > > > >
> > > > >
> > > > > __________________________________
> > > > > Do you Yahoo!?
> > > > > Yahoo! Mail - now with 250MB free storage.
> > Learn
> > > > > more.
> > > > > http://info.mail.yahoo.com/mail_250
> > > > >
> > _______________________________________________
> > > > > Linuxppc-embedded mailing list
> > > > > Linuxppc-embedded@ozlabs.org
> > > > >
> > > >
> > >
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > > > >
> > > >
> > > >
> > > >
> > > >
> > > > __________________________________
> > > > Do you Yahoo!?
> > > > Read only the mail you want - Yahoo! Mail
> > SpamGuard.
> > > >
> > > > http://promotions.yahoo.com/new_mail
> > > >
> > >
> > >
> > >
> __________________________________________________
> > > Do You Yahoo!?
> > > Tired of spam?  Yahoo! Mail has the best spam
> > protection around
> > > http://mail.yahoo.com
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > >
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> > 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
