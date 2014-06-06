Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26AF91A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 15:35:40 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 15:35:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 91E1F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 15:35:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s565ZJQW64422006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 15:35:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s565ZYcJ002134
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 15:35:34 +1000
Message-ID: <539152B3.5070702@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 11:03:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: include asm/smp.h to handle UP config
References: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2014 08:51 PM, Shreyas B. Prabhu wrote:
> Build throws following errors when CONFIG_SMP=n
> arch/powerpc/platforms/powernv/setup.c: In function ‘pnv_kexec_wait_secondaries_down’:
> arch/powerpc/platforms/powernv/setup.c:179:4: error: implicit declaration of function ‘get_hard_smp_processor_id’
>     rc = opal_query_cpu_status(get_hard_smp_processor_id(i),
> 
> The usage of get_hard_smp_processor_id() needs the declaration from
> <asm/smp.h>. The file setup.c includes <linux/sched.h>, which in-turn
> includes <linux/smp.h>. However, <linux/smp.h> includes <asm/smp.h>
> only on SMP configs and hence UP builds fail.
> 
> Fix this by directly including <asm/smp.h> in setup.c unconditionally.

Can you please clean up the description in the commit message ? and also
the first line in the commit message should mention that the patch is
trying to fix a UP specific build failure.
