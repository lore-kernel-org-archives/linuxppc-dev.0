Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9349667D53
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 05:28:43 +1100 (EST)
Message-ID: <45576835.8000605@ru.mvista.com>
Date: Sun, 12 Nov 2006 21:30:13 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
References: <200611080005.08633.sshtylyov@ru.mvista.com>	<1162938997.28571.534.camel@localhost.localdomain>	<45510C58.3010707@ru.mvista.com>	<17745.14911.693171.717979@cargo.ozlabs.ibm.com>	<4551E7FF.8010209@ru.mvista.com>	<17748.14621.231956.561842@cargo.ozlabs.ibm.com>	<455487E2.9040701@ru.mvista.com>
	<17749.4257.415783.451756@cargo.ozlabs.ibm.com>
In-Reply-To: <17749.4257.415783.451756@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: tglx@linutronix.de, greg.weeks@timesys.com,
	John Stultz <johnstul@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

>>    I think the usual rule is: "you want it, you do it". ;-)

> Sure!  And I will, at some point, if someone else doesn't do it
> first.

> My point is simply that as maintainer I won't accept a patch that
> breaks an important feature, even if it adds another important
> feature.

    It's too early to talk about the mainline acceptance of this patch ATM, 
while TOD vsyscalls are broken/removed by the GENERIC_TIME support patches 
(which are aboslutely needed for HRT as well).  We'll try to return to getting 
them straight when the time permits, but for now the HRT patchset is still in 
better form than it was for several months before that (not even compilable, 
and vsyscalls broken)...

>>    Seriously, we have neither time, not hardware, nor docs for the h/w this 
>>accounting option applies to.

> Really?  You're working on machines that don't have a timebase
> register?  What powerpc chip doesn't have a timebase register, other
> than the really old 601? :)  The timebase is all the hardware that is
> needed.

    If you look at arch/powerpc/Kconfig, you'll see that this option depends 
on PPC64 which basically says it all:  we have only 32-bit targets to care 
about ATM.  When it comes to 64-bit ones, we'll see... :-)

>>And coercing the generic clcokevents/hrtimers 
>>code into calling the arch hooks is serious design decision which I felt is 
>>better to be left to Thomas as a maintainer...

> CONFIG_VIRT_CPU_ACCOUNTING is used, and needed, on powerpc and s390,
> both of which also want to do dynticks.  If the current framework
> can't cope with that, then it needs to be extended.

    Well, why not make Linus "extend" update_process_times() for starters? :-)

> Paul.

WBR, Sergei
