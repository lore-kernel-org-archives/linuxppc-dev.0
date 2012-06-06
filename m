Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2E244B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:27:22 +1000 (EST)
Message-ID: <1338974822.2749.89.camel@twins>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
From: Peter Zijlstra <peterz@infradead.org>
To: ananth@in.ibm.com
Date: Wed, 06 Jun 2012 11:27:02 +0200
In-Reply-To: <20120606092150.GC6745@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606092150.GC6745@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-06 at 14:51 +0530, Ananth N Mavinakayanahalli wrote:
> One TODO in this port compared to x86 is the uprobe abort_xol() logic.
> x86 depends on the thread_struct.trap_nr (absent in powerpc) to determine
> if a signal was caused when the uprobed instruction was single-stepped/
> emulated, in which case, we reset the instruction pointer to the probed
> address and retry the probe again.=20

Another curious difference is that x86 uses an instruction decoder and
contains massive tables to validate we can probe a particular
instruction.

Can we probe all possible PPC instructions?
