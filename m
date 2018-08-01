Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gQSB2vfszF18f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 17:49:30 +1000 (AEST)
Date: Wed, 1 Aug 2018 02:49:03 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joe Perches <joe@perches.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
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
Message-ID: <20180801074903.GG16221@gate.crashing.org>
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
 <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
 <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
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

That would also show there are two entries for SIGILL (here and in the
original patch), one of them very wrong.

Check the table with psignal or something?


Segher
