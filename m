Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E71D1A1E34
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 01:22:52 +1000 (AEST)
Received: by ykcf206 with SMTP id f206so13162454ykc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2015 08:22:50 -0700 (PDT)
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
To: Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com> <20150901214540.GI4029@linux.vnet.ibm.com>
 <20150902095906.GC25720@arm.com>
Cc: Waiman Long <waiman.long@hp.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Message-ID: <55E7145C.7050505@gmail.com>
Date: Wed, 2 Sep 2015 11:23:08 -0400
MIME-Version: 1.0
In-Reply-To: <20150902095906.GC25720@arm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Will,

On 09/02/2015 05:59 AM, Will Deacon wrote:
> I just thought it was worth making this point, because it is prohibited
> in SC and I don't want people to think that our RELEASE/ACQUIRE operations
> are SC (even though they happen to be on arm64).

This is interesting information. Does that mean that the following patch
should work? (I am not proposing to use it, just trying to understand if 
REL+ACQ will act as a full barrier on ARM64, which you say it does).

Thanks,
Pranith.

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d8c25b7..14a1b35 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -68,8 +68,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
                BUILD_BUG();
        }
 
-       smp_mb();
-       return ret;
+       return smp_load_acquire(ret);
 }
 
 #define xchg(ptr,x) \
