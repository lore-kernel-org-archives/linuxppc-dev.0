Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18720.64083.306981.779763@drongo.ozlabs.ibm.com>
Date: Mon, 17 Nov 2008 16:00:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7] ftrace,
	PPC64: handle module trampolines for dyn ftrace
In-Reply-To: <20081116212516.000516128@goodmis.org>
References: <20081116212428.938752312@goodmis.org>
	<20081116212516.000516128@goodmis.org>
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

Steven Rostedt writes:

> +	if (!rec->arch.mod) {
> +		if (!mod) {
> +			printk(KERN_ERR "No module loaded addr=%lx\n",
> +			       addr);
> +			return -EFAULT;
> +		}
> +		rec->arch.mod = mod;
> +	} else if (mod) {
> +		printk(KERN_ERR
> +		       "Record mod %p not equal to passed in mod %p\n",
> +		       rec->arch.mod, mod);
> +		return -EINVAL;

That looks wrong; surely you need an if (mod != rec->arch.mod)
somewhere here?

> +	/* Make sure that that this is still a 24bit jump */
> +	if ((*op & 0xff000000) != 0x48000000) {
> +		printk(KERN_ERR "Not expected bl: opcode is %x\n", *op);
> +		return -EINVAL;
> +	}

Needs to be

	if ((*op & 0xfc000003) != 0x48000001)

since the major opcode is the top 6 bits, and the bottom 2 bits are
the link bit and the absolute address bit.

> +	/* lets find where the pointer goes */
> +	offset = (*op & 0x03fffffc);
> +	/* make it signed */
> +	if (offset & 0x02000000)
> +		offset |= 0xfe000000;

but you got that right... :)

> +	/* get the address this jumps too */
> +	tramp = mod->arch.toc + offset + 32;

Why + 32?

Paul.
