Return-Path: <b08248@gmail.com>
Received: from mail-da0-x231.google.com (mail-da0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C0FD2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:44:51 +1000 (EST)
Received: by mail-da0-f49.google.com with SMTP id t11so787771daj.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:44:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALRxmdD7ZWj4PM5VTZz_RimmgQAJCX=5yUx=H+7-W30r-PdTtA@mail.gmail.com>
References: <1363801557-27436-1-git-send-email-Bharat.Bhushan@freescale.com>
 <436085E0-D605-40C1-BCDF-EB4D24B01AFA@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC04D4@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC1773@039-SN2MPN1-013.039d.mgd.msft.net>
 <5A04ECFC-E828-4EBF-895B-043FC038ABB5@kernel.crashing.org>
 <CALRxmdD7ZWj4PM5VTZz_RimmgQAJCX=5yUx=H+7-W30r-PdTtA@mail.gmail.com>
Date: Thu, 11 Apr 2013 13:44:49 -0500
Message-ID: <CALRxmdDpwpy=SERuVe4JzUQz=vQYFrcydB7MaAF8KbYKWT5U-A@mail.gmail.com>
Subject: Re: [PATCH] bookehv: Handle debug exception on guest exit
From: Stuart Yoder <b08248@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>, KVM list <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Yoder Stuart-B08248 <b08248@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 linuxppc list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So the patch should look something like this (on a 3.8 kernel):

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 5f051ee..92b675a 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -286,13 +286,13 @@ label:
        andis.  r10,r10,(DBSR_IC|DBSR_BT)@h;                                  \
        beq+    2f;                                                           \
                                                                              \
-       lis     r10,KERNELBASE@h;       /* check if exception in vectors */   \
-       ori     r10,r10,KERNELBASE@l;                                         \
+       lis     r10,interrupt_base@h;   /* check if exception in vectors */   \
+       ori     r10,r10,interrupt_base@l;
        cmplw   r12,r10;                                                      \
        blt+    2f;                     /* addr below exception vectors */    \
                                                                              \
-       lis     r10,DebugDebug@h;                                             \
-       ori     r10,r10,DebugDebug@l;                                         \
+       lis     r10,interrupt_end@h;                                          \
+       ori     r10,r10,interrupt_end@l;
        cmplw   r12,r10;                                                      \
        bgt+    2f;                     /* addr above exception vectors */    \
                                                                              \
@@ -339,13 +339,13 @@ label:
        andis.  r10,r10,(DBSR_IC|DBSR_BT)@h;                                  \
        beq+    2f;                                                           \
                                                                              \
-       lis     r10,KERNELBASE@h;       /* check if exception in vectors */   \
-       ori     r10,r10,KERNELBASE@l;                                         \
+       lis     r10,interrupt_base@h;   /* check if exception in vectors */   \
+       ori     r10,r10,interrupt_base@l;
        cmplw   r12,r10;                                                      \
        blt+    2f;                     /* addr below exception vectors */    \
                                                                              \
-       lis     r10,DebugCrit@h;                                              \
-       ori     r10,r10,DebugCrit@l;                                          \
+       lis     r10,interrupt_end@h;                                          \
+       ori     r10,r10,interrupt_end@l;
        cmplw   r12,r10;                                                      \
        bgt+    2f;                     /* addr above exception vectors */    \
                                                                              \


diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 7a2e5e4..97e2671 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -769,6 +769,8 @@ finish_tlb_load_47x:
         */
        DEBUG_CRIT_EXCEPTION

+interrupt_end:
+
 /*
  * Global functions
  */


diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl
index 58925b6..2c3e31d 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -605,6 +605,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
        /* Embedded Hypervisor Privilege */
        EXCEPTION(0, HV_PRIV, Ehvpriv, unknown_exception, EXC_XFER_EE)

+interrupt_end:
+
 /*
  * Local functions
  */
