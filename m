Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FB5C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:06:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028042186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028042186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gS7V5rMxzDqTX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gS5h2fbwzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 16:04:17 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3C5nk3b094752
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 02:04:14 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rtmgqsajs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 02:04:13 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 12 Apr 2019 07:04:12 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 12 Apr 2019 07:04:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3C6499517563648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Apr 2019 06:04:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0731B205F;
 Fri, 12 Apr 2019 06:04:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92B24B2065;
 Fri, 12 Apr 2019 06:04:09 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 12 Apr 2019 06:04:09 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id BC1172E324D; Fri, 12 Apr 2019 11:34:06 +0530 (IST)
Date: Fri, 12 Apr 2019 11:34:06 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/watchdog: Use hrtimers for per-CPU heartbeat
References: <20190409044005.26446-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409044005.26446-1-npiggin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19041206-0064-0000-0000-000003C9E778
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010913; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187874; UDB=6.00622253; IPR=6.00968641; 
 MB=3.00026405; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-12 06:04:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041206-0065-0000-0000-00003D08E69A
Message-Id: <20190412060406.GA26155@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-12_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120041
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
Reply-To: ego@linux.vnet.ibm.com
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Ravikumar Bangoria <ravi.bangoria@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Nicholas,


On Tue, Apr 09, 2019 at 02:40:05PM +1000, Nicholas Piggin wrote:
> Using a jiffies timer creates a dependency on the tick_do_timer_cpu
> incrementing jiffies. If that CPU has locked up and jiffies is not
> incrementing, the watchdog heartbeat timer for all CPUs stops and
> creates false positives and confusing warnings on local CPUs, and
> also causes the SMP detector to stop, so the root cause is never
> detected.
> 
> Fix this by using hrtimer based timers for the watchdog heartbeat,
> like the generic kernel hardlockup detector.
> 
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reported-by: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


--
Thanks and Regards
gautham.

