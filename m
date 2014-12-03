Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B0F41A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 01:20:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 14:20:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E1B11B08051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 14:21:09 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3EKp6918939986
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 14:20:51 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3EKovi007448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 07:20:50 -0700
Date: Wed, 3 Dec 2014 15:20:46 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: drop useless warning in eeh_init()
Message-ID: <20141203152046.5c109d1f@bahia.local>
In-Reply-To: <20141125222846.GA7662@shangw>
References: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141125222846.GA7662@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Nov 2014 09:28:47 +1100
Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Tue, Nov 25, 2014 at 05:10:06PM +0100, Greg Kurz wrote:
> >This is what we get in dmesg when booting a pseries guest and
> >the hypervisor doesn't provide EEH support.
> >
> >[    0.166655] EEH functionality not supported
> >[    0.166778] eeh_init: Failed to call platform init function (-22)
> >
> >Since both powernv_eeh_init() and pseries_eeh_init() already complain when
> >hitting an error, it is not needed to print more (especially such an
> >uninformative message).
> >
> >Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> 
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> Thanks,
> Gavin
> 

Ping ?

> >---
> > arch/powerpc/kernel/eeh.c |    5 +----
> > 1 file changed, 1 insertion(+), 4 deletions(-)
> >
> >diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> >index 2248a19..7d62018 100644
> >--- a/arch/powerpc/kernel/eeh.c
> >+++ b/arch/powerpc/kernel/eeh.c
> >@@ -920,11 +920,8 @@ int eeh_init(void)
> > 		pr_warn("%s: Platform EEH operation not found\n",
> > 			__func__);
> > 		return -EEXIST;
> >-	} else if ((ret = eeh_ops->init())) {
> >-		pr_warn("%s: Failed to call platform init function (%d)\n",
> >-			__func__, ret);
> >+	} else if ((ret = eeh_ops->init()))
> > 		return ret;
> >-	}
> > 
> > 	/* Initialize EEH event */
> > 	ret = eeh_event_init();
> >
> >_______________________________________________
> >Linuxppc-dev mailing list
> >Linuxppc-dev@lists.ozlabs.org
> >https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
