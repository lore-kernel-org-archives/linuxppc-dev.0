Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9D8BDB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2012 03:43:57 +1100 (EST)
Message-ID: <1332607407.16159.51.camel@twins>
Subject: Re: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Sat, 24 Mar 2012 17:43:27 +0100
In-Reply-To: <20120324162151.GA3640@lizard>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins> <20120324162151.GA3640@lizard>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-03-24 at 20:21 +0400, Anton Vorontsov wrote:

> Just wonder how do you see the feature implemented?
>=20
> Something like this?
>=20
> #define __ret_cond_locked(l, c)	__attribute__((ret_cond_locked(l, c)))
> #define __ret_value		__attribute__((ret_value))
> #define __ret_locked_nonnull(l)	__ret_cond_locked(l, __ret_value);
>=20
> extern struct task_struct *find_lock_task_mm(struct task_struct *p)
> 	__ret_locked_nonnull(&__ret_value->alloc_lock);

Yeah, see the email I just CC'ed you on to linux-sparse.

Basically extend __attribute__((context())) to allow things similar to
what you proposed.
