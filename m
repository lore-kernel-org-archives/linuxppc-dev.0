Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0890C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:25:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8CE2087C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8CE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KXc53K4xzDqMT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:25:09 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KXZF26hTzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 13:23:32 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2E2K7sK049701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 22:23:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r78s5m57v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 22:23:30 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 14 Mar 2019 02:23:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Mar 2019 02:23:25 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2E2NOIm27590884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Mar 2019 02:23:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38DD8AE053;
 Thu, 14 Mar 2019 02:23:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 945E9AE045;
 Thu, 14 Mar 2019 02:23:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2019 02:23:23 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2CFFCA00E2;
 Thu, 14 Mar 2019 13:23:21 +1100 (AEDT)
Subject: Re: [PATCH 5/5] ocxl: Remove some unused exported symbols
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Mar 2019 13:23:21 +1100
In-Reply-To: <20190313101045.6712f156@bahia.lan>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190313040702.14276-1-alastair@au1.ibm.com>
 <20190313040702.14276-6-alastair@au1.ibm.com>
 <20190313101045.6712f156@bahia.lan>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031402-4275-0000-0000-0000031AB629
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031402-4276-0000-0000-000038292683
Message-Id: <1dd6d24f3ee5a2029ee6fbb2890356197e881101.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-14_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140013
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

On Wed, 2019-03-13 at 10:10 +0100, Greg Kurz wrote:
> On Wed, 13 Mar 2019 15:07:01 +1100
> "Alastair D'Silva" <alastair@au1.ibm.com> wrote:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Remove some unused exported symbols.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/misc/ocxl/config.c        |  2 --
> >  drivers/misc/ocxl/ocxl_internal.h | 23 +++++++++++++++++++++++
> >  include/misc/ocxl.h               | 23 -----------------------
> >  3 files changed, 23 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/misc/ocxl/config.c
> > b/drivers/misc/ocxl/config.c
> > index 026ac2ac4f9c..c90c2e4875bf 100644
> > --- a/drivers/misc/ocxl/config.c
> > +++ b/drivers/misc/ocxl/config.c
> > @@ -299,7 +299,6 @@ int ocxl_config_check_afu_index(struct pci_dev
> > *dev,
> >  	}
> >  	return 1;
> >  }
> > -EXPORT_SYMBOL_GPL(ocxl_config_check_afu_index);
> >  
> >  static int read_afu_name(struct pci_dev *dev, struct
> > ocxl_fn_config *fn,
> >  			struct ocxl_afu_config *afu)
> > @@ -535,7 +534,6 @@ int ocxl_config_get_pasid_info(struct pci_dev
> > *dev, int *count)
> >  {
> >  	return pnv_ocxl_get_pasid_count(dev, count);
> >  }
> > -EXPORT_SYMBOL_GPL(ocxl_config_get_pasid_info);
> >  
> >  void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int
> > pasid_base,
> >  			u32 pasid_count_log)
> > diff --git a/drivers/misc/ocxl/ocxl_internal.h
> > b/drivers/misc/ocxl/ocxl_internal.h
> > index 321b29e77f45..06fd98c989c8 100644
> > --- a/drivers/misc/ocxl/ocxl_internal.h
> > +++ b/drivers/misc/ocxl/ocxl_internal.h
> > @@ -107,6 +107,29 @@ void ocxl_pasid_afu_free(struct ocxl_fn *fn,
> > u32 start, u32 size);
> >  int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
> >  void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
> >  
> > +/*
> > + * Get the max PASID value that can be used by the function
> > + */
> > +int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> > +
> > +/*
> > + * Check if an AFU index is valid for the given function.
> > + *
> > + * AFU indexes can be sparse, so a driver should check all indexes
> > up
> > + * to the maximum found in the function description
> > + */
> > +int ocxl_config_check_afu_index(struct pci_dev *dev,
> > +				struct ocxl_fn_config *fn, int
> > afu_idx);
> > +
> > +/**
> 
> Two *s ?
> 

These are Sphinx formatted comments (similar, but not quite the same as
Doxygen).

> Also, this results in an ocxl_internal.h header file where only these
> three functions are documented... which looks a bit weird IMHO. Since
> these are ocxl internals, do we _really_ need to keep the comments ?

I believe we should, it's a courtesy to the next person who has to work
in the area.

There are more documentation comments coming in further series.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

