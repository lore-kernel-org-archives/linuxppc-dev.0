Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4Yz42nl2zDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 21:38:24 +1000 (AEST)
Date: Wed, 11 May 2016 21:36:31 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dgibson@redhat.com, thuth@redhat.com
Subject: Re: [PATCH v2] kvm-pr: manage single-step mode
Message-ID: <20160511113631.GA10249@fergus.ozlabs.ibm.com>
References: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2016 at 06:05:00PM +0200, Laurent Vivier wrote:
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

Thanks, applied to my kvm-ppc-next branch.

Paul.
