Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1nrW3V3tzDrnT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 19:24:59 +1100 (AEDT)
Subject: Re: [PATCH] KVM: PPC: Book3S: fix XIVE migration of pending interrupts
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20171212120204.6799-1-clg@kaod.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4be897d4-2d54-305b-8416-b32384de73a9@redhat.com>
Date: Wed, 20 Dec 2017 09:24:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171212120204.6799-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2017 13:02, Cédric Le Goater wrote:
> When restoring a pending interrupt, we are setting the Q bit to force
> a retrigger in xive_finish_unmask(). But we also need to force an EOI
> in this case to reach the same initial state : P=1, Q=0.
> 
> This can be done by not setting 'old_p' for pending interrupts which
> will inform xive_finish_unmask() that an EOI needs to be sent.
> 
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>  Tested with a guest running iozone.
> 
>  arch/powerpc/kvm/book3s_xive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

We really need this patch to fix VM migration on POWER9.
When will it be merged?

Thanks,
Laurent
