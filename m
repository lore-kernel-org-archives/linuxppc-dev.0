Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E5B3E2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:33:37 +1000 (EST)
Subject: Re: [PATCH] bookehv: Handle debug exception on guest exit
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D06FC1773@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Thu, 11 Apr 2013 13:33:28 -0500
Message-Id: <5A04ECFC-E828-4EBF-895B-043FC038ABB5@kernel.crashing.org>
References: <1363801557-27436-1-git-send-email-Bharat.Bhushan@freescale.com>
 <436085E0-D605-40C1-BCDF-EB4D24B01AFA@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC04D4@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC1773@039-SN2MPN1-013.039d.mgd.msft.net>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, KVM list <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Yoder Stuart-B08248 <b08248@freescale.com>,
 linuxppc list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 5, 2013, at 2:53 AM, Bhushan Bharat-R65777 wrote:

> Hi Kumar/Benh,
>=20
> After further looking into the code I think that if we correct the =
vector range below in DebugDebug handler then we do not need the change =
I provided in this patch.
>=20
> Here is the snapshot for 32 bit (head_booke.h, same will be true for =
64 bit):
>=20
> #define DEBUG_DEBUG_EXCEPTION                                          =
       \
>        START_EXCEPTION(DebugDebug);                                    =
      \
>        DEBUG_EXCEPTION_PROLOG;                                         =
      \
>                                                                        =
      \
>        /*                                                              =
      \
>         * If there is a single step or branch-taken exception in an    =
      \
>         * exception entry sequence, it was probably meant to apply to  =
      \
>         * the code where the exception occurred (since exception entry =
      \
>         * doesn't turn off DE automatically).  We simulate the effect  =
      \
>         * of turning off DE on entry to an exception handler by =
turning      \
>         * off DE in the DSRR1 value and clearing the debug status.     =
      \
>         */                                                             =
      \
>        mfspr   r10,SPRN_DBSR;          /* check single-step/branch =
taken */  \
>        andis.  r10,r10,(DBSR_IC|DBSR_BT)@h;                            =
      \
>        beq+    2f;                                                     =
      \
>                                                                        =
      \
>        lis     r10,KERNELBASE@h;       /* check if exception in =
vectors */   \
>        ori     r10,r10,KERNELBASE@l;                                   =
      \
>        cmplw   r12,r10;                                                =
      \
>        blt+    2f;                     /* addr below exception vectors =
*/    \
>                                                                        =
      \
>        lis     r10,DebugDebug@h;                                       =
 \
>        ori     r10,r10,DebugDebug@l;                                   =
         \
>=20
> ^^^^
> 	Here we assume all exception vector ends at DebugDebug, which is =
not correct.
> 	We probably should get proper end by using some start_vector and =
end_vector lebels
> 	or at least use end at Ehvpriv (which is last defined in =
head_fsl_booke.S for PowerPC. Is that correct?
>=20
> =09
>        cmplw   r12,r10;                                                =
      \
>        bgt+    2f;                     /* addr above exception vectors =
*/    \
>=20
> Thanks
> -Bharat

I talked to Stuart and this general approach is good.  Just make sure to =
update both head_44x.S and head_fsl_booke.S.  Plus do this for both =
DEBUG_CRIT_EXCEPTION & DEBUG_DEBUG_EXCEPTION

- k=
