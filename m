Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C4502C0362
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 02:11:08 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 31 Oct 2013 09:09:04 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5D78019D804C
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 09:08:55 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9VF8oU8343166
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 09:08:51 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r9VFAplP010556
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 09:10:54 -0600
Date: Thu, 31 Oct 2013 08:07:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131031150756.GB4067@linux.vnet.ibm.com>
References: <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <20131031090457.GU19466@laptop.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131031090457.GU19466@laptop.lan>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 31, 2013 at 10:04:57AM +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2013 at 09:32:58PM -0700, Paul E. McKenney wrote:
> > Before C/C++11, the closest thing to such a prohibition is use of
> > volatile, for example, ACCESS_ONCE().  Even in C/C++11, you have to
> > use atomics to get anything resembing this prohibition.
> > 
> > If you just use normal variables, the compiler is within its rights
> > to transform something like the following:
> > 
> > 	if (a)
> > 		b = 1;
> > 	else
> > 		b = 42;
> > 
> > Into:
> > 
> > 	b = 42;
> > 	if (a)
> > 		b = 1;
> > 
> > Many other similar transformations are permitted.  Some are used to all
> > vector instructions to be used -- the compiler can do a write with an
> > overly wide vector instruction, then clean up the clobbered variables
> > later, if it wishes.  Again, if the variables are not marked volatile,
> > or, in C/C++11, atomic.
> 
> While I've heard you tell this story before, my mind keeps boggling how
> we've been able to use shared memory at all, all these years.
> 
> It seems to me stuff should have broken left, right and center if
> compilers were really aggressive about this.

Sometimes having stupid compilers is a good thing.  But they really are
getting more aggressive.

							Thanx, Paul
