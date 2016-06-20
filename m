Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXzfp11rZzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 15:18:58 +1000 (AEST)
Date: Mon, 20 Jun 2016 15:18:53 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 kvm@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
Message-ID: <20160620051853.GA29366@fergus.ozlabs.ibm.com>
References: <20160113070759.20248.86252.stgit@aravindap>
 <20160113070809.20248.80811.stgit@aravindap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160113070809.20248.80811.stgit@aravindap>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aravinda,

On Wed, Jan 13, 2016 at 12:38:09PM +0530, Aravinda Prasad wrote:
> Enhance KVM to cause a guest exit with KVM_EXIT_NMI
> exit reasons upon a machine check exception (MCE) in
> the guest address space if the KVM_CAP_PPC_FWNMI
> capability is enabled (instead of delivering 0x200
> interrupt to guest). This enables QEMU to build error
> log and deliver machine check exception to guest via
> guest registered machine check handler.
> 
> This approach simplifies the delivering of machine
> check exception to guest OS compared to the earlier
> approach of KVM directly invoking 0x200 guest interrupt
> vector. In the earlier approach QEMU was enhanced to
> patch the 0x200 interrupt vector during boot. The
> patched code at 0x200 issued a private hcall to pass
> the control to QEMU to build the error log.
> 
> This design/approach is based on the feedback for the
> QEMU patches to handle machine check exception. Details
> of earlier approach of handling machine check exception
> in QEMU and related discussions can be found at:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Are you in the process of doing a new version of this patch with the
requested changes?

Paul.
