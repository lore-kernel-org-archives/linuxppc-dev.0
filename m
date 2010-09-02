Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
In-reply-to: <4C7E9FC1.60004@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com> <4C7E9FC1.60004@us.ibm.com>
Date: Thu, 02 Sep 2010 13:46:29 +1000
Message-ID: <20565.1283399189@neuling.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Ankita Garg <ankita@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +       /* Check to see if the CPU out of FW already for kexec */

Wow, that comment is shit.  The checkin comment in
aef40e87d866355ffd279ab21021de733242d0d5 is much better.


> This comment is really confusing to me. I _think_ it is saying that this test
> determines if the CPU is done executing firmware code and has begun executing
> OS code.... Is that right?

Yeah.  

It means for a normal boot, the CPU will not have started yet (still in
firmware (FW)) so we have to call FW to bring it out.  In the kexec case
though, the CPU will have started already (it's spinning in the kernel)
so we don't have to call FW to bring it back out again.  To distinguish
between these two cases, we ask FW if the CPU has started or not (via
smp_query_cpu_stopped()) and if it's already start, don't restart it.

Originally, we could call FW to start a cpu that was already started,
but FW changed recently and stopped allowing us to do this.  Hence this
patch.

Mikey
