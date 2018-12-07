Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F8C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 10:45:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6453C20672
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 10:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6453C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B8J26LTKzDrhQ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 21:45:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B8Fk3d4rzDrPC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 21:43:22 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB7Adpnu054553
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Dec 2018 05:43:18 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p7q8f09u1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 05:43:18 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 7 Dec 2018 10:43:17 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 7 Dec 2018 10:43:14 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB7AhDR516711754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 10:43:13 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C05B124052;
 Fri,  7 Dec 2018 10:43:13 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 297E2124054;
 Fri,  7 Dec 2018 10:43:13 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.115])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  7 Dec 2018 10:43:13 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id A49F82E4C9C; Fri,  7 Dec 2018 16:13:11 +0530 (IST)
Date: Fri, 7 Dec 2018 16:13:11 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] pseries/hotplug: Add more delay in pseries_cpu_die while
 waiting for rtas-stop
References: <1544095908-2414-1-git-send-email-ego@linux.vnet.ibm.com>
 <87a7li5zv2.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7li5zv2.fsf@morokweng.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18120710-0072-0000-0000-000003D5E190
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010187; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01128244; UDB=6.00582089; IPR=6.00908375; 
 MB=3.00024554; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-07 10:43:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120710-0073-0000-0000-00004A5CE9B8
Message-Id: <20181207104311.GA11431@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-07_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812070093
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Thiago,

On Thu, Dec 06, 2018 at 03:28:17PM -0200, Thiago Jung Bauermann wrote:

[..snip..]

> 
> 
> I posted a similar patch last year, but I wasn't able to arrive at a
> root cause analysis like you did:
> 
>
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/153734.html

Ah! Nice. So this is a known problem.

> 
> One thing I realized after I posted the patch was that in my case, the
> CPU was crashing inside RTAS. From the NIP and LR in the trace above it
> looks like it's crashing in RTAS in your case as well.
> 
> Michael Ellerman had two comments on my patch:
> 
> 1. Regardless of the underlying bug, the kernel shouldn't crash so we
> need a patch making it more resilient to this failure.
> 
> 2. The wait loop should use udelay() so that the loop will actually take
> a set amount of wall time, rather than just cycles.
> 
> Regarding 1. if the problem is that the kernel is causing RTAS to crash
> because it calls it in a way that's unsupported, then I don't see how we
> can make the kernel more resilient. We have to make the kernel respect
> RTAS' restrictions (or alternatively, poke RTAS devs to make RTAS fail
> gracefuly in these conditions).


I agree that the Kernel has to respect RTAS's restriction. The PAPR
v2.8.1, Requirement R1-7.2.3-8 under section 7.2.3 says the following:

    "The stop-self service needs to be serialized with calls to the
     stop-self, start-cpu, and set-power-level services. The OS must
     be able to call RTAS services on other processors while the
     processor is stopped or being stopped"

Thus the onus is on the OS to ensure that there are no concurrent rtas
calls with "stop-self" token.

> 
> Regarding 2. I implemented a new version of my patch (posted below) but
> I was never able to test it because I couldn't access a system where the
> problem was reproducible anymore.
> 
> There's also a race between the CPU driving the unplug and the CPU being
> unplugged which I think is not easy for the CPU being unplugged to win,
> which makes the busy loop in pseries_cpu_die() a bit fragile. I describe
> the race in the patch description.
> 
> My solution to make the race less tight is to make the CPU driving the
> unplug to only start the busy loop only after the CPU being unplugged is
> in the CPU_STATE_OFFLINE state. At that point, we know that it either is
> about to call RTAS or it already has.

Ah, yes this is good optimization. Though, I think we ought to
unconditionally wait until the target CPU has woken up from CEDE and
changed its state to CPU_STATE_OFFLINE. After if PROD failed, then we
would have caught it in dlpar_offline_cpu() itself.

> 
> Do you think this makes sense? If you do, would you mind testing my
> patch? You can change the timeouts and delays if you want. To be honest
> they're just guesses on my part...

Sure. I will test the patch and report back.

--
Thanks and Regards
gautham.

