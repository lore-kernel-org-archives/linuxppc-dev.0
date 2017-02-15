Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNcVk632dzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 22:28:46 +1100 (AEDT)
Subject: Re: linux-next: manual merge of the kvm tree with the powerpc tree
To: Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <20170210145943.5bf98310@canb.auug.org.au>
 <60b17c77-fb90-20e7-8cc7-a5970d2e5691@redhat.com>
 <87k28tma8d.fsf@concordia.ellerman.id.au>
 <4a43b8ed-bd08-f8e8-e749-178bb3bac815@redhat.com>
 <8760kbln52.fsf@concordia.ellerman.id.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3828e13-3ca8-db6e-0ea7-4427a1be2815@redhat.com>
Date: Wed, 15 Feb 2017 12:28:45 +0100
MIME-Version: 1.0
In-Reply-To: <8760kbln52.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/02/2017 12:16, Michael Ellerman wrote:
>> However, the reason was that this is simply not how topic branches
>> should work: topic branches should be the base for other work, they
>> shouldn't contain _all_ the work.
> 
> I think that's an overly specific definition of what a topic branch is.
> 
> It's just a branch related to some "topic", in this case powerpc kvm,
> where commits can go so they can be shared between two trees.

Right.  However, in the specific case of working across maintainers, I
think there is an interest in minimizing the number of files that are
updated in two trees.  That limits conflicts.

Typically in x86 land people send a series with generic+KVM patches,
Thomas Gleixner picks the generic ones and places them in a topic branch
that we both pull from.  I then apply the KVM patches independently.
It's worth noting that x86 arch maintainers don't care that much about
what's going on in arch/x86/kvm/, and especially they delegate all
testing to me.  So I guess that may be the source of the disagreement.

If you would like to unify testing of non-KVM and KVM code for
arch/powerpc, it doesn't make much sense for Paul to send his patches to
me at all.  Instead, _I_ should prepare topic branches for Paul whenever
I make sweeping all-arch changes to KVM, that he can include in his pull
requests to you.  It'd feel weird though.

Paolo

>> As far as I understand, there was no reason for you to get B1.
>
> Well no reason other than it's ~1300 lines of code in my arch, which I
> would like to go through my normal testing procedures.
