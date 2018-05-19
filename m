Return-Path: <luto@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40np0b2dT5zDrCQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 11:50:54 +1000 (AEST)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2740720859
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 01:50:52 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id a8-v6so16809814wmg.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 18:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <53828769-23c4-b2e3-cf59-239936819c3e@redhat.com>
 <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
In-Reply-To: <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 18 May 2018 18:50:39 -0700
Message-ID: <CALCETrWMP9kTmAFCR0WHR3YP93gLSzgxhfnb0ma_0q=PCuSdQA@mail.gmail.com>
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: linuxram@us.ibm.com
Cc: Florian Weimer <fweimer@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 6:19 PM Ram Pai <linuxram@us.ibm.com> wrote:

> However the fundamental issue is still the same, as mentioned in the
> other thread.

> "Should the permissions on a key be allowed to be changed, if the key
> is not allocated in the first place?".

> my answer is NO. Lets debate :)

As a preface, here's my two-minute attempt to understand POWER's behavior:
there are two registers, AMR and UAMR.  AMR contains both kernel-relevant
state and user-relevant state.  UAMR specifies which bits of AMR are
available for user code to directly access.  AMR bits outside UAMR are read
as zero and are unaffected by writes.  I'm assuming that the kernel
reserves some subset of AMR bits in advance to correspond to allocatable
pkeys.

Here's my question: given that disallowed AMR bits are read-as-zero, there
can always be a thread that is in the middle of a sequence like:

unsigned long old = amr;
amr |= whatever;
...  <- thread is here
amr = old;

Now another thread calls pkey_alloc(), so UAMR is asynchronously changed,
and the thread will write zero to the relevant AMR bits.  If I understand
correctly, this means that the decision to mask off unallocated keys via
UAMR effectively forces the initial value of newly-allocated keys in other
threads in the allocating process to be zero, whatever zero means.  (I
didn't get far enough in the POWER docs to figure out what zero means.)  So
I don't think you're doing anyone any favors by making UAMR dynamic.

IOW both x86 and POWER screwed up the ISA.
