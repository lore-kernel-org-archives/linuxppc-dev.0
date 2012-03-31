Return-Path: <eric.dumazet@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 915F4B6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 07:00:17 +1000 (EST)
Received: by werg1 with SMTP id g1so1026114wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 14:00:13 -0700 (PDT)
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
From: Eric Dumazet <eric.dumazet@gmail.com>
To: paulmck@linux.vnet.ibm.com
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 31 Mar 2012 23:00:08 +0200
Message-ID: <1333227608.2325.4054.camel@edumazet-glaptop>
Mime-Version: 1.0
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-hexagon@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 cmetcalf@tilera.com, uclinux-dist-devel@blackfin.uclinux.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-04-01 at 00:33 +0800, Paul E. McKenney wrote:
> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
> 
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Hmm... I believe you could go one step forward and allow negative values
as well. Antimatter was proven to exist after all.

Hint : nr_cpu_ids is an "int", not an "unsigned int"

Bonus: Existing bugs become "must have" features.

Of course there is no hurry and this can wait 365 days.
