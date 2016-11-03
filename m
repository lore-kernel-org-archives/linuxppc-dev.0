Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8bKL1C2fzDvPq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 17:53:41 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA36ob8b004392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 02:53:39 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26fyndt30y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 02:53:39 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 16:53:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 41B712CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 17:53:34 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA36rYRA20119790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 17:53:34 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA36rXH1006397
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 17:53:34 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
Date: Thu,  3 Nov 2016 12:23:17 +0530
In-Reply-To: <20161103155531.4e86d906@roar.ozlabs.ibm.com>
Message-Id: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/03 03:55PM, Nicholas Piggin wrote:
> On Wed, 2 Nov 2016 13:49:39 +0300
> Denis Kirjanov <kda@linux-powerpc.org> wrote:
> 
> > Hi guys,
> > 
> > compiling ppc head with bunch of asm errors on power8 box (gcc version 4.8.3 )
> > checked commit log but found nothing special. Looks like it's asm issue?
> > Has anybody seen that?
> > 
> > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > arch/powerpc/kernel/exceptions-64s.S:421: Error: operand out of range
> > (0xffffffffffff8680 is not between 0x0000000000000000 and
> > 0x000000000000ffff)
> 
> Hey, thanks for the report. It's likely due to the exception vectors rewrite,
> and yes it's an assembler issue (what's your binutils version?). Your errors
> look like they're coming from LOAD_HANDLER(). For some reason it seems to be
> interpreting the immediate as signed, or the actual calculation ends up being
> negative, neither of which should happen.
> 
> It might take a bit of trial and error, and the assembler doesn't give a lot
> of good options to debug it, so if I can reproduce it here with your bintuils
> version it will be helpful.

I saw this issue when trying to do a BE build on RHEL 7.1. The below
fixes this for me and it indeed looks like an issue with the assembler.
Interestingly, the same assembler version on RHEL 7.1 LE does not throw
these errors.

[root@rhel71be linux]# gcc --version
gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-8)
<snip>
[root@rhel71be linux]# as --version
GNU assembler version 2.23.52.0.1-26.el7 20130226
<snip>

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 2e4e7d8..9b7b302 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -91,7 +91,7 @@
  */
 #define LOAD_HANDLER(reg, label)					\
 	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
-	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
+	ori	reg,reg,((FIXED_SYMBOL_ABS_ADDR(label)) & 0xffff);
 
 /* Exception register prefixes */
 #define EXC_HV	H
-- 
2.10.1
