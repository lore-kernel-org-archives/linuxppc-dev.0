Return-Path: <andi@firstfloor.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 09D002C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 00:57:02 +1000 (EST)
From: Andi Kleen <andi@firstfloor.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Avoiding the dentry d_lock on final dput(),
 part deux: transactional memory
References: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
 <5249D897.1010109@hp.com>
 <CA+55aFw6tOVMw=pKE_knj4BOwTi_JAX=4N=-5_WduykNPotdww@mail.gmail.com>
Date: Wed, 02 Oct 2013 07:56:50 -0700
In-Reply-To: <CA+55aFw6tOVMw=pKE_knj4BOwTi_JAX=4N=-5_WduykNPotdww@mail.gmail.com>
 (Linus Torvalds's message of "Mon, 30 Sep 2013 13:04:34 -0700")
Message-ID: <87y56boh59.fsf@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Waiman Long <waiman.long@hp.com>, Peter Zijlstra <peterz@infradead.org>,
 "Norton, Scott J" <scott.norton@hp.com>, George Spelvin <linux@horizon.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Sep 30, 2013 at 1:01 PM, Waiman Long <waiman.long@hp.com> wrote:
>>
>> I think this patch is worth a trial if relevant hardware is more widely
>> available. The TSX code certainly need to be moved to an architecture
>> specific area and should be runtime enabled using a static key. We also need
>> more TSX support infrastructure in place first.
>
> I think we can pick that up from Andi's patches, he should have that.
> Although that did have very x86-specific naming (ie "xbegin"). And I
> don't think he used "asm goto" to quite the same advantage as this -
> and I think we do want to make sure that the overhead is minimal.

FWIW my version #0 used asm goto directly, but I later switched to not
using it to support more compilers and higher level abstractions (locks
etc.) and use the same intrinsics as the user level guys are using.

The two extra instructions from not using asm goto for xbegin
don't matter all that much in the end.

That's the old asm goto stuff I wrote originally
(user level version):

https://github.com/andikleen/tsx-tools/blob/master/include/rtm-goto.h

There was also a kernel version of it that patched, right 
now this is done in the main TSX patchkit like this:

https://git.kernel.org/cgit/linux/kernel/git/ak/linux-misc.git/commit/?h=hle312/rtm-base&id=9190346d57a9bc89e746aee774d07e54cd1e6e75

Essentially without RTM it just becomes and unconditional jump
to the abort handler, xabort is a nop, and xtest always returns 0.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
