Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CDD52B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 16:55:55 +1000 (EST)
Date: Wed, 14 Apr 2010 23:55:57 -0700 (PDT)
Message-Id: <20100414.235557.123118153.davem@davemloft.net>
To: mingo@elte.hu
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final
	tree (tip related)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100415064940.GA9240@elte.hu>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, peterz@infradead.org, fweisbec@gmail.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	hpa@zytor.com, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 15 Apr 2010 08:49:40 +0200

> Btw., WARN_ON trapping on PowerPC is clearly a PowerPC bug - there's a good 
> reason we have WARN_ON versus BUG_ON - it should be fixed.

I disagree, an implementation should be allowed to use the most
efficient implementation possible for both interfaces.

I would be using traps for both on sparc64 if that were really
feasible on sparc64 (and actually with gcc-4.5's "asm goto" it might
actually be now)

The WARN and BUG macros, when implemented without traps, have serious
implications for overall code size and register pressure.
