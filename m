Return-Path: <SRS0=KnCP=Z2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF734C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 20:30:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945D12073C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 20:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D12073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Sr7f1nRBzDqVx
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 07:30:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=linuxram@us.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Sr5N6sQpzDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2019 07:28:08 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB4KRRAx022908
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2019 15:28:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wnqm3m7ch-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Dec 2019 15:28:05 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 4 Dec 2019 20:28:03 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Dec 2019 20:27:59 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xB4KRHX745941142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2019 20:27:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B94011C04C;
 Wed,  4 Dec 2019 20:27:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7707911C04A;
 Wed,  4 Dec 2019 20:27:54 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.193.7])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Dec 2019 20:27:54 +0000 (GMT)
Date: Wed, 4 Dec 2019 12:27:51 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page
 with the hypervisor.
References: <1575269124-17885-1-git-send-email-linuxram@us.ibm.com>
 <1575269124-17885-2-git-send-email-linuxram@us.ibm.com>
 <1f337af9f52ac4c3128e61c971cf0e32068a71ab.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f337af9f52ac4c3128e61c971cf0e32068a71ab.camel@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19120420-0012-0000-0000-000003713336
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120420-0013-0000-0000-000021ACF577
Message-Id: <20191204202751.GD5063@oc0525413822.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 suspectscore=2 bulkscore=0 mlxlogscore=959 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040167
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
Reply-To: Ram Pai <linuxram@us.ibm.com>
Cc: andmike@us.ibm.com, mst@redhat.com, aik@ozlabs.ru,
 mdroth@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, ram.n.pai@gmail.com,
 cai@lca.pw, tglx@linutronix.de, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, bauerman@linux.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 04, 2019 at 03:26:50PM -0300, Leonardo Bras wrote:
> On Sun, 2019-12-01 at 22:45 -0800, Ram Pai wrote:
> > @@ -206,8 +224,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >          * from iommu_alloc{,_sg}()
> >          */
> >         if (!tcep) {
> > -               tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
> > -               /* If allocation fails, fall back to the loop implementation */
> > +               tcep = alloc_tce_page();
> >                 if (!tcep) {
> >                         local_irq_restore(flags);
> >                         return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
> 
> The comment about failing allocation was removed, but I see no chage of
> behaviour here. 
> 
> Can you please explain what/where it changes? 

You observed it right. The comment should stay put.  Will have it fixed
in my next version.

Thanks,
RP

