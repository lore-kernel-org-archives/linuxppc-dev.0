Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2CEADDDF2A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:14:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-ppc-devel@lists.sourceforge.net,
 jyoung5@us.ibm.com
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle power save for ppc 4xx
Date: Tue, 1 Apr 2008 14:14:07 +0200
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206980871.5919.5.camel@basalt>
	<1206982322.9165.7.camel@thinkpadL>
In-Reply-To: <1206982322.9165.7.camel@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804011414.07549.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 31 March 2008, Jerone Young wrote:
> >=20
> > > +{
> > > +=A0=A0=A0unsigned long msr_save;
> > > +
> > > +=A0=A0=A0/* set wait state MSR */
> > > +=A0=A0=A0local_irq_enable();
> > > +=A0=A0=A0msr_save =3D mfmsr();
> > > +=A0=A0=A0mtmsr(msr_save|MSR_WE);
> >=20
> > Why don't you |MSR_WE|MSR_EE at the same time?
>=20
> You technically can do this. But the question is do all 4xx cpus use
> MSR_EE to enable interrupts? I can assume they do (from what I know),
> but figured it would be safer to make the local_irq_enable() call.
> I can change it to just set the MSR_EE bit though, since all 4xx cpus
> (as far as I know) use it.

=46or correctness reasons, you actually have to set both EE and WE
simultaneously. Otherwise, an interrupt can come in between the two
mtmsr(), mark some thread as runnable and then go to sleep here
without ever checking need_resched() until the next interrupt,
which may take an indefinite time.

> >=20
> > > +=A0=A0=A0local_irq_disable();
> > > +}
> >=20
> > None of the other power_save() implementations need this. In fact many
> > of them don't even seem to return; they just loop around mtmsr.
>=20
> Sure it can be removed. Though with the comment in the mach_dep
> structure about power_save. It specifically says that interrupts are off
> when it is called. So I was following it here mainly. But I can remove
> the disabling of interrupts, since mtmsr is the only used under
> power_save.

With the current code, it shouldn't matter, because cpu_idle enables
the interrupts right after calling ppc_md->power_save(), but it would
be reasonable to disable the interrupts here anyway, if only to make
the function return with the same state that it was entered.

IMHO, the function should be

void ppc4xx_idle()
{
        unsigned long msr_save;

        msr_save =3D mfmsr();
	/* enter idle mode */
        mtmsr(msr_save|MSR_WE|MSR_EE);
	/* disable interrupts again */
        mtmsr(msr_save);
}

	Arnd <><
