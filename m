Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E6D92C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 05:16:52 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 19 Feb 2013 04:10:46 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 90588357804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 05:16:46 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1II4J7w1769920
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 05:04:19 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IIGiVR007699
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 05:16:46 +1100
Message-ID: <51226F91.7000108@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2013 23:44:41 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
 <CANN689F9S7c1M8+cEpz3tsxGF34+NTRBLvxgPUOtbvav5u+RRA@mail.gmail.com>
 <5122551E.1080703@linux.vnet.ibm.com> <51226B46.9080707@linux.vnet.ibm.com>
 <CANN689FSxOz+0Cu7EG_yKD8ZE1OpT4kyT+ybLfXSqaifodJRpw@mail.gmail.com>
In-Reply-To: <CANN689FSxOz+0Cu7EG_yKD8ZE1OpT4kyT+ybLfXSqaifodJRpw@mail.gmail.com>
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

On 02/18/2013 11:37 PM, Michel Lespinasse wrote:
> On Tue, Feb 19, 2013 at 1:56 AM, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> On 02/18/2013 09:51 PM, Srivatsa S. Bhat wrote:
>>> On 02/18/2013 09:15 PM, Michel Lespinasse wrote:
>>>> I don't see anything preventing a race with the corresponding code in
>>>> percpu_write_unlock() that sets writer_signal back to false. Did I
>>>> miss something here ? It seems to me we don't have any guarantee that
>>>> all writer signals will be set to true at the end of the loop...
>>>
>>> Ah, thanks for pointing that out! IIRC Oleg had pointed this issue in the last
>>> version, but back then, I hadn't fully understood what he meant. Your
>>> explanation made it clear. I'll work on fixing this.
>>
>> We can fix this by using the simple patch (untested) shown below.
>> The alternative would be to acquire the rwlock for write, update the
>> ->writer_signal values, release the lock, wait for readers to switch,
>> again acquire the rwlock for write with interrupts disabled etc... which
>> makes it kinda messy, IMHO. So I prefer the simple version shown below.
> 
> Looks good.
> 
> Another alternative would be to make writer_signal an atomic integer
> instead of a bool. That way writers can increment it before locking
> and decrement it while unlocking.
> 

Yep, that would also do. But the spinlock version looks simpler - no need
to check if the atomic counter is non-zero, no need to explicitly spin in
a tight-loop etc.

> To reduce the number of atomic ops during writer lock/unlock, the
> writer_signal could also be a global read_mostly variable (I don't see
> any downsides to that compared to having it percpu - or is it because
> you wanted all the fastpath state to be in one single cacheline ?)
> 

Yes, we (Oleg and I) debated for a while about global vs percpu, and then
finally decided to go with percpu to have cache benefits.

Regards,
Srivatsa S. Bhat
