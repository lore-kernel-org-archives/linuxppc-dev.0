Return-Path: <michael.neuling@gmail.com>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFF112C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 14:52:31 +1000 (EST)
Received: by mail-pd0-f170.google.com with SMTP id x10so6698401pdj.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 21:52:28 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <20131001031356.GP19582@linux.vnet.ibm.com>
References: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
 <1380581522.6396.20.camel@pasglop>
 <23118.1380587771@ale.ozlabs.ibm.com>
 <CA+55aFwi5sZK4mFxs3PT1wU4_vNzsLOFiocqi3g14fPamKXYsw@mail.gmail.com>
 <1380593103.6396.38.camel@pasglop>
 <20131001031356.GP19582@linux.vnet.ibm.com>
Date: Tue, 1 Oct 2013 14:52:28 +1000
Message-ID: <CAEjGV6xuscOh=t6BhbdRKAPcZ1DOJkD6ZcB1wgTf9-AedKSaxA@mail.gmail.com>
Subject: Re: Avoiding the dentry d_lock on final dput(), part deux:
 transactional memory
From: Michael Neuling <mikey@neuling.org>
To: paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Waiman Long <Waiman.Long@hp.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, George Spelvin <linux@horizon.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Well we don't have to, I think Mikey wasn't totally clear about that
>> "making all registers volatile" business :-) This is just something we
>> need to handle in assembly if we are going to reclaim the suspended
>> transaction.

Yeah, sorry.  The slow path with all registers as volatile is only
needed if we get pre-empted during the transaction.

>>
>> So basically, what we need is something along the lines of
>> enable_kernel_tm() which checks if there's a suspended user transaction
>> and if yes, kills/reclaims it.
>>
>> Then we also need to handle in our interrupt handlers that we have an
>> active/suspended transaction from a kernel state, which we don't deal
>> with at this point, and do whatever has to be done to kill it... we
>> might get away with something simple if we can state that we only allow
>> kernel transactions at task level and not from interrupt/softirq
>> contexts, at least initially.
>
> Call me a coward, but this is starting to sound a bit scary.  ;-)

We are just wanting to prototype it for now to see if we could make it
go faster.  If it's worth it, then we'd consider the additional
complexity this would bring.

I don't think it'll be that bad, but I'd certainly want to make sure
it's worth it before trying :-)

Mikey
