Return-Path: <anton@samba.org>
Date: Wed, 14 Dec 2011 14:17:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Fushen Chen <fchen@apm.com>
Subject: Re: CONFIG_NO_HZ added too much idle time in /proc/stat during
 throughput test.
Message-ID: <20111214141755.72f8c827@kryten>
In-Reply-To: <CAEu=RPgnh-i-SFt4kiiAtDjLZ3A0cAHhk7ch56Uvv0uG_+HfCg@mail.gmail.com>
References: <CAEu=RPirE=H1N=KjHNjNRBM6H1fRvrugCw6ojqWaTNm2=WTfng@mail.gmail.com>
 <1323818650.7671.3.camel@pasglop>
 <alpine.LFD.2.02.1112140027230.3020@ionos>
 <1323819246.7671.4.camel@pasglop>
 <CAEu=RPgnh-i-SFt4kiiAtDjLZ3A0cAHhk7ch56Uvv0uG_+HfCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> This is 2.6.32, but I think 2.6.36 is the same.

Sounds a bit like this, merged in 2.6.39.

Anton
--

commit ad5d1c888e556bc00c4e86f452cad4a3a87d22c1
Author: Anton Blanchard <anton@samba.org>
Date:   Sun Mar 20 15:28:03 2011 +0000

    powerpc: Fix accounting of softirq time when idle
    
    commit cf9efce0ce31 (powerpc: Account time using timebase rather
    than PURR) used in_irq() to detect if the time was spent in
    interrupt processing. This only catches hardirq context so if we
    are in softirq context and in the idle loop we end up accounting it
    as idle time. If we instead use in_interrupt() we catch both softirq
    and hardirq time.
    
    The issue was found when running a network intensive workload. top
    showed the following:
    
    0.0%us,  1.1%sy,  0.0%ni, 85.7%id,  0.0%wa,  9.9%hi,  3.3%si,  0.0%st
    
    85.7% idle. But this was wildly different to the perf events data.
    To confirm the suspicion I ran something to keep the core busy:
    
    # yes > /dev/null &
    
    8.2%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa, 10.3%hi, 81.4%si,  0.0%st
    
    We only got 8.2% of the CPU for the userspace task and softirq has
    shot up to 81.4%.
    
    With the patch below top shows the correct stats:
    
    0.0%us,  0.0%sy,  0.0%ni,  5.3%id,  0.0%wa, 13.3%hi, 81.3%si,  0.0%st
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Cc: stable@kernel.org
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
