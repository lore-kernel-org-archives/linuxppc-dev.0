Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C60C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 00:54:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0A820892
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 00:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42swPq5wM0zF3JP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 11:54:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=paulmck@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42swMm3JNSzF3Nk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 11:52:19 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAB0mY5V131000
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 19:52:17 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nnvf20j95-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 19:52:17 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 11 Nov 2018 00:52:16 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 11 Nov 2018 00:52:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAB0qCYm64291044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 11 Nov 2018 00:52:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACC4AB2064;
 Sun, 11 Nov 2018 00:52:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79121B2065;
 Sun, 11 Nov 2018 00:52:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 11 Nov 2018 00:52:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
 id E00ED16C35AD; Sat, 10 Nov 2018 16:52:12 -0800 (PST)
Date: Sat, 10 Nov 2018 16:52:12 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.h in 4.20-rc1
References: <dc5e555d-129e-aae8-889d-7b4e82197b3b@c-s.fr>
 <20181109201030.GI4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109201030.GI4170@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111100-0072-0000-0000-000003C6B469
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010023; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01115642; UDB=6.00577118; IPR=6.00895742; 
 MB=3.00024106; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 00:52:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111100-0073-0000-0000-00004A115F14
Message-Id: <20181111005212.GA30884@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-10_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110005
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 09, 2018 at 12:10:30PM -0800, Paul E. McKenney wrote:
> On Fri, Nov 09, 2018 at 06:11:20PM +0100, Christophe LEROY wrote:
> > (Resending due to error in Paul's address)
> > 
> > Paul
> > 
> > I get the following UBSAN reports in 4.20-rc1 on an MPC8321E
> > (powerpc/book3s/32)
> > 
> > I bisected it to 3e31009898699dfc ("rcu: Defer reporting RCU-preempt
> > quiescent states when disabled")
> 
> Fixed by dfdc33585b0a ("rcu: Avoid signed integer overflow in
> rcu_preempt_deferred_qs()") in my -rcu tree and in -next, which I intend
> to push into the next merge window.

And while I am at it...  The C++ Standards Committee just yesterday
voted "Signed integers are twos complement" into the C++20 standard.  ;-)

Yeah, C++20 rather than now, and C++ rather than C, but there you have it!

							Thanx, Paul

> > Thanks
> > Christophe
> > 
> > [    4.919995] ================================================================================
> > [    4.928428] UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.h:623:28
> > [    4.935198] signed integer overflow:
> > [    4.938766] 0 - -2147483648 cannot be represented in type 'int'
> > [    4.944678] CPU: 0 PID: 119 Comm: mkdir Not tainted
> > 4.19.0-rc1-s3k-dev-00005-g5a60513 #214
> > [    4.952908] Call Trace:
> > [    4.955382] [dec4fd20] [c02cb0d0] ubsan_epilogue+0x18/0x74 (unreliable)
> > [    4.962003] [dec4fd30] [c02cb5e0] handle_overflow+0xd0/0xe0
> > [    4.967588] [dec4fdb0] [c007b424] rcu_preempt_deferred_qs+0xc0/0xc8
> > [    4.973857] [dec4fdd0] [c007be28] rcu_note_context_switch+0x74/0x608
> > [    4.980217] [dec4fe10] [c064b790] __schedule+0x58/0x6e0
> > [    4.985448] [dec4fe50] [c064bfdc] preempt_schedule_common+0x48/0x9c
> > [    4.991717] [dec4fe70] [c01308c8] handle_mm_fault+0x10fc/0x1ecc
> > [    4.997639] [dec4fee0] [c001339c] do_page_fault+0x10c/0x760
> > [    5.003225] [dec4ff40] [c001234c] handle_page_fault+0x14/0x40
> > [    5.008968] --- interrupt: 401 at 0xff9cff8
> > [    5.008968]     LR = 0xfeefd78
> > [    5.016170] ================================================================================
> > [    5.024591] ================================================================================
> > [    5.033005] UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.h:627:28
> > [    5.039775] signed integer overflow:
> > [    5.043342] -2147483648 + -2147483648 cannot be represented in type 'int'
> > [    5.050118] CPU: 0 PID: 119 Comm: mkdir Not tainted
> > 4.19.0-rc1-s3k-dev-00005-g5a60513 #214
> > [    5.058348] Call Trace:
> > [    5.060813] [dec4fd20] [c02cb0d0] ubsan_epilogue+0x18/0x74 (unreliable)
> > [    5.067433] [dec4fd30] [c02cb5e0] handle_overflow+0xd0/0xe0
> > [    5.073014] [dec4fdb0] [c007b408] rcu_preempt_deferred_qs+0xa4/0xc8
> > [    5.079283] [dec4fdd0] [c007be28] rcu_note_context_switch+0x74/0x608
> > [    5.085640] [dec4fe10] [c064b790] __schedule+0x58/0x6e0
> > [    5.090871] [dec4fe50] [c064bfdc] preempt_schedule_common+0x48/0x9c
> > [    5.097139] [dec4fe70] [c01308c8] handle_mm_fault+0x10fc/0x1ecc
> > [    5.103059] [dec4fee0] [c001339c] do_page_fault+0x10c/0x760
> > [    5.108642] [dec4ff40] [c001234c] handle_page_fault+0x14/0x40
> > [    5.114385] --- interrupt: 401 at 0xff9cff8
> > [    5.114385]     LR = 0xfeefd78
> > [    5.121588] ================================================================================
> > 

