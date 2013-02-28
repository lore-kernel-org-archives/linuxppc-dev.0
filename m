Return-Path: <walken@google.com>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C6042C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2013 22:34:34 +1100 (EST)
Received: by mail-ie0-f171.google.com with SMTP id 10so1914642ied.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2013 03:34:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130227192551.GA8333@redhat.com>
References: <51226F91.7000108@linux.vnet.ibm.com>
 <CACvQF53bdh4_BxF0y1fnTVR+T2OmRc0jmWQYftsvx92-fg-Lug@mail.gmail.com>
 <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CANN689FuuEb9wpV43DkTtgv6syvBYL-LQxByWznyAq8dkrhzBw@mail.gmail.com>
 <20130227192551.GA8333@redhat.com>
Date: Thu, 28 Feb 2013 19:34:31 +0800
Message-ID: <CANN689EhqoQAKALR7WhT3YrQh3=VDA2Dq3QX1yLuYU_gZAo_Tg@mail.gmail.com>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
From: Michel Lespinasse <walken@google.com>
To: Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lai Jiangshan <eag0628@gmail.com>, linux-doc@vger.kernel.org,
 peterz@infradead.org, fweisbec@gmail.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org, sbw@mit.edu,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 28, 2013 at 3:25 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 02/27, Michel Lespinasse wrote:
>>
>> +void lg_rwlock_local_read_lock(struct lgrwlock *lgrw)
>> +{
>> +       preempt_disable();
>> +
>> +       if (__this_cpu_read(*lgrw->local_refcnt) ||
>> +           arch_spin_trylock(this_cpu_ptr(lgrw->lglock->lock))) {
>> +               __this_cpu_inc(*lgrw->local_refcnt);
>
> Please look at __this_cpu_generic_to_op(). You need this_cpu_inc()
> to avoid the race with irs. The same for _read_unlock.

Hmmm, I was thinking that this was safe because while interrupts might
modify local_refcnt to acquire a nested read lock, they are expected
to release that lock as well which would set local_refcnt back to its
original value ???

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
