Return-Path: <B16395@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B3AD2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 22:57:55 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: "galak@kernel.crashing.org" <galak@kernel.crashing.org>
Subject: RE: [PATCH 0/4] powerpc/booke: Modifications to fsl booke cpu setup
 code
Date: Fri, 27 Jul 2012 12:57:42 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D1490BF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1341838357-16887-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1341838357-16887-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,
Can you please review this patch set.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, July 09, 2012 6:23 PM
> To: agraf@suse.de; galak@kernel.crashing.org; benh@kernel.crashing.org;
> linuxppc-dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org
> Cc: Sethi Varun-B16395
> Subject: [PATCH 0/4] powerpc/booke: Modifications to fsl booke cpu setup
> code
>=20
> Modifications are aimed specifically at the e500mc/e5500 cpu setup code.
> Following modifications are introduced by this patchset:
> 1. Move the E.HV check to the cpu setup code. Based on this check we
> manipulte the
>    CPU_FTR_EMB_HV flag (added as a part of e500mc KVM support) in the
> cpu_spec
>    structure. We determine the presence of this feature based on the
> MMUCFG[LPIDSIZE]
>    check and decide if we can setup the E.HV mode ivors.
> 2. Merge the 32 bit cpu setup code for e500mc/e5500 and define the
> "cpu_restore"
>    routine (for e5500/e6500) only for the 64 bit case. The cpu_restore
> routine
>    is used in the 64 bit case for setting up the secondary cores.
> 3. For the 64 bit case separate out e5500 cpu_setup and cpu_restore
> functions.
>    The cpu_setup function (for the primary core) is passed the cpu_spec
> pointer,
>    which is not there in case of the cpu_restore function. Also, in our
> case
>    we will have to manipulate the CPU_FTR_EMB_HV flag on the the primary
> core.
> 4. Added CPU_FTR_EMB_HV check for e5500.
>=20
> Varun Sethi (4):
>   Separate out E.HV check and ivor setup code.
>   Merge the PPC 32 e5500 setup code with e500mc setup and don't define
>   a restore routine for PPC 32.
>   Separate out restore_e5500/setup_e5500 routines and check for E.HV
>   mode before setting ivor setting code.
>   Add CPU_FTR_EMB_HV check for e5500.
>=20
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S |   74
> +++++++++++++++++++++++++----
>  arch/powerpc/kernel/cputable.c            |    4 ++
>  arch/powerpc/kernel/exceptions-64e.S      |   18 +------
>  arch/powerpc/kernel/head_fsl_booke.S      |   18 ++-----
>  4 files changed, 75 insertions(+), 39 deletions(-)
>=20
> --
> 1.7.4.1
