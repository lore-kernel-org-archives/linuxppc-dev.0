Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B2C04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 15:08:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1B1206C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 15:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bgq/F8b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1B1206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Cy090XqfzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 May 2019 01:08:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="bgq/F8b/"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CxwK4zw6zDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2019 01:05:04 +1000 (AEST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SF4QUp083027;
 Tue, 28 May 2019 15:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=G9vBM5THlG8pywNzVbsKIK8sbELnMUDNM7aCaLdslP0=;
 b=bgq/F8b/2xwUVXMlsJqTT/j8YvUXLiDeS1H4MJ+nX4NOQ5xuZxuO5UeAXzVEoTG1w3bf
 iu6Ce7E+Lhxw9casXB7xzxnF/LglbRQEC8Hux6StMYE/xjblB+T7bJ8nOxdBonl07JjK
 i4LWZr8dbuD44I3nkitg/rpMislB3CGkymXU4mlpDIqIm+8/2CgEmV0kh75+vCfvC2L4
 Z8Adu0/Y0OQ8FReXSRrA1zB1u+Z7W4E2Dt6b4GdDgXE31SyMNMgBPdc0LZpdUzdIuZHh
 ka4eUEOZ3WXQdsjyQL6SgjVs8mBV0FmA9pPrU0yOOD7DKhfxFyHFYXk1s/ronu4hv6Mr 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2spw4tbtqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2019 15:04:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SF3Kh9017458;
 Tue, 28 May 2019 15:04:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ss1fmwp16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2019 15:04:38 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SF4OV0025272;
 Tue, 28 May 2019 15:04:24 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 May 2019 08:04:24 -0700
Date: Tue, 28 May 2019 11:04:24 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: add account_locked_vm utility function
Message-ID: <20190528150424.tjbaiptpjhzg7y75@ca-dmjordan1.us.oracle.com>
References: <de375582-2c35-8e8a-4737-c816052a8e58@ozlabs.ru>
 <20190524175045.26897-1-daniel.m.jordan@oracle.com>
 <20190525145118.bfda2d75a14db05a001e49ad@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525145118.bfda2d75a14db05a001e49ad@linux-foundation.org>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280098
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
Cc: Mark Rutland <mark.rutland@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
 kvm@vger.kernel.org, Alan Tull <atull@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Moritz Fischer <mdf@kernel.org>,
 Steve Sistare <steven.sistare@oracle.com>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 25, 2019 at 02:51:18PM -0700, Andrew Morton wrote:
> On Fri, 24 May 2019 13:50:45 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> 
> > locked_vm accounting is done roughly the same way in five places, so
> > unify them in a helper.  Standardize the debug prints, which vary
> > slightly, but include the helper's caller to disambiguate between
> > callsites.
> > 
> > Error codes stay the same, so user-visible behavior does too.  The one
> > exception is that the -EPERM case in tce_account_locked_vm is removed
> > because Alexey has never seen it triggered.
> > 
> > ...
> >
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1564,6 +1564,25 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> >  int get_user_pages_fast(unsigned long start, int nr_pages,
> >  			unsigned int gup_flags, struct page **pages);
> >  
> > +int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> > +			struct task_struct *task, bool bypass_rlim);
> > +
> > +static inline int account_locked_vm(struct mm_struct *mm, unsigned long pages,
> > +				    bool inc)
> > +{
> > +	int ret;
> > +
> > +	if (pages == 0 || !mm)
> > +		return 0;
> > +
> > +	down_write(&mm->mmap_sem);
> > +	ret = __account_locked_vm(mm, pages, inc, current,
> > +				  capable(CAP_IPC_LOCK));
> > +	up_write(&mm->mmap_sem);
> > +
> > +	return ret;
> > +}
> 
> That's quite a mouthful for an inlined function.  How about uninlining
> the whole thing and fiddling drivers/vfio/vfio_iommu_type1.c to suit. 
> I wonder why it does down_write_killable and whether it really needs
> to...

Sure, I can uninline it.  vfio changelogs don't show a particular reason for
_killable[1].  Maybe Alex has something to add.  Otherwise I'll respin without
it since the simplification seems worth removing _killable.

[1] 0cfef2b7410b ("vfio/type1: Remove locked page accounting workqueue")
