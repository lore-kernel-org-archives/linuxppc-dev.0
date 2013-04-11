Return-Path: <b08248@gmail.com>
Received: from mail-da0-x234.google.com (mail-da0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E43F2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 04:37:08 +1000 (EST)
Received: by mail-da0-f52.google.com with SMTP id f10so795183dak.39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:37:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5A04ECFC-E828-4EBF-895B-043FC038ABB5@kernel.crashing.org>
References: <1363801557-27436-1-git-send-email-Bharat.Bhushan@freescale.com>
 <436085E0-D605-40C1-BCDF-EB4D24B01AFA@suse.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC04D4@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D06FC1773@039-SN2MPN1-013.039d.mgd.msft.net>
 <5A04ECFC-E828-4EBF-895B-043FC038ABB5@kernel.crashing.org>
Date: Thu, 11 Apr 2013 13:37:05 -0500
Message-ID: <CALRxmdD7ZWj4PM5VTZz_RimmgQAJCX=5yUx=H+7-W30r-PdTtA@mail.gmail.com>
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

On Thu, Apr 11, 2013 at 1:33 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Apr 5, 2013, at 2:53 AM, Bhushan Bharat-R65777 wrote:
>
>> Hi Kumar/Benh,
>>
>> After further looking into the code I think that if we correct the vector range below in DebugDebug handler then we do not need the change I provided in this patch.
>>
>> Here is the snapshot for 32 bit (head_booke.h, same will be true for 64 bit):
>>
>> #define DEBUG_DEBUG_EXCEPTION                                                 \
>>        START_EXCEPTION(DebugDebug);                                          \
>>        DEBUG_EXCEPTION_PROLOG;                                               \
>>                                                                              \
>>        /*                                                                    \
>>         * If there is a single step or branch-taken exception in an          \
>>         * exception entry sequence, it was probably meant to apply to        \
>>         * the code where the exception occurred (since exception entry       \
>>         * doesn't turn off DE automatically).  We simulate the effect        \
>>         * of turning off DE on entry to an exception handler by turning      \
>>         * off DE in the DSRR1 value and clearing the debug status.           \
>>         */                                                                   \
>>        mfspr   r10,SPRN_DBSR;          /* check single-step/branch taken */  \
>>        andis.  r10,r10,(DBSR_IC|DBSR_BT)@h;                                  \
>>        beq+    2f;                                                           \
>>                                                                              \
>>        lis     r10,KERNELBASE@h;       /* check if exception in vectors */   \
>>        ori     r10,r10,KERNELBASE@l;                                         \
>>        cmplw   r12,r10;                                                      \
>>        blt+    2f;                     /* addr below exception vectors */    \
>>                                                                              \
>>        lis     r10,DebugDebug@h;                                        \
>>        ori     r10,r10,DebugDebug@l;                                            \
>>
>> ^^^^
>>       Here we assume all exception vector ends at DebugDebug, which is not correct.
>>       We probably should get proper end by using some start_vector and end_vector lebels
>>       or at least use end at Ehvpriv (which is last defined in head_fsl_booke.S for PowerPC. Is that correct?
>>
>>
>>        cmplw   r12,r10;                                                      \
>>        bgt+    2f;                     /* addr above exception vectors */    \
>>
>> Thanks
>> -Bharat
>
> I talked to Stuart and this general approach is good.  Just make sure to update both head_44x.S and head_fsl_booke.S.  Plus do this for both DEBUG_CRIT_EXCEPTION & DEBUG_DEBUG_EXCEPTION

Also, it looks like 64-bit already handles this properly with symbols
identifying the
start/end of the vectors (exceptions-64e.S).

Stuart
