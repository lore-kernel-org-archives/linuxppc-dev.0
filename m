Return-Path: <walken@google.com>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 360F02C0293
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 20:47:49 +1100 (EST)
Received: by mail-ie0-f169.google.com with SMTP id 13so8253606iea.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 01:47:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51227810.6090009@linux.vnet.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123920.26245.56709.stgit@srivatsabhat.in.ibm.com>
 <CANN689HhVxDv+3Bn9UAxOMzj0egTvVp_c7oAmQ2nnQ8Xjn_aMA@mail.gmail.com>
 <51225A36.40600@linux.vnet.ibm.com>
 <CANN689FJPLfz06MFRJ9T+BuToejAzjYP_yrw_H4iGi1Kb3p2-g@mail.gmail.com>
 <51227810.6090009@linux.vnet.ibm.com>
Date: Tue, 19 Feb 2013 17:40:50 +0800
Message-ID: <CANN689E-98zK69pGeojbm30n3sswQYVBvhk3i3OzqvbeqSrSrg@mail.gmail.com>
Subject: Re: [PATCH v6 08/46] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
From: Michel Lespinasse <walken@google.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 19, 2013 at 2:50 AM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> But, the whole intention behind removing the parts depending on the
> recursive property of rwlocks would be to make it easier to make rwlocks
> fair (going forward) right? Then, that won't work for CPU hotplug, because,
> just like we have a legitimate reason to have recursive
> get_online_cpus_atomic(), we also have a legitimate reason to have
> unfairness in locking (i.e., for deadlock-safety). So we simply can't
> afford to make the locking fair - we'll end up in too many deadlock
> possibilities, as hinted in the changelog of patch 1.

Grumpf - I hadn't realized that making the underlying rwlock fair
would break your hotplug use case. But you are right, it would. Oh
well :/

> So the only long-term solution I can think of is to decouple
> percpu-rwlocks and rwlock_t (like what Tejun suggested) by implementing
> our own unfair locking scheme inside. What do you think?

I have no idea how hard would it be to change get_online_cpus_atomic()
call sites so that the hotplug rwlock read side has a defined order vs
other locks (thus making sure the situation you describe in patch 1
doesn't happen). I agree we shouldn't base our short term plans around
that, but maybe that's doable in the long term ???

Otherwise, I think we should add some big-fat-warning that percpu
rwlocks don't have reader/writer fairness, that the hotplug use case
actually depends on the unfairness / would break if the rwlock was
made fair, and that any new uses of percpu rwlocks should be very
carefully considered because of the reader/writer fairness issues.
Maybe even give percpu rwlocks a less generic sounding name, given how
constrained they are by the hotplug use case.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
