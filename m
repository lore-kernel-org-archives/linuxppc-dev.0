Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C4C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 17:20:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EFC222C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cAWqpD7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EFC222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zTtm0ZQ4zDqP7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 04:20:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="cAWqpD7p"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zTrx5k0LzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 04:18:41 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CH9Ntn177072;
 Tue, 12 Feb 2019 17:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VmxsxuHb/nNuCt+dhukfv0Psv77KAOzs+jgh6bmnEkg=;
 b=cAWqpD7pHuas7OAJKc8a16t6RRPPDvFeCUPvPLZSU1DV0m2niD9UyXU3JG8AYTXb3UxD
 cosODj0IWQ1vAiERykYUlPqGoibt95GRbbgdi4RD4ABybKDbmwmFElonnj8b4ddSz/QK
 6nleplkWrOjhJNgKzwYLwOHDzLMxbXqaBJoPzKcoD/svMYyNKKM/JoQzurdj0tdkZKl8
 HDDbK5VE+Z/Zj+rEul6f03Zbw6ns6ncUl17Yj3kLDMrDh4Fh7x3jWua+z1d3wCExktWc
 EJfg2BAMbjN87Ls8vB3umLoTeN1KX8AHFvGt7O1pcQtaYUJIMPmAjNOUFJUjqd0m/RDL ww== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qhre5da28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Feb 2019 17:18:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1CHIOKL026587
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Feb 2019 17:18:24 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1CHIKOJ029838;
 Tue, 12 Feb 2019 17:18:20 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 Feb 2019 09:18:20 -0800
Date: Tue, 12 Feb 2019 12:18:40 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm
 to account pinned pages
Message-ID: <20190212171839.env4rnjwdjyips6z@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-3-daniel.m.jordan@oracle.com>
 <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
 <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120122
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, linux-mm@kvack.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org,
 atull@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, jgg@ziepe.ca,
 alex.williamson@redhat.com, mdf@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 12, 2019 at 04:50:11PM +0000, Christopher Lameter wrote:
> On Tue, 12 Feb 2019, Alexey Kardashevskiy wrote:
> 
> > Now it is 3 independent accesses (actually 4 but the last one is
> > diagnostic) with no locking around them. Why do not we need a lock
> > anymore precisely? Thanks,
> 
> Updating a regular counter is racy and requires a lock. It was converted
> to be an atomic which can be incremented without a race.

Yes, though Alexey may have meant that the multiple reads of the atomic in
decrement_pinned_vm are racy.  It only matters when there's a bug that would
make the counter go negative, but it's there.

And FWIW the debug print in try_increment_pinned_vm is also racy.

This fixes all that.  It doesn't try to correct the negative pinned_vm as the
old code did because it's already a bug and adjusting the value by the negative
amount seems to do nothing but make debugging harder.

If it's ok, I'll respin the whole series this way (another point for common
helper)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index f47e020dc5e4..b79257304de6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -53,25 +53,24 @@ static long try_increment_pinned_vm(struct mm_struct *mm, long npages)
 		atomic64_sub(npages, &mm->pinned_vm);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%lu%s\n", current->pid,
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
+	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %lld/%lu%s\n", current->pid,
+			npages << PAGE_SHIFT, pinned << PAGE_SHIFT,
+			lock_limit, ret ? " - exceeded" : "");
 
 	return ret;
 }
 
 static void decrement_pinned_vm(struct mm_struct *mm, long npages)
 {
+	s64 pinned;
+
 	if (!mm || !npages)
 		return;
 
-	if (WARN_ON_ONCE(npages > atomic64_read(&mm->pinned_vm)))
-		npages = atomic64_read(&mm->pinned_vm);
-	atomic64_sub(npages, &mm->pinned_vm);
-	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%lu\n", current->pid,
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
+	pinned = atomic64_sub_return(npages, &mm->pinned_vm);
+	WARN_ON_ONCE(pinned < 0);
+	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %lld/%lu\n", current->pid,
+			npages << PAGE_SHIFT, pinned << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 }
 

