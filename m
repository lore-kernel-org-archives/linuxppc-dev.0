Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 91A21DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 03:18:57 +1100 (EST)
Date: Mon, 17 Nov 2008 11:18:53 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/7] ftrace, PPC64: handle module trampolines for dyn
	ftrace
In-Reply-To: <18720.64083.306981.779763@drongo.ozlabs.ibm.com>
Message-ID: <alpine.DEB.1.10.0811171117320.8722@gandalf.stny.rr.com>
References: <20081116212428.938752312@goodmis.org>
	<20081116212516.000516128@goodmis.org>
	<18720.64083.306981.779763@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 17 Nov 2008, Paul Mackerras wrote:

> Steven Rostedt writes:
> 
> > +	if (!rec->arch.mod) {
> > +		if (!mod) {
> > +			printk(KERN_ERR "No module loaded addr=%lx\n",
> > +			       addr);
> > +			return -EFAULT;
> > +		}
> > +		rec->arch.mod = mod;
> > +	} else if (mod) {
> > +		printk(KERN_ERR
> > +		       "Record mod %p not equal to passed in mod %p\n",
> > +		       rec->arch.mod, mod);
> > +		return -EINVAL;
> 
> That looks wrong; surely you need an if (mod != rec->arch.mod)
> somewhere here?

BTW, the reason this still worked was because only the first instance 
passes in mod (when rec->arch.mod does not exist). After that, mod is 
NULL, so we never enter this case. But still, I will need to fix this 
(even though I thought I did).

-- Steve
