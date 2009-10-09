Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id AA217B7B6B
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Oct 2009 02:56:38 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 10/16] percpu: make percpu symbols in powerpc unique
Date: Fri, 9 Oct 2009 17:44:00 +0200
References: <1254913285-6251-1-git-send-email-tj@kernel.org>
	<1254913285-6251-11-git-send-email-tj@kernel.org>
In-Reply-To: <1254913285-6251-11-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200910091744.00384.arnd@arndb.de>
Cc: Christoph Lameter <cl@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <mhiramat@redhat.com>,
	Nick Piggin <npiggin@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	Robert Richter <robert.richter@amd.com>, x86@kernel.org,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Rusty Russell <rusty@rustcorp.com.au>,
	Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Jeremy Fitzhardinge <jeremy@xensource.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 07 October 2009, Tejun Heo wrote:
> This patch updates percpu related symbols in powerpc such that percpu
> symbols are unique and don't clash with local symbols.  This serves
> two purposes of decreasing the possibility of global percpu symbol
> collision and allowing dropping per_cpu__ prefix from percpu symbols.
> 
> * arch/powerpc/kernel/perf_callchain.c: s/callchain/cpu_perf_callchain/
> 
> * arch/powerpc/kernel/setup-common.c: s/pvr/cpu_pvr/
> 
> * arch/powerpc/platforms/pseries/dtl.c: s/dtl/cpu_dtl/
> 
> * arch/powerpc/platforms/cell/interrupt.c: s/iic/cpu_iic/
> 
> Partly based on Rusty Russell's "alloc_percpu: rename percpu vars
> which cause name clashes" patch.

Patch looks good, I checked both the cell bits I'm maintaining
and the other powerpc parts.

Acked-by: Arnd Bergmann <arnd@arndb.de>
