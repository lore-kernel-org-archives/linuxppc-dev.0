Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE7C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:17:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72D02184E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sImR4AoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72D02184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1sL6qLszDqdL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 10:17:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="sImR4AoR"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z1qb4KFZzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 10:15:55 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BN8vX3097642;
 Mon, 11 Feb 2019 23:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kB35uu3MDCX9H9dCjyeKgUX/v73vE2yZBRGVSmwnBFk=;
 b=sImR4AoRO04ITgZA5uD8ntFkY61H4DFWWhC82mHzH9Zl2/tm4ppiBGBzH3eGXDFAONxu
 GPbTUwLmNtXzS9vlCQc2DNeKtf4yohjpVNHOcZAEHr/gMpSJ0PFOUAFFar3FSj7NFbRU
 LDHQLdx8+c1ikyFZIbVOEf5S2XH/iEwlooItddvKSp5I2mRQbelzMicK1FOsyLZnOqFH
 0VBiqzAP8poy/KL9WZYh1KxfpXW4mXA3IYj6m0bUUz00Q+bs2+7OjT5otMhuOn+DeB1S
 Td1dr3nTSQUyt88UnPnHUIppC6+JMHgfdf4/zPd8wIEyo+5mPUuhO9mM4PSXkz8ndTfa GQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2qhredru4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 23:15:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1BNFdk6008719
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 23:15:39 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1BNFbVA021521;
 Mon, 11 Feb 2019 23:15:37 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 Feb 2019 15:15:36 -0800
Date: Mon, 11 Feb 2019 18:15:57 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190211231557.zrcq3tv7qi6lqtvo@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211225447.GN24692@ziepe.ca>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110164
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-mm@kvack.org, alex.williamson@redhat.com, mdf@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, cl@linux.com,
 hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> > Hi,
> > 
> > This series converts users that account pinned pages with locked_vm to
> > account with pinned_vm instead, pinned_vm being the correct counter to
> > use.  It's based on a similar patch I posted recently[0].
> > 
> > The patches are based on rdma/for-next to build on Davidlohr Bueso's
> > recent conversion of pinned_vm to an atomic64_t[1].  Seems to make some
> > sense for these to be routed the same way, despite lack of rdma content?
> 
> Oy.. I'd be willing to accumulate a branch with acks to send to Linus
> *separately* from RDMA to Linus, but this is very abnormal.
> 
> Better to wait a few weeks for -rc1 and send patches through the
> subsystem trees.

Ok, I can do that.  It did seem strange, so I made it a question...
