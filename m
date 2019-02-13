Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51BCC282C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 00:28:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF7021B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 00:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4uhNkb1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF7021B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zgPP25bLzDqFm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:28:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="4uhNkb1F"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zgMH6B41zDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 11:27:07 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D04ItA127795;
 Wed, 13 Feb 2019 00:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=w0tqhPo+t2SUjHi0LS/CYN1wUpJy7dXBRCRCEWoqsoM=;
 b=4uhNkb1FBNWMTFMQtPUk8damVBnjRIUT7GL5gQsYHz64WDzTPPtvcus+e60ProDyirXA
 BIBzWsGcRc0nHdUKObIy7isnuU5mxDmG2Eqhgwswz9l/zeQmVrqvv1bmjZ8tNlW73vQ3
 tIV/bA4IIkByvi7kHkDTFv1HTComQfdsds3sPIbvf/J7/+e7CJkeuo+0gzdHgxyxhTqs
 gOh37VPD3tZ18pYTYvOcFEO/9Q8Z+mwAyAeGdutNQ7Rt8uWL2gmrFHP2efApacziCexv
 WvNERa0JSl/O7luXzRpjaQdoxFvecYasxSh7RwfvLmZctY10vmFVu2Tyzquis+f2PhaC gQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp2130.oracle.com with ESMTP id 2qhre5f4r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Feb 2019 00:26:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D0QYY2005778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Feb 2019 00:26:34 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D0QUic020233;
 Wed, 13 Feb 2019 00:26:31 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 Feb 2019 16:26:30 -0800
Date: Tue, 12 Feb 2019 19:26:50 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
 <20190212114110.17bc8a14@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212114110.17bc8a14@w520.home>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120162
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
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, atull@kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 peterz@infradead.org, mdf@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 12, 2019 at 11:41:10AM -0700, Alex Williamson wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > On Mon, Feb 11, 2019 at 03:56:20PM -0700, Jason Gunthorpe wrote:
> > > I haven't looked at this super closely, but how does this stuff work?
> > > 
> > > do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...
> > > 
> > > Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?
> > >
> > > Otherwise MEMLOCK is really doubled..  
> > 
> > So this has been a problem for some time, but it's not as easy as adding them
> > together, see [1][2] for a start.
> > 
> > The locked_vm/pinned_vm issue definitely needs fixing, but all this series is
> > trying to do is account to the right counter.

Thanks for taking a look, Alex.

> This still makes me nervous because we have userspace dependencies on
> setting process locked memory.

Could you please expand on this?  Trying to get more context.

> There's a user visible difference if we
> account for them in the same bucket vs separate.  Perhaps we're
> counting in the wrong bucket now, but if we "fix" that and userspace
> adapts, how do we ever go back to accounting both mlocked and pinned
> memory combined against rlimit?  Thanks,

PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
locked_vm accounting separate, but allowed the two to be added safely to be
compared against RLIMIT_MEMLOCK.

Anyway, until some solution is agreed on, are there objections to converting
locked_vm to an atomic, to avoid user-visible changes, instead of switching
locked_vm users to pinned_vm?

Daniel

[1] http://lkml.kernel.org/r/20130524140114.GK23650@twins.programming.kicks-ass.net
