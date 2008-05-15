Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4080ADDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 15:29:04 +1000 (EST)
Date: Wed, 14 May 2008 22:28:57 -0700 (PDT)
Message-Id: <20080514.222857.246967279.davem@davemloft.net>
To: rostedt@goodmis.org
Subject: Re: [PATCH 2/2] ftrace: support for PowerPC
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080515035918.896765954@goodmis.org>
References: <20080515034942.109223655@goodmis.org>
	<20080515035918.896765954@goodmis.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org, srostedt@redhat.com,
	linuxppc-dev@ozlabs.org, sandmann@redhat.com, paulus@samba.org,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 14 May 2008 23:49:44 -0400

> +#ifdef CONFIG_FTRACE
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +_GLOBAL(mcount)
> +_GLOBAL(_mcount)
> +	stwu	r1,-48(r1)
> +	stw	r3, 12(r1)
> +	stw	r4, 16(r1)
> +	stw	r5, 20(r1)
> +	stw	r6, 24(r1)
> +	mflr	r3
> +	stw	r7, 28(r1)
> +	mfcr	r5
> +	stw	r8, 32(r1)
> +	stw	r9, 36(r1)
> +	stw	r10,40(r1)
> +	stw	r3, 44(r1)
> +	stw	r5, 8(r1)

Yikes, that's really expensive.

Can't you do a tail call and let the function you end
up calling do all the callee-saved register pops onto
the stack?

That's what I did on sparc.
