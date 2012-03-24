Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C90ABB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 23:48:45 +1100 (EST)
Message-ID: <1332593303.16159.28.camel@twins>
Subject: Re: [PATCH 07/10] um: Should hold tasklist_lock while traversing
 processes
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Sat, 24 Mar 2012 13:48:23 +0100
In-Reply-To: <20120324103030.GG29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
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

On Sat, 2012-03-24 at 14:30 +0400, Anton Vorontsov wrote:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe.=20

No it doesn't, it either requires tasklist_lock or rcu_read_lock().
