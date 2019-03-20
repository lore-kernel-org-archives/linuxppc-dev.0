Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61585C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 00:30:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C19B2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 00:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C19B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P9mr00ffzDqHR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P9lC2XGgzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 11:28:54 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K0ODjm014888
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 20:28:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rb8qqn2kh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 20:28:50 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 20 Mar 2019 00:28:42 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 00:28:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K0SjQZ58916900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2019 00:28:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 263F04C04A;
 Wed, 20 Mar 2019 00:28:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9BC34C040;
 Wed, 20 Mar 2019 00:28:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2019 00:28:44 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3AE79A0129;
 Wed, 20 Mar 2019 11:28:43 +1100 (AEDT)
Subject: Re: [PATCH 6/7] ocxl: afu_irq only deals with IRQ IDs, not offsets
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Mar 2019 11:28:43 +1100
In-Reply-To: <20190315145639.4ae9e257@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20190313041524.14644-1-alastair@au1.ibm.com>
 <20190313041524.14644-7-alastair@au1.ibm.com>
 <20190315145639.4ae9e257@bahia.lab.toulouse-stg.fr.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032000-0020-0000-0000-000003255778
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032000-0021-0000-0000-00002177734C
Message-Id: <20fc6ceee1d45e3d4e71e3ac6887ef2860a1c341.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-19_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200001
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-03-15 at 14:56 +0100, Greg Kurz wrote:
> On Wed, 13 Mar 2019 15:15:21 +1100
> "Alastair D'Silva" <alastair@au1.ibm.com> wrote:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > The use of offsets is required only in the frontend, so alter
> > the IRQ API to only work with IRQ IDs in the backend.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/misc/ocxl/afu_irq.c       | 31 +++++++++++++------------
> > ------
> >  drivers/misc/ocxl/context.c       |  7 +++++--
> >  drivers/misc/ocxl/file.c          | 13 ++++++++-----
> >  drivers/misc/ocxl/ocxl_internal.h | 10 ++++++----
> >  drivers/misc/ocxl/trace.h         | 12 ++++--------
> >  5 files changed, 36 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/misc/ocxl/afu_irq.c
> > b/drivers/misc/ocxl/afu_irq.c
> > index 11ab996657a2..1885c472df58 100644
> > --- a/drivers/misc/ocxl/afu_irq.c
> > +++ b/drivers/misc/ocxl/afu_irq.c
> > @@ -14,14 +14,14 @@ struct afu_irq {
> >  	struct eventfd_ctx *ev_ctx;
> >  };
> >  
> > -static int irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
> > +int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
> >  {
> >  	return (offset - ctx->afu->irq_base_offset) >> PAGE_SHIFT;
> >  }
> >  
> > -static u64 irq_id_to_offset(struct ocxl_context *ctx, int id)
> > +u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id)
> >  {
> > -	return ctx->afu->irq_base_offset + (id << PAGE_SHIFT);
> > +	return ctx->afu->irq_base_offset + (irq_id << PAGE_SHIFT);
> >  }
> >  
> >  static irqreturn_t afu_irq_handler(int virq, void *data)
> > @@ -69,7 +69,7 @@ static void release_afu_irq(struct afu_irq *irq)
> >  	kfree(irq->name);
> >  }
> >  
> > -int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset)
> > +int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id)
> >  {
> >  	struct afu_irq *irq;
> >  	int rc;
> > @@ -101,10 +101,7 @@ int ocxl_afu_irq_alloc(struct ocxl_context
> > *ctx, u64 *irq_offset)
> >  	if (rc)
> >  		goto err_alloc;
> >  
> > -	*irq_offset = irq_id_to_offset(ctx, irq->id);
> 
> This should be replaced by:
> 
> 	*irq_id = irq->id;
> 

Whoops, good catch, thanks :)

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

