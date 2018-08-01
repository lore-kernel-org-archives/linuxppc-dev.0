Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gbd66ZGNzF1C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:42:50 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w71Ed6o1119411
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 10:42:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kkbm3h8tq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 10:42:46 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 1 Aug 2018 08:42:45 -0600
Date: Wed, 1 Aug 2018 11:42:35 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org,
 "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
 <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
 <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
Message-Id: <20180801144235.GA6022@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2018 at 12:03:50AM -0700, Joe Perches wrote:
> On Wed, 2018-08-01 at 08:37 +0200, Christophe LEROY wrote:
> > Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > > This adds a human-readable name in the unhandled signal message.
> > > Before this patch, a page fault looked like:
> > >    pandafault[6303]: unhandled signal 11 at 100007d0 nip 1000061c lr 7fff93c55100 code 2 in pandafault[10000000+10000]
> > > After this patch, a page fault looks like:
> > >    pandafault[6352]: segfault (11) at 13a2a09f8 nip 13a2a086c lr 7fffb63e5100 code 2 in pandafault[13a2a0000+10000]
> ]]
> > > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> []
> > > @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
> > >   #define TM_DEBUG(x...) do { } while(0)
> > >   #endif
> > >
> > > +static const char *signames[SIGRTMIN + 1] = {
> > > +	"UNKNOWN",
> > > +	"SIGHUP",			// 1
> > > +	"SIGINT",			// 2
> []
> > I don't think is is worth having that full table when we only use a few
> > of them. (As discussed in v1 https://patchwork.ozlabs.org/patch/948802/)
> >
> > I would suggest to instead use a function like this:
> >
> > static const char *signame(int signr)
> > {
> > 	if (signr == SIGBUS)
> > 		return "bus error";
> > 	if (signr == SIGFPE)
> > 		return "floating point exception";
> > 	if (signr == SIGILL)
> > 		return "illegal instruction";
> > 	if (signr == SIGILL)
> > 		return "segfault";
> > 	if (signr == SIGTRAP)
> > 		return "unhandled trap";
> > 	return "unknown signal";
> > }
>
> trivia:
>
> Unless the if tests are ordered most to least likely,
> perhaps it would be better to use a switch/case and
> let the compiler decide.
>
> 	switch (signr) {
> 	case SIGBUS:	return "bus error";
> 	case SIGFPE:	return "floating point exception";
> 	case SIGILL:	return "illegal instruction";
> 	case SIGSEGV:	return "segfault";
> 	case SIGTRAP:	return "unhandled trap";
> 	}
> 	return "unknown signal";
> }
>

Hi, Joe, Christophe.

That's a nice enhancement.  I'll do that in my next respin.

Cheers
Murilo
