Return-Path: <linuxppc-dev+bounces-29264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389EECA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:15:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3KH83PRwz3bV5;
	Tue, 13 Oct 2026 01:15:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791814500;
	cv=none; b=jYf+8MyOfxjVh6Jansm+ZPFzTtXBtTuCTbM7nIJYBKoCUsDrwk1IjKxojBpbK2Fdk254J7LaI6o/PCarszvPIu9+utnDJjchQ/gJ131MzOx8gDrkbzeRyur1fqNZaH0OoA48XKPIkZ3Lb9iTMg1MOI8uJJRA2yNZfMlOTktGRuGNcJNCWvySs5Al6APmCLFrLjmjH8edRYOl3tWqcI7jmjbEu70yEiWQ9cmQdndQYLBT8bx0GZ1ThfY0L9pR+McMbeE1+E95/Te/yzdLeKPUUWNoyUv4fE0E3PQPAo1wb3qBrH1rYEGQaVc6MtQkl9luSJZuQzB8mwTW3A+OZm7BaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791814500; c=relaxed/relaxed;
	bh=nYBY2BEdKW3Ee2M0WH1npF5tIdNC/HdlhrA4UKHvRsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXxW6tfDZgdPx1IshCZHIElVoL1vv6sbFPILrhFe/dUI+r86T89KgTzV96mfAuVG8/bnJhjrJxN0cPbX+1IuEq4xNNByvnfQe0D0m8lSn62jh27U8+CFDXvxGZPbPGiIj3Nv0IGnmzOG0+mc1JvxzIN0BOZpnCpoHW9E0QQkDfdrus/mMUzGGp6RQ+dPuxQt7xSBgvyVh9IqsO9kW+xqg7PBU38MNSCWaWb6XQ9V/WBr/xbExwUgB3WNexSgMeNdv421VV0LqVCbuKbJroh5iiHtHJHaBt1hChg0OpbrlZblBLKab2ORzshq/Bfv4K9vCFrBMyptFEkR9TiT2QEZIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S6YJ0l1U; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S6YJ0l1U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3KH74cMFz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 01:14:59 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE5Ee181674;
	Mon, 12 Oct 2026 14:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nYBY2B
	EdKW3Ee2M0WH1npF5tIdNC/HdlhrA4UKHvRsA=; b=S6YJ0l1UVh67BG/Tnq2gAK
	CMcuogwmlFY8lXEv3VfIXRy7hV1M/oKX3bQXKy2e2TI4FCzxYZhdYoCBdl7tJCJa
	3EvyBf32NI8B/FO2LS3puCtVkeGym44WKNrilNHm8ka4xKsAbybTGfFe2WUki0tt
	tYBxZLE+4EVDW3yXoAS40U81kEsGzzRPZhjPIKk84UY0ThlLU2GII9mLqBqbN3zj
	+16YLd9Cx+Xgk9xMzfuwA7oPC3oDgS/+0XKwsjQT+lF6h8ocXAuRyG0M3m9DakyM
	Msb+Zdj9ii5aZ/Q/6qTkcPWPQX0jskvXanfXrlhh5dGObVRNCXNAGHLB3nL/dZuA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv399qs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:14:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4uRN013441;
	Mon, 12 Oct 2026 14:14:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwask-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:14:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEEamn49414452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:14:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A607820043;
	Mon, 12 Oct 2026 14:14:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60F4E20040;
	Mon, 12 Oct 2026 14:14:33 +0000 (GMT)
Received: from [9.124.214.197] (unknown [9.124.214.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:14:33 +0000 (GMT)
Message-ID: <b03786e6-28f3-4fad-bd32-33803ea2fd8c@linux.ibm.com>
Date: Mon, 12 Oct 2026 19:44:32 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, npiggin@gmail.com, mpe@ellerman.id.au
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <aszQR3jtdzE0OeB-@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aszQR3jtdzE0OeB-@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yPdxMBPrbcYv-xVpP5DYG2SaviyOF7R0
X-Proofpoint-ORIG-GUID: KEof3A7tF05NuSUDuOscKlfq1zk3eMJA
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acceb51 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jaEAVqPHSARQqII2670A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXzFwW0OkYCtXA
 XWBJw8zU9SXsRUaYuaon8JRp+wiXx7pNnhkYzl4v0+DLWrRASsWdVtr46qg6BdSqvv0gXyh2xdW
 2EvSN4UC6/OpKy3xr7DFc8vd6yBBn+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX54YNnjNeMuvS
 cD8is9WWS4DM41RT3+p5b7QgtsqJDMwmzvRPE65xeOmE5Ez3zxU09PYILNz9r3cijrxPhu5fE63
 +xotzyo1BpQ+xXmdmJC5PlT0Zf/AIuSVth9yjpnmRFGARSStIin+h5ymGdiu7O9hymauEYDm8Yg
 /XdCqLrEEKd6i11P1qvWSwb4FBRep6XZuo+ZhdniGUVvoRNPt/+fgsQx0OrGf1a3Sp7Ide3GWKU
 wG8MggQ/kNbodePgu6qKzD1jaAhjB0YFK+FtThwX/VFxJzKEqKGrZY1zgABG1UQ4uXY4utAMQIg
 uE3sRy+HbXY5nm/x2mPKBWTuE7S93JHSNSrchtHLrKRaWSWu6lGiOQpHJxE7I6v2CZhh1aLPOW8
 SMIayCy2tU8awO1ntoWLvAQK1AfHfMSXZbXTfjmPW0Zy9AuSqITvifAFnln19NLOTdm82wJnsby
 d42PTB1vEPhgqv15PnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/12/26 5:49 PM, Srikar Dronamraju wrote:
> * Shrikanth Hegde <sshegde@linux.ibm.com> [2026-10-12 15:50:33]:
> 
> 
> Hi Shrikanth,
> 
>> There is a new feature in scheduler called as Cache Aware Scheduling [1].
>> It tries to keep related tasks within the same LLC domain while
>> keeping the system reasonably balanced.
>>
>> Cache Aware Scheduling assumes that the scheduler LLC domain is large enough
>> to be a useful placement target. This is true on many systems where an LLC spans
>> several cores, but not on PowerPC systems where the scheduler-visible LLC is at
>> the SMT level. In that case, sd_llc_size is effectively the SMT width.
>>
> 
> Can we add a reference to the earlier attempt to try MCLLC a few years back.
> 

Ah yes. will add it.

It is this one.
https://lore.kernel.org/all/1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com/

But I couldn't find an email id of Gautham which won't bounce. Based on what i know :)

