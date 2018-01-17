Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMD6Y07pvzF0gH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 04:07:33 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zMD6X350Vz8tKg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 04:07:32 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zMD6W6NBRz9s7v
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2018 04:07:31 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0HH5bYl140543
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 12:07:30 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fj7yxgmrc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 12:07:29 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 10:07:28 -0700
Date: Wed, 17 Jan 2018 09:07:24 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: export thread-tidr interfaces
References: <1516153832-9282-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <eff03efa-0637-c63a-a7ee-320c490cff9d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eff03efa-0637-c63a-a7ee-320c490cff9d@linux.vnet.ibm.com>
Message-Id: <20180117170724.GA5314@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat [fbarrat@linux.vnet.ibm.com] wrote:
> Hi,
> 
> 
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 2010e4c..f20c1ad 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1560,6 +1560,7 @@ void clear_thread_tidr(struct task_struct *t)
> >   	free_thread_tidr(t->thread.tidr);
> >   	t->thread.tidr = 0;
> >   }
> > +EXPORT_SYMBOL_GPL(clear_thread_tidr);
> 
> Isn't it dangerous to export clear_thread_tidr()? Other modules may also
> have assigned the TIDR by calling set_thread_tidr(), so clearing it could
> potentially break those other modules. My understanding is that once the
> TIDR is assigned, there's no safe way to reclaim it other than the thread
> exiting. Or we would need some kind of reference counter.

Yes the FTW driver avoids calling clear_thread_tidr() for the same reasons.
I don't have a strong case for exporting clear_thread_tidr(). Here is the
updated patch, exporting just the set_thread_tidr().

Thanks,

Sukadev
---
>From 204ee3c918f8dad46c1e40d2d3730b07c10a87a3 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 13:43:18 -0600
Subject: [PATCH 1/2] powerpc: export set_thread_tidr()

Export set_thread_tidr() so it can be used by external modules.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog  [Frederic Barrat] Don't export clear_thread_tidr()

---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2010e4c..20df2cb2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1592,6 +1592,7 @@ int set_thread_tidr(struct task_struct *t)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_thread_tidr);
 
 #endif /* CONFIG_PPC64 */
 
-- 
1.8.3.1
