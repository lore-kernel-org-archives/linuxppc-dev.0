Return-Path: <wei.guo.simon@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWyk18WJzDqRZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:37:02 +1000 (AEST)
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rvWyj4pH7z9t17
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2016 19:37:01 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so2992104pad.2
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2016 02:37:01 -0700 (PDT)
Date: Wed, 20 Jul 2016 17:36:56 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: Simon Guo <simonguo@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to
 store live registers
Message-ID: <20160720093656.GA4324@simonLocalRHEL7.x64>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-4-cyrilbur@gmail.com>
 <20160717032543.GB3843@simonLocalRHEL7.x64>
 <20160718112830.71ee878c@camb691>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160718112830.71ee878c@camb691>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 18, 2016 at 11:28:30AM +1000, Cyril Bur wrote:
> On Sun, 17 Jul 2016 11:25:43 +0800
> 
> The aim of this patch is to ensure that pt_regs, fp_state and vr_state always
> hold a threads 'live' registers. So, after a recheckpoint fp_state is where the
> the state should be. tm_reclaim_thread() does a save_all() before doing the
> reclaim.
> 
> This means that the call to restore_math() is a replacement for all deleted
> lines above it.
> 
> I added it here because I'd prefer to be safe but I left that comment in
> because I suspect restore_math() will be called later and we can get away with
> not calling it here.
> 
> > And, should the thread's MSR now set FP bit in tm_recheckpoint(), to 
> > indicate that FP register content is "fresh" in contrast to thread.fp_state?
> > 
> 
> I'm not sure what you mean by 'fresh'. You do highlight that we'll have to be
> sure that the MSR bits are off (so that restore_math() doesn't assume the
> registers are already loaded) which makes me think that tm_reclaim_thread()
> should be doing a giveup_all(), I'll fix that.
> 
> I hope that helps,
> 

Thanks Cyril. The explanation is detail and helpful.

- Simon
