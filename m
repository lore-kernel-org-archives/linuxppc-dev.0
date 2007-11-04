Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Balbir Singh" <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Restore deterministic CPU accounting on powerpc 
In-reply-to: <661de9470711030202x24d0186cuc96a70156ecfa23f@mail.gmail.com> 
References: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
	<661de9470711030202x24d0186cuc96a70156ecfa23f@mail.gmail.com>
Date: Sun, 04 Nov 2007 23:11:27 +1100
Message-ID: <30600.1194178287@neuling.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +#ifndef CONFIG_VIRT_CPU_ACCOUNTING
> > +void account_process_tick(int user_tick)
> > +{
> > +       if (user_tick) {
> > +               account_user_time(p, jiffies_to_cputime(1));
> > +               account_user_time_scaled(p, jiffies_to_cputime(1));
> > +       } else {
> > +               account_system_time(p, HARDIRQ_OFFSET, jiffies_to_cputime(1
));
> > +               account_system_time_scaled(p, jiffies_to_cputime(1));
> > +       }
> > +}
> > +#endif
> > +
> 
> Hi, Paul,
> 
> So, scaled accounting will not be available if
> CONFIG_VIRT_CPU_ACCOUNTING is defined? Am I reading this correctly

Balbir, 

Paulus' patch will have merge issues with the scaled time cleanup patch
I posted a week or so back.  My cleanup patch is only in akpm's tree at
this stage.

Mikey
