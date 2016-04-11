Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk4tq0HZgzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 19:45:38 +1000 (AEST)
Subject: Re: [PATCH v2] kvm-pr: manage single-step mode
To: Laurent Vivier <lvivier@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
References: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dgibson@redhat.com
From: Thomas Huth <thuth@redhat.com>
Message-ID: <570B723B.7010404@redhat.com>
Date: Mon, 11 Apr 2016 11:45:31 +0200
MIME-Version: 1.0
In-Reply-To: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.04.2016 18:05, Laurent Vivier wrote:
> Until now, when we connect gdb to the QEMU gdb-server, the
> single-step mode is not managed.
> 
> This patch adds this, only for kvm-pr:
> 
> If KVM_GUESTDBG_SINGLESTEP is set, we enable single-step trace bit in the
> MSR (MSR_SE) just before the __kvmppc_vcpu_run(), and disable it just after.
> In kvmppc_handle_exit_pr, instead of routing the interrupt to
> the guest, we return to host, with KVM_EXIT_DEBUG reason.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: split BOOK3S_INTERRUPT_MACHINE_CHECK and BOOK3S_INTERRUPT_TRACE
> 
>  arch/powerpc/kvm/book3s_pr.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
