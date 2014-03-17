Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A62E2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Mar 2014 01:40:08 +1100 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH 05/10] powerpc/booke64: Use SPRG7 for VDSO
Date: Mon, 17 Mar 2014 14:25:04 +0000
Message-ID: <6d48e69b2d7f466eaa1af7b8e04a8d16@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
 <1394755249-8856-6-git-send-email-scottwood@freescale.com>
In-Reply-To: <1394755249-8856-6-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Tiejun Chen <tiejun.chen@windriver.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, March 14, 2014 2:01 AM
> To: Benjamin Herrenschmidt
> Cc: linuxppc-dev@lists.ozlabs.org; Kumar Gala; Tiejun Chen; Wood Scott-
> B07421; Caraman Mihai Claudiu-B02008; Anton Blanchard; Paul Mackerras;
> kvm-ppc@vger.kernel.org
> Subject: [PATCH 05/10] powerpc/booke64: Use SPRG7 for VDSO
>=20
> Previously SPRG3 was marked for use by both VDSO and critical
> interrupts (though critical interrupts were not fully implemented).
>=20
> In commit 8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad ("powerpc/booke64:
> Use SPRG0/3 scratch for bolted TLB miss & crit int"), Mihai Caraman
> made an attempt to resolve this conflict by restoring the VDSO value
> early in the critical interrupt, but this has some issues:
>=20

>  - It forces critical exceptions to be a special case handled
>    differently from even machine check and debug level exceptions.

Yes, this was ugly.

> Since we cannot use SPRG4-7 for scratch without corrupting the state of
> a KVM guest, move VDSO to SPRG7 on book3e.

At that time I thought that information exposed through SPRN_USPRG3 is
part of the ABI which can't be changed, and this lead to complicated
gymnastic. But since VSDO's __kernel_getcpu() function hides SPRN_USPRGx
access, I think your unified approach is the right way.

-Mike
