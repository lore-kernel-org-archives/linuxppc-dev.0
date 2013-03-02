Return-Path: <walken@google.com>
Received: from mail-ia0-x22c.google.com (mail-ia0-x22c.google.com
 [IPv6:2607:f8b0:4001:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBE742C02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 23:13:21 +1100 (EST)
Received: by mail-ia0-f172.google.com with SMTP id l29so3497931iag.31
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Mar 2013 04:13:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130301182854.GA3631@redhat.com>
References: <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
Date: Sat, 2 Mar 2013 20:13:17 +0800
Message-ID: <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
Subject: Re: [PATCH] lglock: add read-preference local-global rwlock
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
 linux-arm-kernel@lists.infradead.org, Lai Jiangshan <laijs@cn.fujitsu.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, sbw@mit.edu,
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

On Sat, Mar 2, 2013 at 2:28 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> Lai, I didn't read this discussion except the code posted by Michel.
> I'll try to read this patch carefully later, but I'd like to ask
> a couple of questions.
>
> This version looks more complex than Michel's, why? Just curious, I
> am trying to understand what I missed. See
> http://marc.info/?l=linux-kernel&m=136196350213593

>From what I can see, my version used local_refcnt to count how many
reentrant locks are represented by the fastpath lglock spinlock; Lai's
version uses it to count how many reentrant locks are represented by
either the fastpath lglock spinlock or the global rwlock, with
FALLBACK_BASE being a bit thrown in so we can remember which of these
locks was acquired. My version would be slower if it needs to take the
slow path in a reentrant way, but I'm not sure it matters either :)

> Interrupt handler on CPU_1 does _read_lock() notices ->reader_refcnt != 0
> and simply does this_cpu_inc(), so reader_refcnt == FALLBACK_BASE + 1.
>
> Then irq does _read_unlock(), and
>
>> +void lg_rwlock_local_read_unlock(struct lgrwlock *lgrw)
>> +{
>> +     switch (__this_cpu_dec_return(*lgrw->reader_refcnt)) {
>> +     case 0:
>> +             lg_local_unlock(&lgrw->lglock);
>> +             return;
>> +     case FALLBACK_BASE:
>> +             __this_cpu_sub(*lgrw->reader_refcnt, FALLBACK_BASE);
>> +             read_unlock(&lgrw->fallback_rwlock);
>
> hits this case?
>
> Doesn't look right, but most probably I missed something.

Good catch. I think this is easily fixed by setting reader_refcn
directly to FALLBACK_BASE+1, instead of setting it to FALLBACK_BASE
and then incrementing it to FALLBACK_BASE+1.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
