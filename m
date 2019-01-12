Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F3C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 10:52:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45C3213A2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="36x6B5IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cGm2141MzDr8m
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 21:52:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="36x6B5IS"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cGkV18mGzDr4L
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 21:51:29 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0CApJe8191607;
 Sat, 12 Jan 2019 10:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qlaeJSdj30pZ2PUMdG+swc1rkgDhUPwUkpNqi2nod2M=;
 b=36x6B5IStaHY50y7n3lgL/T43OaAGVDEq/dGChJ5AE0ns2IXDkDSB0EDlP6NPjV52OD6
 FbhUqNP8yTV5rNuyS07MMcYhvGJ2+MAXzUV+BrloawYeKq1pvR8sY8aE6myTmQ0GfZ4f
 3D9bLu/VNsujl0znczaNiiALp+v9egqnOHWVtISshGWZ/Hrw0HJJRSU4FZLob8QARVJW
 zZ3r4pvmPofmXyMJzGqTX7Qyju7Pn0J9WjIyci5lyK1tEFj36aqw1HY1WO53yqg5SE8y
 O0VERUJQlq/5I8H4djBU14d5D0bQBGFdnkffUqeWScxnmBVDPC9qdel8LRfCgHBa31IL Zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2120.oracle.com with ESMTP id 2pybjrrche-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Jan 2019 10:51:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0CApICE019516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Jan 2019 10:51:18 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0CApGRj011289;
 Sat, 12 Jan 2019 10:51:16 GMT
Received: from kadam (/41.202.241.51) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 12 Jan 2019 02:51:15 -0800
Date: Sat, 12 Jan 2019 13:51:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv/npu: Allocate enough memory in
 pnv_try_setup_npu_table_group()
Message-ID: <20190112105105.GP1718@kadam>
References: <20190109102328.GB5476@kadam> <20190112003035.GA10427@350D>
 <20190112054426.GF1743@kadam>
 <20190112073441.GJ14180@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112073441.GJ14180@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120095
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 01:34:42AM -0600, Segher Boessenkool wrote:
> On Sat, Jan 12, 2019 at 08:44:26AM +0300, Dan Carpenter wrote:
> > On Sat, Jan 12, 2019 at 11:30:35AM +1100, Balbir Singh wrote:
> > > On Wed, Jan 09, 2019 at 01:23:29PM +0300, Dan Carpenter wrote:
> > > > There is a typo so we accidentally allocate enough memory for a pointer
> > > > when we wanted to allocate enough for a struct.
> > > > 
> > > > Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >  arch/powerpc/platforms/powernv/npu-dma.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> > > > index d7f742ed48ba..3f58c7dbd581 100644
> > > > --- a/arch/powerpc/platforms/powernv/npu-dma.c
> > > > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > > > @@ -564,7 +564,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
> > > >  		}
> > > >  	} else {
> > > >  		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> > > > -		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
> > > > +		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
> > > 
> > > To avoid these in the future, I wonder if instead of sizeof(pe->npucomp), we insist on
> > > sizeof structure
> > > 
> > > pe->npucomp = kzalloc(sizeof(struct npucomp), GFP_KERNEL);
> > > 
> > 
> > The latest kernel fashion is sizeof(*ptr).  It can go wrong either way.
> > I don't have strong feelings about it.  These sorts of bugs don't last
> > long because they're caught in testing or with static analysis.
> 
> And it is easy to see someone forgot the * in "sizeof *ptr", and with
> experience it will just automatically look wrong if it is forgotten; but
> it isn't obvious at all if the wrong struct is used, which cannot happen
> with the *ptr form, but happens frequently with the "sizeof(struct x)"
> form.

It doesn't happen very frequently.  I look for this with Smatch.  The
results I see are when the first few members of a struct are a header
and the actual size can vary.

	hdr = alloc(sizeof(struct larger_struct));

regards,
dan carpenter

