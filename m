Return-Path: <tao_rick@yahoo.com>
Received: from nm26.bullet.mail.ac4.yahoo.com (nm26.bullet.mail.ac4.yahoo.com
	[98.139.52.223]) by ozlabs.org (Postfix) with SMTP id 070CEB70E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Oct 2010 06:13:17 +1100 (EST)
Message-ID: <872288.6462.qm@web50407.mail.re2.yahoo.com>
Date: Fri, 15 Oct 2010 12:13:14 -0700 (PDT)
From: Rick Tao <tao_rick@yahoo.com>
Subject: Re: Possible kernel stack overflow due to fast interrupts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1287100633.2205.80.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You are exactly right! Ensuring interrupts would not cause more preemptions=
. =0AThanks for pointing it out.=0ARick=0A=0A--- On Thu, 10/14/10, Benjamin=
 Herrenschmidt <benh@kernel.crashing.org> wrote:=0A=0A> From: Benjamin Herr=
enschmidt <benh@kernel.crashing.org>=0A> Subject: Re: Possible kernel stack=
 overflow due to fast interrupts=0A> To: "Rick Tao" <tao_rick@yahoo.com>=0A=
> Cc: linuxppc-dev@lists.ozlabs.org=0A> Date: Thursday, October 14, 2010, 4=
:57 PM=0A> On Thu, 2010-10-14 at 13:45 -0700,=0A> Rick Tao wrote:=0A> > Hi,=
 all,=0A> =0A>  .../...=0A> =0A> > In the context of task A=0A> > a. NIP wo=
uld point to the instruction after=0A> switch_to(). =0A> > b. MSR_EE is ena=
bled in the call trace=0A> (finish_task_switch=0A> -->finish_lock_switch-->=
spin_unlock_irq)=0A> > c. do something that would trigger an interrupt late=
r=0A> on (such as timer)=0A> > d. call schedule() for context switch to tas=
k B.=0A> >=A0 =A0 In this step, =0A> >=A0 =A0 =A0 task B's stack is popped=
=0A> INT_FRAME_SIZE size for context restore.=A0 =0A> >=A0 =A0 Note that ta=
sk B's ksp =3D X -=0A> INT_FRAME_SIZE=0A> > =0A> > In the context of task B=
 again=0A> > a1. similar to step "a" above=0A> >=0A> > b1. similar to step =
"b" above =0A> > c1. interrupt occurs, go to step "1" above, and=0A> repeat=
!!!=0A> > =0A> > As you can see, task B's kernel stack space is reduced=0A>=
 by INT_FRAME_SIZE=0A> > on each loop. It will eventually overflow.=0A> =0A=
> So if I follow you correctly, you are worried that by the=0A> time execut=
ion=0A> resumes in B, and before it pops the second frame off, it=0A> might=
 get=0A> another interrupt and re-preempt...=0A> =0A> Now unless I missed s=
omething, that cannot happen because=0A> preempt_schedule_irq() does increm=
ent the preempt count:=0A> =0A> =A0=A0=A0 add_preempt_count(PREEMPT_ACTIVE)=
;=0A> =A0=A0=A0 local_irq_enable();=0A> =A0=A0=A0 schedule();=0A> =A0=A0=A0=
 local_irq_disable();=0A> =A0=A0=A0 sub_preempt_count(PREEMPT_ACTIVE);=0A> =
=0A> Which means that it won't preempt again in=0A> finish_task_switch, and=
 so=0A> will eventually come back, turn EE back off, and pop off=0A> the st=
ack=0A> frame.=0A> =0A> Or am I missing something ?=0A> =0A> Cheers,=0A> Be=
n.=0A> =0A> =0A> _______________________________________________=0A> Linuxp=
pc-dev mailing list=0A> Linuxppc-dev@lists.ozlabs.org=0A> https://lists.ozl=
abs.org/listinfo/linuxppc-dev=0A> =0A=0A=0A      
