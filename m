Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn2k53DjlzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 04:19:25 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 79so12329477pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 10:19:25 -0700 (PDT)
Date: Tue, 21 Mar 2017 03:19:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] powerpc/64s: idle POWER8 avoid full state loss
 recovery where possible
Message-ID: <20170321031913.3957a302@roar.ozlabs.ibm.com>
In-Reply-To: <20170320163115.GA20610@in.ibm.com>
References: <20170320060152.1016-1-npiggin@gmail.com>
 <20170320060152.1016-8-npiggin@gmail.com>
 <20170320101139.GA20417@in.ibm.com>
 <20170320202605.304b33ad@roar.ozlabs.ibm.com>
 <20170320163115.GA20610@in.ibm.com>
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

On Mon, 20 Mar 2017 22:01:15 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> > What do you want to do about your DD1 fix? I think there are some minor
> > clashes between them. I'm happy to rebase on top of yours if you prefer
> > it to go in first.  
> 
> I have sent an updated version of the DD1 fix today rebasing on
> v4.11-rc3.
> 
> I applied your series on top of that and noticed some minor conflict
> with patches 1,2,3 and 7.
> 
> If you are ok with it, I would like the DD1 Hotplug fixes to go in
> first.

This would be fine with me. Your clashing hunk is pretty trivial to fix
on top of my series though (it actually becomes nicer):

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s
index 3330a4293d1a..6d8e022da183 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -414,6 +414,9 @@ pnv_powersave_wakeup_mce:
 .global pnv_powersave_wakeup
 pnv_powersave_wakeup:
 BEGIN_FTR_SECTION
+BEGIN_FTR_SECTION_NESTED(70)
+       bl      power9_dd1_recover_paca
+END_FTR_SECTION_NESTED(CPU_FTR_POWER9_DD1, CPU_FTR_POWER9_DD1, 70)
        bl      pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
        bl      pnv_restore_hyp_resource_arch207

So we could easily do it the other way around too. The question is, when will
they get merged, and what needs to be backported. I'll let you and mpe decide
that :)

Thanks,
Nick
