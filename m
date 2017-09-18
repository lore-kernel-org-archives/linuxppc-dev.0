Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwc1Y3P1LzDrDg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 16:44:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: sachinp@linux.vnet.ibm.com, kvm@vger.kernel.org, =?utf-8?Q?Jan_H=2E_Sc?=
 =?utf-8?Q?h=C3=B6nherr?= <jschoenh@amazon.de>,
 linux-kernel@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Revert "KVM: Don't accept obviously wrong gsi values via
 KVM_IRQFD"
In-Reply-To: <1505592744-31498-1-git-send-email-jschoenh@amazon.de>
References: <04cde7c8-d41f-96e2-2b4b-2287b8f04bfc@amazon.de>
 <1505592744-31498-1-git-send-email-jschoenh@amazon.de>
Date: Mon, 18 Sep 2017 16:44:32 +1000
Message-ID: <871sn4jyjz.fsf@concordia.ellerman.id.au>
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

"Jan H. Sch=C3=B6nherr" <jschoenh@amazon.de> writes:

> This reverts commit 36ae3c0a36b7456432fedce38ae2f7bd3e01a563.
>
> The commit broke compilation on !CONFIG_HAVE_KVM_IRQ_ROUTING. Also,
> there may be cases with CONFIG_HAVE_KVM_IRQ_ROUTING, where larger
> gsi values make sense.
>
> As the commit was meant as an early indicator to user space that
> something is wrong, reverting just restores the previous behavior
> where overly large values are ignored when encountered (without
> any direct feedback).
>
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
> ---
>  virt/kvm/eventfd.c | 2 --
>  1 file changed, 2 deletions(-)

Can someone merge this or preferably just send it straight to Linus, the
original patch has broken the powerpc build in mainline.

cheers
