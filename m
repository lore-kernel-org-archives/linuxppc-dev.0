Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKVw03hrCzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 21:06:24 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id k90so14548103wrc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 02:06:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: linux-next: manual merge of the kvm tree with the powerpc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <20170210145943.5bf98310@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60b17c77-fb90-20e7-8cc7-a5970d2e5691@redhat.com>
Date: Fri, 10 Feb 2017 11:06:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170210145943.5bf98310@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/02/2017 04:59, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm tree got a conflict in:
> 
>   arch/powerpc/include/asm/head-64.h
> 
> between commit:
> 
>   852e5da99d15 ("powerpc/64s: Tidy up after exception handler rework")
> 
> from the powerpc tree and commit:
> 
>   7ede531773ea ("KVM: PPC: Book3S: Move 64-bit KVM interrupt handler out from alt section")
> 
> from the kvm tree.
>
> Today's linux-next merge of the kvm tree got a conflict in:
> 
>   arch/powerpc/kernel/exceptions-64s.S
> 
> between commit:
> 
>   1a6822d194c3 ("powerpc/64s: Use (start, size) rather than (start, end) for exception handlers")
> 
> from the powerpc tree and commit:
> 
>   bc3551257af8 ("powerpc/64: Allow for relocation-on interrupts from guest to host")
> 
> from the kvm tree.

Michael, please pull the topic branch as soon as possible, so that the
conflicts don't hit Linus.

That said, the topic branch is a mess.  It starts with generic arch
patches (until "powerpc/64: Allow for relocation-on interrupts from
guest to host") then it's only KVM, then on the top there's two more
generic patches that were added _after_ Paul merged it.

If possible, please pull only up to "powerpc/64: Allow for relocation-on
interrupts from guest to host" and cherry-pick the top two patches
("powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts" and
"powerpc/powernv: Remove separate entry for OPAL real mode calls") into
your next branch, but leave the rest for my tree only.

Paolo
