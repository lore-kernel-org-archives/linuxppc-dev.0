Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4053C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:05:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC65208A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC65208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x5ky1hRRzF3GG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 16:04:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x5gd4FhczF3fG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 16:02:05 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAG4x2VZ013502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 00:02:03 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nspnw9ftd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 00:02:02 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 16 Nov 2018 05:02:02 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 16 Nov 2018 05:01:58 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAG51v7V20185144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Nov 2018 05:01:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5755978063;
 Fri, 16 Nov 2018 05:01:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E44037805C;
 Fri, 16 Nov 2018 05:01:53 +0000 (GMT)
Received: from [9.79.179.43] (unknown [9.79.179.43])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 16 Nov 2018 05:01:53 +0000 (GMT)
Subject: Re: [mainline][ppc][bnx2x] watchdog: CPU 80 self-detected hard
 LOCKUP @ opal_interrupt+0x28/0x70 when module load/unload
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 16 Nov 2018 10:31:51 +0530
In-Reply-To: <87lg5ttyvv.fsf@concordia.ellerman.id.au>
References: <1537779408.26347.9.camel@abdul.in.ibm.com>
 <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
 <1537784366.26347.15.camel@abdul.in.ibm.com>
 <1542280243.15177.2.camel@abdul> <1542291418.15177.3.camel@abdul>
 <87lg5ttyvv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111605-8235-0000-0000-00000E28ACE2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010058; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118115; UDB=6.00579996; IPR=6.00898223; 
 MB=3.00024187; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 05:02:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111605-8236-0000-0000-0000435FD737
Message-Id: <1542344511.15177.12.camel@abdul>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160043
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, sim <sim@linux.vnet.ibm.com>,
 Oliver <oohall@gmail.com>, manvanth <manvanth@linux.vnet.ibm.com>,
 maurosr <maurosr@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-11-16 at 15:44 +1100, Michael Ellerman wrote:
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > On Thu, 2018-11-15 at 16:40 +0530, Abdul Haleem wrote:
> >> On Mon, 2018-09-24 at 15:49 +0530, Abdul Haleem wrote:
> >> > On Mon, 2018-09-24 at 19:35 +1000, Oliver wrote:
> >> > > On Mon, Sep 24, 2018 at 6:56 PM, Abdul Haleem
> >> > > <abdhalee@linux.vnet.ibm.com> wrote:
> >> > > > Greeting's
> >> > > >
> >> > > > bnx2x module load/unload test results in continuous hard LOCKUP trace on
> >> > > > my powerpc bare-metal running mainline 4.19.0-rc4 kernel
>                                                 ^^^^^^^^^^
> >> 
> >> Warnings also show up on 4.20.0-rc2-next-20181114
> >
> > We have a patch fix available https://patchwork.ozlabs.org/patch/998054/
> >
> > It fixed the problem.
> 
> But the bug it fixes wasn't present in 4.19.0-rc4, which is the version
> you originally reported against. Or is that version string not accurate?

Yes, version string wrong. the bug was first seen on linux-next
4.19.0-rc3-next-20180913 and on mainline version 4.19.0-rc8

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



