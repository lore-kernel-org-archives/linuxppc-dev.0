Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc/cell: fix dependency in cpufreq 
In-reply-to: <1234227692.8149.58.camel@localhost> 
References: <18282.1234226812@neuling.org> <1234227692.8149.58.camel@localhost>
Date: Tue, 10 Feb 2009 12:48:46 +1100
Message-ID: <22829.1234230526@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > cbe_cpufreq.c uses cbe_cpufreq_has_pmi which is provided by
> > cbe_cpufreq_pmi.c.  Hence CBE_CPUFREQ depends on CBE_CPUFREQ_PMI.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > I'm not 100% sure is this the right fix.  Should CBE_CPUFREQ really
> > depend on CBE_CPUFREQ_PMI?
> 
> No I don't think it is. Look at platforms/cell/cbe_cpufreq.h, the
> intention seems to be that if PMI isn't built in then that variable is
> hardcoded to 0 and we never use the pmi routines.

---
#if defined(CONFIG_CBE_CPUFREQ_PMI) || defined(CONFIG_CBE_CPUFREQ_PMI_MODULE)
extern bool cbe_cpufreq_has_pmi;
#else
#define cbe_cpufreq_has_pmi (0)
#endif
--

So, I think this is bust.  If cpufreq_pmi is in a module, how does
cpufreq use cbe_cpufreq_has_pmi if the module is not inserted?  

Arnd?

Mikey
