Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410zs82LydzF12M
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 16:53:16 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a12-v6so2686850pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 23:53:16 -0700 (PDT)
Date: Wed, 6 Jun 2018 14:53:10 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Cyril Bur <cyrilbur@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 0/5] powerpc/64: memcmp() optimization
Message-ID: <20180606065310.GC7342@simonLocalRHEL7.x64>
References: <1527672063-6953-1-git-send-email-wei.guo.simon@gmail.com>
 <877eneasg9.fsf@concordia.ellerman.id.au>
 <20180606062153.GA7342@simonLocalRHEL7.x64>
 <1528266847.dixm3thyfj.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528266847.dixm3thyfj.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,
On Wed, Jun 06, 2018 at 12:06:09PM +0530, Naveen N. Rao wrote:
> Simon Guo wrote:
> >Hi Michael,
> >On Tue, Jun 05, 2018 at 12:16:22PM +1000, Michael Ellerman wrote:
> >>Hi Simon,
> >>
> >>wei.guo.simon@gmail.com writes:
> >>> From: Simon Guo <wei.guo.simon@gmail.com>
> >>>
> >>> There is some room to optimize memcmp() in powerpc 64 bits version for
> >>> following 2 cases:
> >>> (1) Even src/dst addresses are not aligned with 8 bytes at the beginning,
> >>> memcmp() can align them and go with .Llong comparision mode without
> >>> fallback to .Lshort comparision mode do compare buffer byte by byte.
> >>> (2) VMX instructions can be used to speed up for large size comparision,
> >>> currently the threshold is set for 4K bytes. Notes the VMX instructions
> >>> will lead to VMX regs save/load penalty. This patch set includes a
> >>> patch to add a 32 bytes pre-checking to minimize the penalty.
> >>>
> >>> It did the similar with glibc commit dec4a7105e (powerpc:
> >>Improve memcmp > performance for POWER8). Thanks Cyril Bur's
> >>information.
> >>> This patch set also updates memcmp selftest case to make it compiled and
> >>> incorporate large size comparison case.
> >>
> >>I'm seeing a few crashes with this applied, I haven't had time to look
> >>into what is happening yet, sorry.
> >>
> >
> >The bug is due to memcmp() invokes a C function enter_vmx_ops()
> >who will load some PIC value based on r2.
> >
> >memcmp() doesn't use r2 and if the memcmp() is invoked from kernel
> >itself, everything is fine. But if memcmp() is invoked from
> >modules[test_user_copy], r2 will be required to be setup
> >correctly. Otherwise the enter_vmx_ops() will refer to an
> >incorrect/unexisting data location based on wrong r2 value.
> >
> >Following patch will fix this issue:
> >------------
> >diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
> >index 5eba49744a5a..24d093fa89bb 100644
> >--- a/arch/powerpc/lib/memcmp_64.S
> >+++ b/arch/powerpc/lib/memcmp_64.S
> >@@ -102,7 +102,7 @@
> >  * 2) src/dst has different offset to the 8 bytes boundary. The handlers
> >  * are named like .Ldiffoffset_xxxx
> >  */
> >-_GLOBAL(memcmp)
> >+_GLOBAL_TOC(memcmp)
> >        cmpdi   cr1,r5,0
> >
> >        /* Use the short loop if the src/dst addresses are not
> >----------
> >
> >It means the memcmp() fun entry will have additional 2 instructions. Is there
> >any way to save these 2 instructions when the memcmp() is actually invoked
> >from kernel itself?
> 
> That will be the case. We will end up entering the function via the
> local entry point skipping the first two instructions. The Global
> entry point is only used for cross-module calls.
> 

Yes. Thanks :)

- Simon
