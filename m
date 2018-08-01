Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gbg86bQYzF1Hm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:44:35 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w71EhpwT030339
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 10:44:34 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kkcv8dyd2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 10:44:33 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 1 Aug 2018 10:44:32 -0400
Date: Wed, 1 Aug 2018 11:44:25 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Joe Perches <joe@perches.com>, Christophe LEROY <christophe.leroy@c-s.fr>,
 linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
 "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
 <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
 <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
 <20180801074903.GG16221@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180801074903.GG16221@gate.crashing.org>
Message-Id: <20180801144425.GB6022@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Segher.

On Wed, Aug 01, 2018 at 02:49:03AM -0500, Segher Boessenkool wrote:
> On Wed, Aug 01, 2018 at 12:03:50AM -0700, Joe Perches wrote:
> > On Wed, 2018-08-01 at 08:37 +0200, Christophe LEROY wrote:
> > > Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > > I would suggest to instead use a function like this:
> > >
> > > static const char *signame(int signr)
> > > {
> > > 	if (signr == SIGBUS)
> > > 		return "bus error";
> > > 	if (signr == SIGFPE)
> > > 		return "floating point exception";
> > > 	if (signr == SIGILL)
> > > 		return "illegal instruction";
> > > 	if (signr == SIGILL)
> > > 		return "segfault";
> > > 	if (signr == SIGTRAP)
> > > 		return "unhandled trap";
> > > 	return "unknown signal";
> > > }
> >
> > trivia:
> >
> > Unless the if tests are ordered most to least likely,
> > perhaps it would be better to use a switch/case and
> > let the compiler decide.
>
> That would also show there are two entries for SIGILL (here and in the
> original patch), one of them very wrong.

Good catch.  I'll take care of that in my next respin.

> Check the table with psignal or something?

Nice suggestion.  Thanks!

Cheers
Murilo
