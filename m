Return-Path: <fw@deneb.enyo.de>
Received: from albireo.enyo.de (albireo.enyo.de [5.158.152.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWLkG0k7NzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 18:32:53 +1100 (AEDT)
From: Florian Weimer <fw@deneb.enyo.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org,
 ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org,
 dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
Date: Tue, 07 Nov 2017 08:32:16 +0100
In-Reply-To: <20171107012218.GA5546@ram.oc3035372033.ibm.com> (Ram Pai's
 message of "Mon, 6 Nov 2017 17:22:18 -0800")
Message-ID: <87h8u6lf27.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Ram Pai:

> On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
>> * Ram Pai:
>>=20
>> > Testing:
>> > -------
>> > This patch series has passed all the protection key
>> > tests available in the selftest directory.The
>> > tests are updated to work on both x86 and powerpc.
>> > The selftests have passed on x86 and powerpc hardware.
>>=20
>> How do you deal with the key reuse problem?  Is it the same as x86-64,
>> where it's quite easy to accidentally grant existing threads access to
>> a just-allocated key, either due to key reuse or a changed init_pkru
>> parameter?
>
> I am not sure how on x86-64, two threads get allocated the same key
> at the same time? the key allocation is guarded under the mmap_sem
> semaphore. So there cannot be a race where two threads get allocated
> the same key.

The problem is a pkey_alloc/pthread_create/pkey_free/pkey_alloc
sequence.  The pthread_create call makes the new thread inherit the
access rights of the current thread, but then the key is deallocated.
Reallocation of the same key will have that thread retain its access
rights, which is IMHO not correct.

> Can you point me to the issue, if it is already discussed somewhere?

See =E2=80=98MPK: pkey_free and key reuse=E2=80=99 on various lists (includ=
ing
linux-mm and linux-arch).

It has a test case attached which demonstrates the behavior.

> As far as the semantics is concerned, a key allocated in one thread's
> context has no meaning if used in some other threads context within the
> same process.  The app should not try to re-use a key allocated in a
> thread's context in some other threads's context.

Uh-oh, that's not how this feature works on x86-64 at all.  There, the
keys are a process-global resource.  Treating them per-thread
seriously reduces their usefulness.

>> What about siglongjmp from a signal handler?
>
> On powerpc there is some relief.  the permissions on a key can be
> modified from anywhere, including from the signal handler, and the
> effect will be immediate.  You dont have to wait till the
> signal handler returns for the key permissions to be restore.

My concern is that the signal handler knows nothing about protection
keys, but the current x86-64 semantics will cause it to clobber the
access rights of the current thread.

> also after return from the sigsetjmp();
> possibly caused by siglongjmp(), the program can restore the permission
> on any key.

So that's not really an option.

> Atleast that is my theory. Can you give me a testcase; if you have one
> handy.

The glibc patch I posted under the =E2=80=98MPK: pkey_free and key reuse=E2=
=80=99
thread covers this, too.
