Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY6wG0WXbzDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 11:46:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Daniel Axtens <dja@axtens.net>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: move hmi.c to arch/powerpc/kvm/
In-Reply-To: <20160912005621.GE9873@fergus.ozlabs.ibm.com>
References: <1470920863-15375-1-git-send-email-pbonzini@redhat.com>
 <20160912005621.GE9873@fergus.ozlabs.ibm.com>
Date: Tue, 13 Sep 2016 11:46:21 +1000
Message-ID: <87oa3spo5u.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Thu, Aug 11, 2016 at 03:07:43PM +0200, Paolo Bonzini wrote:
>> hmi.c functions are unused unless sibling_subcore_state is nonzero, and
>> that in turn happens only if KVM is in use.  So move the code to
>> arch/powerpc/kvm/, putting it under CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> rather than CONFIG_PPC_BOOK3S_64.  The sibling_subcore_state is also
>> included in struct paca_struct only if KVM is supported by the kernel.
>> 
>> Cc: Daniel Axtens <dja@axtens.net>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: kvm-ppc@vger.kernel.org
>> Cc: kvm@vger.kernel.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Thanks, patch applied to my kvm-ppc-infrastructure branch, which is
> merged into my kvm-ppc-next branch.

Ben already merged this into the powerpc tree, which has since gone to
Linus:

  https://git.kernel.org/torvalds/c/7c379526d7e7

cheers
