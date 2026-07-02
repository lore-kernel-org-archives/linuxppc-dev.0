Return-Path: <linuxppc-dev+bounces-23395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C447C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:50:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grcDd6R8zz2ynC;
	Thu, 02 Jul 2026 22:50:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782996625;
	cv=none; b=olzMfQoVZf0DwXCYS/NFKPE77o5JhNkoVCDOw/wPSbZDFA4HiZ5hal8T/2sNKKomwc9hjE2S1fEH5cl7ZCusnd5h1rnaqevOPqNQ7ro6rV+KopXNf57tLcCil2ueX66drjUnZjqwhmwGktnmxwgMfTGQnuf7+C1L66+aUpW51MXJH7dkM0NhLKCISPngOiQ/jEG4cVnbizbSXe158HP0LQUzdmiYQqpCZQSpbtcK/7Qc1lfonPUeU8tUQRJowjHAeNQpZs4D9xGx4n3uAH3SaDT2cVp1lcYJ/+eBvWJ3Djd27hCPK8onHX51AmXD84a2mKV8vrKRWeZEjXQSpbED9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782996625; c=relaxed/relaxed;
	bh=CHldIqq1evswpYBmbdYSGpRRp7dtwQQfTH8BAr68J0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRVTdpsEWwvIzVpG/XlgL4XeJgiOcBiFhNOQ7GD1YYLg0ypotXkrdlQ7tJ8uKygCdeDF4l7sGqIifZfO7MvageIj6cEVkUP5tlV4UKxjGgOfVx3LSTB00mxev060BvNSj4TGLAInnCaKK3iEmOfyhOKZNy1uLXoou7C6MnW81Rd3Htp1ISlRc4IETO+QmK0d9ieGKCeEV2nFXdv9euKFJvFlyjOBVFtClnjfRQq4f+RxuA0HZn3b8XBYjfHeRf7smbGz45RqyyznVBFGp7mFBoySHBrLQlbe137DFU/sE0q4/2PiKTCEQDh+TMLlsromC84/ydCEWYLHDAQlREY3Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sTz36Wgf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sTz36Wgf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grcDb5cjtz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:50:23 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KWGX2347149;
	Thu, 2 Jul 2026 12:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CHldIq
	q1evswpYBmbdYSGpRRp7dtwQQfTH8BAr68J0w=; b=sTz36WgfItTobqp8TEIWZK
	adVb1yv4ESdl92Hmeng57UvB8/2OIpBuN+Y3I0FqGWW6InGQICMGS2qqKDp7eo+k
	5b75qE0PuPvsIEeXPc2RkIAW3ZeCCVtGpyUCm34DISdbWJVW7Uxc/IizNLADF27L
	urEhkKuSs3u5e7sdeRYrHfe5iLpGS49MucpXMq2FEhcjkvQCS2PJo02cNluN6YuJ
	IB+ftlm7P8TwvLnNx/T8sgiREZ2xwq82S03z1l/EpEzeWhwQU6KMFAhwlAzPyHvR
	TDqt7rCTcXxbifg/1EBAVrCndhuXlpDeW0yf+gkpKqDsJljWNwuZ2jwCEy/rr9ZA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk1jma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 12:50:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662CndJj013622;
	Thu, 2 Jul 2026 12:50:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyks2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 12:50:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662CnwpQ63504768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 12:49:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8829D58050;
	Thu,  2 Jul 2026 12:49:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A8658045;
	Thu,  2 Jul 2026 12:49:54 +0000 (GMT)
Received: from [9.61.241.87] (unknown [9.61.241.87])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 12:49:53 +0000 (GMT)
Message-ID: <203f6e6d-2ce8-4e47-99a6-f4af745e0aaa@linux.ibm.com>
Date: Thu, 2 Jul 2026 18:19:52 +0530
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
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
Content-Language: en-GB
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
 <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
 <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com>
 <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
 <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org>
 <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
 <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzNCBTYWx0ZWRfX3tUp7rsrcp3q
 iJVjx2DHvNd4TEqUpkqWTtKZEygD1SxKAQF0tKRpJNj2JVBo+bIkJDqmlmWEWh81xWHKxFzd93h
 97QWdm35dNA9VyfVcPIUgm1sN4Wt7c+Y/Fam/AmipsBlyrbeKRFsK2QmADv1aK2+8WFpnHxZAZ6
 3P2g1O9kiIHMqpaT1KN1yx9eRXpHo0wWUW31HG0faKRmIMS6HOhoSSOdjaGJncrQvVU8EM3V8Kx
 yTORdMSup9xZNUj0Dw7EO6avylyV4qGBXRXQqr/48ECc1VavTHGuE2Lku6NtfVriO7voBaswX+k
 Y69y2kAjxEDSFnn9BLBPHQ91DYNJBtq+b9EFqHbDHjL463aEyN3K6AY0Pij+LhbFFIn28w1Ywu+
 rCJXiEtEHB1bw4Cl/D/VgEe+vi8kcX6mhYxtO8dn2a9CcFcTvgyXIfJotrQ7KYNO1SeDFeQm6Gj
 X0rAJLnKRzDwrxg/vOQ==
X-Proofpoint-GUID: i21lsAhRpsquVsKZPKsz2iF1C7u9DCGV
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a465e79 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=UqCG9HQmAAAA:8
 a=vTr9H3xdAAAA:8 a=3WQPG5ikAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=1UX6Do5GAAAA:8 a=NEAV23lmAAAA:8 a=aow-egSQAAAA:8 a=JMnnF-g5AAAA:8
 a=F7XckJlXCOfkPJ1Mge8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zBohcZEwHkW0jPBbCVRQ:22 a=Et2XPkok5AAZYJIKzHr1:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=MIlUOSWcqtxlsnWNI7We:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzNCBTYWx0ZWRfX+qyrH++EgOsm
 /GDhOb22wziga+cKVxdVaD6qPyUiD6zhLIWqcFIAUuI9bUKUHumAMfqs7wm3nrGxHbuqAXUBg++
 zRL612AyJqLETP9C+oKlN6M7Zlxv+bg=
X-Proofpoint-ORIG-GUID: u9x1tGtYp05us-Vs-gfT38RN5tB-B2rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020134


On 01/07/26 2:23 pm, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 01/07/2026 à 10:09, Venkat Rao Bagalkote a écrit :
>>
>> On 01/07/26 10:26 am, Christophe Leroy (CS GROUP) wrote:
>>>
>>>
>>> Le 01/07/2026 à 06:32, Venkat Rao Bagalkote a écrit :
>>>>
>>>> On 01/07/26 7:44 am, Madhavan Srinivasan wrote:
>>>>>
>>>>> On 7/1/26 12:41 AM, Paul Moore wrote:
>>>>>> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan 
>>>>>> <maddy@linux.ibm.com> wrote:
>>>>>>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>>>>>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>>>>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>>>>>>> <chleroy@kernel.org> wrote:
>>>>>>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>>>
>>>>>>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all 
>>>>>>>>>> normal
>>>>>>>>>> targets") added generic support for AUDIT but that didn't 
>>>>>>>>>> include
>>>>>>>>>> support for bi-arch like powerpc.
>>>>>>>>>>
>>>>>>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall 
>>>>>>>>>> support")
>>>>>>>>>> added generic support for bi-arch.
>>>>>>>>>>
>>>>>>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>>>>>>
>>>>>>>>>> With this change generated text is similar.
>>>>>>>>>>
>>>>>>>>>> Thomas has confirmed that the previously failing 
>>>>>>>>>> filter_exclude/test
>>>>>>>>>> is now successful both without and with this patch, see [1]
>>>>>>>>>>
>>>>>>>>>> [1]
>>>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260306115350- 
>>>>>>>>>> ef265661-6d6b-4043-9bd0-8e6b437d0d67%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771399964577%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FtCHXFR5np67gntCnXqv7Eemo5WuwaIEcywxZQzDADA%3D&reserved=0
>>>>>>>>>>
>>>>>>>>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F412&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400190794%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4fPEX7HuGBcxOcXlcJVQvDdP7Y9InhDpbz3z%2BS9lkCQ%3D&reserved=0 
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>>>> ---
>>>>>>>>>> Venkat, a test result with
>>>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinux-audit%2Faudit- 
>>>>>>>>>> testsuite&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400214912%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=yHp3p5zNx%2BqQg2cKBsKJADWcUcKVtZstzNScBfWzF%2FQ%3D&reserved=0 
>>>>>>>>>> would be appreciated.
>>>>>>>>> Yes, I'd like to see confirmation that the audit test suite 
>>>>>>>>> runs clean
>>>>>>>>> on ppc systems with this patch applied, and unfortunately 
>>>>>>>>> without a
>>>>>>>>> ppc system I have no way to test this myself.
>>>>>>> My bad, this is a miss from my end.
>>>>>>> Venkat is already on this and will update the results here.
>>>>>> Do we have an update on this?  Maybe I missed it, but I don't recall
>>>>>> seeing any test results.
>>>>> Venkat, did run the test but I guess he missed to respond here,
>>>>> Details of his test run that he shared me in the internal chat 
>>>>> from May 13.
>>>>
>>>>
>>>> Sorry, My bad. I missed updating here. Yes, this was tested in May. 
>>>> Please let me know, if a re-run is required?
>>>
>>> It looks like netcat 
>>> (https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flinux.die.net%2Fman%2F1%2Fnc&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C97ac234e82884f729d1508ded7480f62%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184901648983046%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=18PJTLp9ozMqSkWWvBZmtjzjTI355Oq%2F5aqmU6zCiZE%3D&reserved=0) 
>>> is not installed in you setup. Are you able to install it and rerun 
>>> the test ?
>>
>>
>> I investigated the failure on the RHEL 10 ppc64le test system.
>>
>>
>> The netfilter_pkt failure is due to missing userspace dependencies:
>>
>> Can't exec "nc": No such file or directory
>> Can't exec "iptables": No such file or directory
>> Can't exec "ip6tables": No such file or directory
>>
>> I checked the system and confirmed that nc, ncat, iptables, and 
>> ip6tables are not installed:
>>
>>
>> which nc
>> which ncat
>> which iptables
>> which ip6tables
>>
>>
>> all return "not found".
>>
>> The system has nftables installed (/usr/sbin/nft), but I was unable 
>> to locate packages providing nc/ncat or iptables/ip6tables in the 
>> currently enabled repositories (epel, rh10_base, rh10_app, rh10_crb).
>
> Found:
> - 
> https://dl.fedoraproject.org/pub/epel/10/Everything/ppc64le/Packages/n/netcat-1.238-1.el10_3.ppc64le.rpm
> - 
> https://rpmfind.net/linux/RPM/almalinux-kitten/10/baseos/ppc64le/iptables-nft-1.8.11-6.el10.ppc64le.html
> - 
> https://www.rpmfind.net/linux/RPM/centos-stream/10/appstream/ppc64le/iptables-devel-1.8.11-14.el10.ppc64le.html
>
> Does it help ?
>
> Christophe


Hi Christophe,


Thanks for sharing the RPMs,they were very helpful.

I reran the audit-testsuite after installing the missing userspace 
dependencies that were identified earlier.

I installed:
     - netcat (nc)
     - iptables
     - ip6tables

Following this, the previously failing netfilter_pkt test is now passing:

     netfilter_pkt/test ................... ok


Current remaining issue:

1. amcast_joinpart
------------------
Still fails due to a missing Perl dependency:

     Can't locate Socket/Netlink.pm in @INC

I searched the configured repositories and could not find a package 
providing Socket::Netlink / Socket/Netlink.pm on this EL10 ppc64le system.

Latest run summary:

amcast_joinpart/test ................. Can't locate Socket/Netlink.pm in 
@INC (you may need to install the Socket::Netlink module) (@INC entries 
checked: /usr/local/lib64/perl5/5.40 /usr/local/share/perl5/5.40 
/usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl 
/usr/lib64/perl5 /usr/share/perl5 .) at amcast_joinpart/test line 10.
BEGIN failed--compilation aborted at amcast_joinpart/test line 10.
amcast_joinpart/test ................. Dubious, test returned 2 (wstat 
512, 0x200)
Failed 7/7 subtests
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
time_change/test ..................... ok
user_msg/test ........................ ok

All tests now pass except amcast_joinpart, which is blocked by the 
missing Socket::Netlink Perl module.

Please let me know if there is a recommended package source for 
Socket::Netlink on EL10 ppc64le.

Regards,
Venkat.

>
>>
>>
>> At this point, the remaining failure appears to be an environmental 
>> dependency issue rather than a test failure. Please let me know if 
>> there is a recommended package/repository for EL10 ppc64le that 
>> provides netcat and iptables compatibility tools, and I can re-run 
>> the test.
>>
>>
>> Regards,
>>
>> Venkat.
>>
>>>
>>> Thanks
>>> Christophe
>>>
>>>>
>>>> Regards,
>>>>
>>>> Venkat.
>>>>
>>>>>
>>>>> backlog_wait_time_actual_reset/test .. ok
>>>>> bpf/test ............................. ok
>>>>> exec_execve/test ..................... ok
>>>>> exec_name/test ....................... ok
>>>>> fanotify/test ........................ ok
>>>>> field_compare/test ................... ok
>>>>> file_create/test ..................... ok
>>>>> file_delete/test ..................... ok
>>>>> file_permission/test ................. ok
>>>>> file_rename/test ..................... ok
>>>>> filter_exclude/test .................. ok
>>>>> filter_exit/test ..................... ok
>>>>> filter_saddr_fam/test ................ ok
>>>>> filter_sessionid/test ................ ok
>>>>> io_uring/test ........................ ok
>>>>> login_tty/test ....................... ok
>>>>> lost_reset/test ...................... ok
>>>>> netfilter_pkt/test ................... Can't exec "nc": No such 
>>>>> file or directory at netfilter_pkt/test line 83.
>>>>>
>>>>> Venkat, can you please re-run if possible and paste the log here.
>>>>>
>>>>> Thanks
>>>>> Maddy
>>>>>
>>>>>
>>>
>
>

