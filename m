Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bR844W9dzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 06:06:43 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PJrow2093300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:06:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kewgk5vaj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:06:41 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 25 Jul 2018 14:06:40 -0600
Date: Wed, 25 Jul 2018 17:06:31 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Cyril Bur <cyrilbur@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/traps: Print signal name for unhandled signals
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-7-muriloo@linux.ibm.com>
 <20180725174927.Horde.Sfg4oyTmcaLgHIJr3Gf-oQ1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180725174927.Horde.Sfg4oyTmcaLgHIJr3Gf-oQ1@messagerie.si.c-s.fr>
Message-Id: <20180725200631.GC23643@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Wed, Jul 25, 2018 at 05:49:27PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>
> > This adds a human-readable name in the unhandled signal message.
> >
> > Before this patch, a page fault looked like:
> >
> >     Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled signal
> > 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2
> > in pandafault[10000000+10000]
> >
> > After this patch, a page fault looks like:
> >
> >     Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault (11) at
> > 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100 code 2 in
> > pandafault[13a2a0000+10000]
> >
> > Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index e6c43ef9fb50..e55ee639d010 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
> >  #define TM_DEBUG(x...) do { } while(0)
> >  #endif
> >
> > +static const char *signames[SIGRTMIN + 1] = {
> > +	"UNKNOWN",
> > +	"SIGHUP",			// 1
> > +	"SIGINT",			// 2
> > +	"SIGQUIT",			// 3
> > +	"SIGILL",			// 4
> > +	"unhandled trap",		// 5 = SIGTRAP
> > +	"SIGABRT",			// 6 = SIGIOT
> > +	"bus error",			// 7 = SIGBUS
> > +	"floating point exception",	// 8 = SIGFPE
> > +	"illegal instruction",		// 9 = SIGILL
> > +	"SIGUSR1",			// 10
> > +	"segfault",			// 11 = SIGSEGV
> > +	"SIGUSR2",			// 12
> > +	"SIGPIPE",			// 13
> > +	"SIGALRM",			// 14
> > +	"SIGTERM",			// 15
> > +	"SIGSTKFLT",			// 16
> > +	"SIGCHLD",			// 17
> > +	"SIGCONT",			// 18
> > +	"SIGSTOP",			// 19
> > +	"SIGTSTP",			// 20
> > +	"SIGTTIN",			// 21
> > +	"SIGTTOU",			// 22
> > +	"SIGURG",			// 23
> > +	"SIGXCPU",			// 24
> > +	"SIGXFSZ",			// 25
> > +	"SIGVTALRM",			// 26
> > +	"SIGPROF",			// 27
> > +	"SIGWINCH",			// 28
> > +	"SIGIO",			// 29 = SIGPOLL = SIGLOST
> > +	"SIGPWR",			// 30
> > +	"SIGSYS",			// 31 = SIGUNUSED
> > +};
> > +
> >  /*
> >   * Trap & Exception support
> >   */
> > @@ -314,10 +349,10 @@ static void show_signal_msg(int signr, struct
> > pt_regs *regs, int code,
> >  	if (!unhandled_signal(current, signr))
> >  		return;
> >
> > -	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
> > -		" nip "REG_FMT" lr "REG_FMT" code %x",
> > -		current->comm, current->pid, signr, addr,
> > -		regs->nip, regs->link, code);
> > +	pr_info("%s[%d]: %s (%d) at "REG_FMT" nip "REG_FMT \
> > +		" lr "REG_FMT" code %x",
> > +		current->comm, current->pid, signames[signr],
> > +		signr, addr, regs->nip, regs->link, code);
>
> Are we sure that signr is always within the limits of the table ?

Looking at the code, we only pass the following signals:

    SIGBUS
    SIGFPE
    SIGILL
    SIGSEGV
    SIGTRAP

All of them are within the limits of the table.  We've added other
signals for completeness.

Cheers
Murilo
