Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABDD3B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 18:59:49 +1100 (EST)
Message-ID: <1332748746.16159.62.camel@twins>
Subject: Re: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 26 Mar 2012 09:59:06 +0200
In-Reply-To: <20120325174210.GA23605@redhat.com>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
 <20120325174210.GA23605@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linux-mm@kvack.org,
 Anton Vorontsov <anton.vorontsov@linaro.org>, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-03-25 at 19:42 +0200, Oleg Nesterov wrote:
> __cpu_disable() is called by __stop_machine(), we know that nobody
> can preempt us and other CPUs can do nothing.=20

It would be very good to not rely on that though, I would love to get
rid of the stop_machine usage in cpu hotplug some day.
