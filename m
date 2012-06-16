Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37ED9B70CC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2012 03:31:20 +1000 (EST)
Message-ID: <1339867858.15222.12.camel@twins>
Subject: Re: [RFC PATCH 09/10] POWERPC: smp: remove call to
 ipi_call_lock()/ipi_call_unlock()
From: Peter Zijlstra <peterz@infradead.org>
To: paulmck@linux.vnet.ibm.com
Date: Sat, 16 Jun 2012 19:30:58 +0200
In-Reply-To: <20120616163219.GI2420@linux.vnet.ibm.com>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
 <1338275765-3217-10-git-send-email-yong.zhang0@gmail.com>
 <20120616163219.GI2420@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: axboe@kernel.dk, sshtylyov@mvista.com, nikunj@linux.vnet.ibm.com,
 david.daney@cavium.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 akpm@linux-foundation.org, Yong Zhang <yong.zhang0@gmail.com>,
 Paul Mackerras <paulus@samba.org>, srivatsa.bhat@linux.vnet.ibm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-06-16 at 09:32 -0700, Paul E. McKenney wrote:
> However, there is an effort to get rid of stop_machine() from the
> CPU-down path...  So something else will be needed.=20

Elsewhere in this thread I mentioned we could do a synchronize_sched().
I think that covers most of what stop-machine is doing these days.
