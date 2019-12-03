Return-Path: <SRS0=x21H=ZZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6937C432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 04:59:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7154A2054F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 04:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7154A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47RqXH5qRdzDq75
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 15:59:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47RpNh621fzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2019 15:07:48 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB346tou012571
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2019 23:07:45 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wknuaqen2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Dec 2019 23:07:44 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 3 Dec 2019 04:07:42 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 3 Dec 2019 04:07:38 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xB346v4S46596372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Dec 2019 04:06:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E66F8A4051;
 Tue,  3 Dec 2019 04:07:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16F53A404D;
 Tue,  3 Dec 2019 04:07:34 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.173.229])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  3 Dec 2019 04:07:33 +0000 (GMT)
Date: Mon, 2 Dec 2019 20:07:31 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <1575269124-17885-1-git-send-email-linuxram@us.ibm.com>
 <1575269124-17885-2-git-send-email-linuxram@us.ibm.com>
 <1575269124-17885-3-git-send-email-linuxram@us.ibm.com>
 <58b08d09-aaf8-5659-c4e8-c502c508f35c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b08d09-aaf8-5659-c4e8-c502c508f35c@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19120304-0012-0000-0000-000003701489
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120304-0013-0000-0000-000021ABCEC5
Message-Id: <20191203040731.GC12354@oc0525413822.ibm.com>
Subject: RE: [PATCH v4 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for
 Secure VMs aswell.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=18 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030035
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
Cc: andmike@us.ibm.com, mst@redhat.com, mdroth@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, ram.n.pai@gmail.com, cai@lca.pw,
 tglx@linutronix.de, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 hch@lst.de, bauerman@linux.ibm.com, david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 03, 2019 at 11:58:18AM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 02/12/2019 17:45, Ram Pai wrote:
> > Commit edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on
> > 	       secure guests")
> > disabled dma_iommu_ops path, for secure VMs. The rationale for disabling
> > the dma_iommu_ops path, was to use the dma_direct path, since it had
> > inbuilt support for bounce-buffering through SWIOTLB.
> > 
> > However dma_iommu_ops is functionally much richer. Depending on the
> > capabilities of the platform, it can handle direct DMA; with or without
> > bounce buffering, and it can handle indirect DMA. Hence its better to
> > leverage the richer functionality supported by dma_iommu_ops.
> 
> What exactly do we leverage after applying this patch? afaict things are
> going to work in exact same old way with this applied, no? Thanks,

Yes. You got it right. Another way of saying this is, it reverts the changes.

RP

