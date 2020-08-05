Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61409C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 04:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE88E20842
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 04:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE88E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLyfb6WWvzDqZT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 14:03:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=bauerman@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLycN2bt4zDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 14:01:55 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0753YLoC144016; Wed, 5 Aug 2020 00:01:43 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qbe5xarh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2020 00:01:42 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0753u4UG015013;
 Wed, 5 Aug 2020 04:01:41 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04wdc.us.ibm.com with ESMTP id 32n0195ks4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2020 04:01:41 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07541f7s12845638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2020 04:01:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11086112065;
 Wed,  5 Aug 2020 04:01:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5CFF112064;
 Wed,  5 Aug 2020 04:01:37 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.50.147])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Aug 2020 04:01:37 +0000 (GMT)
References: <20200804032937.7235-1-mdroth@linux.vnet.ibm.com>
 <873652zg8h.fsf@mpe.ellerman.id.au> <20200804161609.6cb2cb71@bahia.lan>
 <87zh79yen7.fsf@mpe.ellerman.id.au>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries/hotplug-cpu: increase wait time for vCPU
 death
In-reply-to: <87zh79yen7.fsf@mpe.ellerman.id.au>
Date: Wed, 05 Aug 2020 01:01:33 -0300
Message-ID: <878setaggy.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-05_03:2020-08-03,
 2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050026
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Cedric Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Greg Kurz <groug@kaod.org> writes:
>> On Tue, 04 Aug 2020 23:35:10 +1000
>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> There is a bit of history to this code, but not in a good way :)
>>>
>>> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
>>> > For a power9 KVM guest with XIVE enabled, running a test loop
>>> > where we hotplug 384 vcpus and then unplug them, the following traces
>>> > can be seen (generally within a few loops) either from the unplugged
>>> > vcpu:
>>> >
>>> >   [ 1767.353447] cpu 65 (hwid 65) Ready to die...
>>> >   [ 1767.952096] Querying DEAD? cpu 66 (66) shows 2
>>> >   [ 1767.952311] list_del corruption. next->prev should be c00a000002470208, but was c00a000002470048
>>> ...
>>> >
>>> > At that point the worker thread assumes the unplugged CPU is in some
>>> > unknown/dead state and procedes with the cleanup, causing the race with
>>> > the XIVE cleanup code executed by the unplugged CPU.
>>> >
>>> > Fix this by inserting an msleep() after each RTAS call to avoid
>>>
>>> We previously had an msleep(), but it was removed:
>>>
>>>   b906cfa397fd ("powerpc/pseries: Fix cpu hotplug")
>>
>> Ah, I hadn't seen that one...
>>
>>> > pseries_cpu_die() returning prematurely, and double the number of
>>> > attempts so we wait at least a total of 5 seconds. While this isn't an
>>> > ideal solution, it is similar to how we dealt with a similar issue for
>>> > cede_offline mode in the past (940ce422a3).
>>>
>>> Thiago tried to fix this previously but there was a bit of discussion
>>> that didn't quite resolve:
>>>
>>>   https://lore.kernel.org/linuxppc-dev/20190423223914.3882-1-bauerman@linux.ibm.com/
>>
>> Yeah it appears that the motivation at the time was to make the "Querying DEAD?"
>> messages to disappear and to avoid potentially concurrent calls to rtas-stop-self
>> which is prohibited by PAPR... not fixing actual crashes.
>
> I'm pretty sure at one point we were triggering crashes *in* RTAS via
> this path, I think that got resolved.

Yes, pHyp's RTAS now tolerates concurrent calls to stop-self. The
original bug that was reported when I worked on this ended in an RTAS
crash because of this timeout. The crash was fixed then.

--
Thiago Jung Bauermann
IBM Linux Technology Center
