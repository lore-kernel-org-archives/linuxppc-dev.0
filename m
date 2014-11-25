Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 835981A0200
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:28:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Nov 2014 08:28:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CCE6E2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:28:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAPMSlVZ22544614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:28:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAPMSlEe005374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:28:47 +1100
Date: Wed, 26 Nov 2014 09:28:47 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: drop useless warning in eeh_init()
Message-ID: <20141125222846.GA7662@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2014 at 05:10:06PM +0100, Greg Kurz wrote:
>This is what we get in dmesg when booting a pseries guest and
>the hypervisor doesn't provide EEH support.
>
>[    0.166655] EEH functionality not supported
>[    0.166778] eeh_init: Failed to call platform init function (-22)
>
>Since both powernv_eeh_init() and pseries_eeh_init() already complain when
>hitting an error, it is not needed to print more (especially such an
>uninformative message).
>
>Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh.c |    5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 2248a19..7d62018 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -920,11 +920,8 @@ int eeh_init(void)
> 		pr_warn("%s: Platform EEH operation not found\n",
> 			__func__);
> 		return -EEXIST;
>-	} else if ((ret = eeh_ops->init())) {
>-		pr_warn("%s: Failed to call platform init function (%d)\n",
>-			__func__, ret);
>+	} else if ((ret = eeh_ops->init()))
> 		return ret;
>-	}
> 
> 	/* Initialize EEH event */
> 	ret = eeh_event_init();
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
