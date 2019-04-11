Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2523C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:18:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389FB2077C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389FB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g1nJ05ByzDqYn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 23:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=paulmck@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g1jp2sHfzDqTl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 23:15:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3BDFcsi058214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 09:15:39 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rt2uxuaby-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 09:12:55 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 11 Apr 2019 14:12:25 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Apr 2019 14:12:22 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3BDCLBL30605472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Apr 2019 13:12:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D002AB205F;
 Thu, 11 Apr 2019 13:12:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2764B2064;
 Thu, 11 Apr 2019 13:12:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Apr 2019 13:12:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
 id B0FBE16C5E7B; Thu, 11 Apr 2019 06:12:22 -0700 (PDT)
Date: Thu, 11 Apr 2019 06:12:22 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
 <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
 <87k1g0vj7f.fsf@concordia.ellerman.id.au>
 <921408ed6a19d9c6fed18182f03a6dac5ea42aae.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921408ed6a19d9c6fed18182f03a6dac5ea42aae.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041113-2213-0000-0000-00000374FE0F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010908; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187541; UDB=6.00622051; IPR=6.00968304; 
 MB=3.00026393; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 13:12:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041113-2214-0000-0000-00005DFC0248
Message-Id: <20190411131222.GW14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-11_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110091
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
Reply-To: paulmck@linux.ibm.com
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Josh Boyer <jwboyer@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 11, 2019 at 05:27:31AM -0700, Joe Perches wrote:
> On Thu, 2019-04-11 at 22:07 +1000, Michael Ellerman wrote:
> > Joe Perches <joe@perches.com> writes:
> > > On Thu, 2019-04-11 at 06:27 +0200, Lukas Bulwahn wrote:
> > > > Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
> > > > to @linux.ibm.com in commit 1dfddcdb95c4
> > > > ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
> > > > some still remained.
> > > > 
> > > > We update the remaining email addresses in MAINTAINERS, hopefully finally
> > > > catching all cases for good.
> > > 
> > > Perhaps update all the similar addresses in other files too
> > > 
> > > $ git grep --name-only 'linux\.vnet\.ibm\.com' | wc -l
> > > 315
> > 
> > A good number of them are no longer valid. So I'm not sure it's worth
> > updating them en masse to addresses that won't ever work.
> > 
> > We have git now, we don't need email addresses in files, they're just
> > prone to bitrot like this.
> > 
> > Should we just change them all like so?
> > 
> >   -arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> >   +arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer (IBM)
> > 
> > To indicate the author was at IBM when they wrote it?
> 
> If that's desired, perhaps:
> 
> $ git grep -P --name-only '<?[\w\.]+(?:@| at )linux\.vnet\.ibm\.com>?' | \
>   grep -vP '\.mailmap|MAINTAINERS' | \
>   xargs perl -p -i -e 's/<?[\w\.]+(?:@|\ at\ )linux\.vnet\.ibm\.com>?/(IBM)/g'
> 
> > Or should we try and update them with current addresses? Though then the
> > authors might start getting mails they don't want.
> 
> That'd be my preference.
> 
> If authors get emails they don't want, then those contact
> emails should be removed.

I have updated most of mine, with one more installment of patches to go
into the next merge window and another into the merge window after that.
More churn than I would have expected, though.  If my email address were
to change again, I would instead go with the "(IBM)" approach and let
the git log and MAINTAINERS file keep the contact information.  Not that
we get to update the git log, of course.  ;-)

I might not have bothered except for combining with the SPDX-tag
commits.

							Thanx, Paul

