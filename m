Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwx23mNLzDqxt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:45:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Marcelo Tosatti <mtosatti@redhat.com>,
 Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: manual merge of the kvm tree with the powerpc tree
In-Reply-To: <60b17c77-fb90-20e7-8cc7-a5970d2e5691@redhat.com>
References: <20170210145943.5bf98310@canb.auug.org.au>
 <60b17c77-fb90-20e7-8cc7-a5970d2e5691@redhat.com>
Date: Tue, 14 Feb 2017 19:45:38 +1100
Message-ID: <87k28tma8d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/02/2017 04:59, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next merge of the kvm tree got a conflict in:
>> 
>>   arch/powerpc/include/asm/head-64.h
>> 
>> between commit:
>> 
>>   852e5da99d15 ("powerpc/64s: Tidy up after exception handler rework")
>> 
>> from the powerpc tree and commit:
>> 
>>   7ede531773ea ("KVM: PPC: Book3S: Move 64-bit KVM interrupt handler out from alt section")
>> 
>> from the kvm tree.
>
> Michael, please pull the topic branch as soon as possible, so that the
> conflicts don't hit Linus.

They won't hit Linus until I send my pull request.

> That said, the topic branch is a mess.  It starts with generic arch
> patches (until "powerpc/64: Allow for relocation-on interrupts from
> guest to host") then it's only KVM, then on the top there's two more
> generic patches that were added _after_ Paul merged it.

It's not a mess, it's a collection of patches which touch either arch/powerpc
or arch/powerpc/kvm, or are otherwise related.

Yeah I could have merged just the start of Paul's series, but that
seemed pointless, it doesn't prevent or add any conflicts, and it means
I'm unable to test his series as a whole.

Paul has also now merged the remaining two commits, and sent you a pull
request including them.

> If possible, please pull only up to "powerpc/64: Allow for relocation-on
> interrupts from guest to host" and cherry-pick the top two patches
> ("powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts" and
> "powerpc/powernv: Remove separate entry for OPAL real mode calls") into
> your next branch, but leave the rest for my tree only.

I don't see how that helps anything.

In fact it guarantees a mess because those two commits would now go to
Linus via my tree (cherry picked) and via Paul's as part of his second
merge of the topic branch.

So unless you can give me a good reason I'll merge the tip of the topic
branch into my next, as planned.

cheers
