Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B90861A007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 05:59:10 +1100 (AEDT)
Received: by mail-ig0-x232.google.com with SMTP id y8so84147539igp.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 10:59:10 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160215175825.GA15878@linux.vnet.ibm.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 10:59:08 -0800
Message-ID: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
Subject: Re: Writes, smp_wmb(), and transitivity?
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Andy.Glew@imgtec.com,
 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-metag@vger.kernel.org,
 linux-mips <linux-mips@linux-mips.org>, linux-xtensa@linux-xtensa.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, graham.whaley@gmail.com,
 Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Two threads:
>
>         int a, b;
>
>         void thread0(void)
>         {
>                 WRITE_ONCE(a, 1);
>                 smp_wmb();
>                 WRITE_ONCE(b, 2);
>         }
>
>         void thread1(void)
>         {
>                 WRITE_ONCE(b, 1);
>                 smp_wmb();
>                 WRITE_ONCE(a, 2);
>         }
>
>         /* After all threads have completed and the dust has settled... */
>
>         BUG_ON(a == 1 && b == 1);

So the more I look at that kind of litmus test, the less I think that
we should care, because I can't come up with a scenario in where that
kind of test makes sense. without even a possibility of any causal
relationship between the two, I can't say why we'd ever care about the
ordering of the (independent) writes to the individual variables.

If somebody can make up a causal chain, things differ. But as long as
all the CPU's are just doing locally ordered writes, I don't think we
need to care about a global store ordering.

              Linus
