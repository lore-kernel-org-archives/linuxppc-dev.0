Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.srv.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48E552BD81
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 21:35:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16753.1940.232184.119064@alkaid.it.uu.se>
Date: Sat, 16 Oct 2004 13:35:48 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1097925801.8965.42.camel@gaston>
References: <16752.64288.975262.790788@alkaid.it.uu.se>
	<1097925801.8965.42.camel@gaston>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 745x coherency fix for 2.4?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > >  
 > > -#ifdef CONFIG_SMP
 > > -	if ((flags & _PAGE_NO_CACHE) == 0)
 > > +	if (((flags & _PAGE_NO_CACHE) == 0) &&
 > > +	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_NEED_COHERENT))
 > >  		flags |= _PAGE_COHERENT;
 > > -#endif
 > 
 > Wouldn't your patch result in _not_ setting _PAGE_COHERENT on non-broken
 > CPUs when CONFIG_SMP is set ?

The cputable.c change adds CPU_FTR_NEED_COHERENT to all CPUs when
CONFIG_SMP is set. That's why the changes from #ifdef CONFIG_SMP
to checking this feature flag work for both SMP and 745x.

The logic is straight from the 2.6 kernel; I only adapted it where
the 2.4 kernel was different, like some of the cputable entries
were missing in 2.4.

/Mikael
