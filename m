Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E365AB6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 20:46:22 +1000 (EST)
Message-ID: <1335869133.13683.125.camel@twins>
Subject: Re: [PATCH 1/9] cpu: Introduce clear_tasks_mm_cpumask() helper
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 01 May 2012 12:45:33 +0200
In-Reply-To: <20120426165911.00cebd31.akpm@linux-foundation.org>
References: <20120423070641.GA27702@lizard> <20120423070736.GA30752@lizard>
 <20120426165911.00cebd31.akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linaro-kernel@lists.linaro.org, Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Anton Vorontsov <anton.vorontsov@linaro.org>,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 patches@linaro.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
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

On Thu, 2012-04-26 at 16:59 -0700, Andrew Morton wrote:
> > +void clear_tasks_mm_cpumask(int cpu)
>=20
> The operation of this function was presumably obvious to you at the
> time you wrote it, but that isn't true of other people at later times.
>=20
> Please document it?
>=20
>=20
> > +{
> > +     struct task_struct *p;
> > +
> > +     /*
> > +      * This function is called after the cpu is taken down and marked
> > +      * offline,
>=20
> hm, well.  Who said that this function will only ever be called
> after that CPU was taken down?  There is nothing in the function name
> nor in the (absent) documentation which enforces this precondition.
>=20
> If someone tries to use this function for a different purpose, or
> copies-and-modifies it for a different purpose, we just shot them in
> the foot.
>=20
> They'd be pretty dumb to do that without reading the local comment,
> but still...

Methinks something simple like:

	WARN_ON(cpu_online(cpu));

Ought to cure that worry, no? :-)

>=20
> >        so its not like new tasks will ever get this cpu set in
> > +      * their mm mask. -- Peter Zijlstra
> > +      * Thus, we may use rcu_read_lock() here, instead of grabbing
> > +      * full-fledged tasklist_lock.
> > +      */
> > +     rcu_read_lock();
> > +     for_each_process(p) {
> > +             struct task_struct *t;
> > +
> > +             t =3D find_lock_task_mm(p);
> > +             if (!t)
> > +                     continue;
> > +             cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> > +             task_unlock(t);
> > +     }
> > +     rcu_read_unlock();
> > +}=20
