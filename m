Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18207.56178.634571.444117@cargo.ozlabs.ibm.com>
Date: Thu, 25 Oct 2007 09:55:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <471F358D.7070300@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161C38.2070305@ru.mvista.com>
	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>
	<471777BD.8090800@ru.mvista.com>
	<18200.3600.459275.823335@cargo.ozlabs.ibm.com>
	<47189EF3.7010103@ru.mvista.com>
	<18200.42194.853246.935329@cargo.ozlabs.ibm.com>
	<4718B287.20306@ru.mvista.com> <471F358D.7070300@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     I've just realized that I've missed the call to account_process_time() in 
> the new timer_interrupt(). :-<

Which is bogus.  I had removed it in the version of the patch that I
posted in early September, but apparently it crept back in.

>     Anyway, this leads to each tick being accounted twice if the deterministic 
> accounting is not enabled -- first by timer_interrupt() and then by the 
> hrtimers core, doesn't it?

Yep.

Actually, I thought I was told that with CFS, the total process time
was accounted accurately using sched_clock(), then apportioned between
utime and stime (using counts of ticks in user/system state, which are
somewhat inaccurate).  At the time I thought that would be OK, but now
I'm not so sure.

Paul.
