Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x231.google.com (mail-ve0-x231.google.com
 [IPv6:2607:f8b0:400c:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F6232C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 16:24:58 +1100 (EST)
Received: by mail-ve0-f177.google.com with SMTP id sa20so2002859veb.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 22:24:53 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20140321045501.GD30295@linux.vnet.ibm.com>
References: <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
 <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
 <1395346808.14694.62.camel@buesod1.americas.hpqcorp.net>
 <20140321045501.GD30295@linux.vnet.ibm.com>
Date: Thu, 20 Mar 2014 22:24:52 -0700
Message-ID: <CA+55aFyX0sj_MjTas3RYWWOa1W-xc3t0Af_0vdmsmgui8Apqpw@mail.gmail.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Davidlohr Bueso <davidlohr@hp.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 9:55 PM, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> I reverted commits 99b60ce6 and b0c29f79. Then applied the patches in
> the above url. The last one had a reject but it was pretty
> straightforward to resolve it. After this, specjbb completes.
>
> So reverting and applying v3 3/4 and 4/4 patches works for me.

Ok, I verified that the above endds up resulting in the same tree as
the minimal patch I sent out, modulo (a) some comments and (b) an
#ifdef CONFIG_SMP in futex_get_mm() that doesn't really matter.

So I committed the minimal patch with your tested-by.

             Linus
