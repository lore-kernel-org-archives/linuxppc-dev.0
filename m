Return-Path: <rkrcmar@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8g3K5j4WzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 04:41:33 +1000 (AEST)
Date: Wed, 10 Aug 2016 20:41:27 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: move hmi.c to arch/powerpc/kvm/
Message-ID: <20160810184127.GA27257@potion>
References: <1470224194-15412-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470224194-15412-1-git-send-email-pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2016-08-03 13:36+0200, Paolo Bonzini:
> hmi.c functions are unused unless sibling_subcore_state is nonzero, and
> that in turn happens only if KVM is in use.  So move the code to
> arch/powerpc/kvm/, putting it under CONFIG_KVM_BOOK3S_64_HANDLER
> rather than CONFIG_PPC_BOOK3S_64.  The sibling_subcore_state is also
> included in struct paca_struct only if KVM is supported by the kernel.
> 
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	It would be nice to have this in 4.8, to minimize any 4.9 conflicts.
> 	Build-tested only, with and without KVM enabled.

If you agree with the change, would you prefer to have this patch merged
through the PowerPC tree?

(There are no expected conflicts with -rc2 KVM tree.)

Thanks.
