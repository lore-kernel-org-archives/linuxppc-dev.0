Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtC6f5DKSzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 15:54:18 +1000 (AEST)
Date: Mon, 18 Jul 2016 15:54:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Mahesh
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20160718155418.2ca9a858@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/powerpc/kernel/exceptions-64s.S

between commit:

  9baaef0a22c8 ("powerpc/irq: Add support for HV virtualization interrupts")

from the powerpc tree and commit:

  fd7bacbca47a ("KVM: PPC: Book3S HV: Fix TB corruption in guest exit path on HMI interrupt")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/exceptions-64s.S
index 6200e4925d26,0eba47e074b9..000000000000
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@@ -669,8 -680,8 +669,10 @@@ _GLOBAL(__replay_interrupt
  BEGIN_FTR_SECTION
  	cmpwi	r3,0xe80
  	beq	h_doorbell_common
 +	cmpwi	r3,0xea0
 +	beq	h_virt_irq_common
+ 	cmpwi	r3,0xe60
+ 	beq	hmi_exception_common
  FTR_SECTION_ELSE
  	cmpwi	r3,0xa00
  	beq	doorbell_super_common
@@@ -1161,18 -1172,9 +1163,18 @@@ fwnmi_data_area
  	. = 0x8000
  #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
  
 +	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
 +	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
 +
 +#ifdef CONFIG_CBE_RAS
 +	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
 +	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
 +	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
 +#endif /* CONFIG_CBE_RAS */
 +
  	.globl hmi_exception_early
  hmi_exception_early:
- 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
+ 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, 0xe62)
  	mr	r10,r1			/* Save r1			*/
  	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
  	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
