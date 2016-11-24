Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPjB41z1XzDw5R
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 02:02:52 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAOExJx1089511
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 10:02:49 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26wy6j7ccg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 10:02:49 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 24 Nov 2016 13:02:46 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7961E3520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 10:02:15 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAOF2iRe21102700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 13:02:44 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAOF2h4D013708
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 13:02:44 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Date: Thu, 24 Nov 2016 13:02:39 -0200
In-Reply-To: <20161124160151.20206af7@canb.auug.org.au>
References: <20161124160151.20206af7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <9443137.1vHEJqnA2s@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Stephen,

Am Donnerstag, 24. November 2016, 16:01:51 BRST schrieb Stephen Rothwell:
> Hi Andrew,
> 
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> powerpc-linux-ld: unrecognized option '--no-dynamic-linker'
> 
> Caused by patch
> 
>   "powerpc: add purgatory for kexec_file_load implementation"
> 

Sorry about that. --no-dynamic-linker was added in binutils 2.26.
The patch below fixes the problem.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index 2dfb53ac9944..cf6e78b9af86 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -6,8 +6,10 @@ purgatory-y := purgatory.o string.o v2wrap.o purgatory-ppc64.o crtsavres.o \
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
-LDFLAGS_purgatory.ro := -pie --no-dynamic-linker -e purgatory_start \
-			--no-undefined -nostartfiles -nostdlib -nodefaultlibs
+LDFLAGS_purgatory.ro := -pie -e purgatory_start --no-undefined -nostartfiles \
+			-nostdlib -nodefaultlibs
+LDFLAGS_purgatory.ro += $(call ld-option, --no-dynamic-linker)
+
 targets += purgatory.ro
 
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE), $(KBUILD_CFLAGS))
