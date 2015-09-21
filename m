Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E89421A0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:50:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 21:50:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 336652CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:50:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LBoSjq38469868
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:50:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LBoEH4016067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:50:14 +1000
Date: Mon, 21 Sep 2015 21:49:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Avoid to handle EEH on a passed Child PE
Message-ID: <20150921114945.GA17285@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1442827788-10385-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442827788-10385-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 05:29:48PM +0800, Wei Yang wrote:
>Current EEH infrastructure would avoid to handle EEH when a PE is passed to
>guest, while if this PE is a Child PE of the one hit EEH, host would handle
>this. By doing so, this would leads to guest hang. The correct way is
>avoid to handle it on host and let guest to recover.
>
>This patch avoids to handle EEH on a passed Child PE.
>

Ok. It's fixing the problem the guest, which owns a VF, when its PF hitting
EEH error, right? If so, I'm not sure if you really tested this code. Does
it work for you?

When the parent PE (PF) is stopped for EEH recovery, it sounds impossible
that the child PE can't be affected and just escape from the error. The
question is how the guest can continue to work after the EEH recovery on
parent PE?

>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/eeh_pe.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index 5cde950..c6d0e9f 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -172,6 +172,7 @@ static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
>  * callback returns something other than NULL, or no more PEs
>  * to be traversed.
>  */
>+static void *__eeh_pe_get(void *data, void *flag);
> void *eeh_pe_traverse(struct eeh_pe *root,
> 		      eeh_traverse_func fn, void *flag)
> {
>@@ -179,6 +180,8 @@ void *eeh_pe_traverse(struct eeh_pe *root,
> 	void *ret;
>
> 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
>+		if (eeh_pe_passed(pe) && (fn != __eeh_pe_get))
>+			continue;

The code change here seems ugly.

The "flag" can be extended to carry the information to skip pass-through
PEs or not. So the function calling eeh_pe_traverse() decides to skip
pass-through PEs or not.

> 		ret = fn(pe, flag);
> 		if (ret) return ret;
> 	}
>@@ -210,6 +213,8 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,

>
> 	/* Traverse root PE */
> 	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
>+		if (eeh_pe_passed(pe))
>+			continue;
> 		eeh_pe_for_each_dev(pe, edev, tmp) {
> 			ret = fn(edev, flag);
> 			if (ret)
>-- 
>2.5.0
>
