Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACC2D2C03CB
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 20:05:17 +1100 (EST)
Date: Thu, 31 Oct 2013 10:04:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131031090457.GU19466@laptop.lan>
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131031043258.GQ4126@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 09:32:58PM -0700, Paul E. McKenney wrote:
> Before C/C++11, the closest thing to such a prohibition is use of
> volatile, for example, ACCESS_ONCE().  Even in C/C++11, you have to
> use atomics to get anything resembing this prohibition.
> 
> If you just use normal variables, the compiler is within its rights
> to transform something like the following:
> 
> 	if (a)
> 		b = 1;
> 	else
> 		b = 42;
> 
> Into:
> 
> 	b = 42;
> 	if (a)
> 		b = 1;
> 
> Many other similar transformations are permitted.  Some are used to all
> vector instructions to be used -- the compiler can do a write with an
> overly wide vector instruction, then clean up the clobbered variables
> later, if it wishes.  Again, if the variables are not marked volatile,
> or, in C/C++11, atomic.

While I've heard you tell this story before, my mind keeps boggling how
we've been able to use shared memory at all, all these years.

It seems to me stuff should have broken left, right and center if
compilers were really aggressive about this.
