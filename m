Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B6ADB7CF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 17:33:34 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1O2JZp-0001ua-S8
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Apr 2010 09:33:29 +0200
Date: Thu, 15 Apr 2010 09:32:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final tree
	(tip related)
Message-ID: <20100415073256.GG9240@elte.hu>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu>
	<20100414.235557.123118153.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100414.235557.123118153.davem@davemloft.net>
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


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Thu, 15 Apr 2010 08:49:40 +0200
> 
> > Btw., WARN_ON trapping on PowerPC is clearly a PowerPC bug - there's a good 
> > reason we have WARN_ON versus BUG_ON - it should be fixed.
> 
> I disagree, an implementation should be allowed to use the most
> efficient implementation possible for both interfaces.

It trades robustness for slightly better space/code efficiency.

Such a trap based mechanism exists on x86 as well and we use it for BUG_ON(). 
We intentionally dont use it to generate warnings and dont override __WARN(), 
because it would blow up way too often when a warning triggers in some 
sensitive codepath that cannot take a trap.

Anyway, the warning obviously has to be fixed - but the boot crash itself is 
PowerPC's own doing.

	Ingo
