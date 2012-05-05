Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC0FCB6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2012 11:48:43 +1000 (EST)
Received: by obbup19 with SMTP id up19so4953274obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2012 18:48:40 -0700 (PDT)
Date: Fri, 4 May 2012 18:47:14 -0700
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/9] cpu: Introduce clear_tasks_mm_cpumask() helper
Message-ID: <20120505014711.GA24566@lizard>
References: <20120423070641.GA27702@lizard> <20120423070736.GA30752@lizard>
 <20120426165911.00cebd31.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120426165911.00cebd31.akpm@linux-foundation.org>
Cc: linaro-kernel@lists.linaro.org, Mike Frysinger <vapier@gentoo.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>, patches@linaro.org,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>, uclinux-dist-devel@blackfin.uclinux.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2012 at 04:59:11PM -0700, Andrew Morton wrote:
[...]
> > 	 so its not like new tasks will ever get this cpu set in
> > +	 * their mm mask. -- Peter Zijlstra
> > +	 * Thus, we may use rcu_read_lock() here, instead of grabbing
> > +	 * full-fledged tasklist_lock.
> > +	 */
> > +	rcu_read_lock();
> > +	for_each_process(p) {
> > +		struct task_struct *t;
> > +
> > +		t = find_lock_task_mm(p);
> > +		if (!t)
> > +			continue;
> > +		cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> > +		task_unlock(t);
> > +	}
> > +	rcu_read_unlock();
> > +}
> 
> It is good that this code exists under CONFIG_HOTPLUG_CPU.  Did you
> check that everything works correctly with CONFIG_HOTPLUG_CPU=n?

Yeah, only the code under CONFIG_HOTPLUG_CPU calls the function, so
it should be all fine.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
