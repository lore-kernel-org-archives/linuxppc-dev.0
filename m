Return-Path: <linuxppc-dev+bounces-23275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEB5C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:09:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqt2v0Tg6z2xPb;
	Wed, 01 Jul 2026 18:09:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782893366;
	cv=none; b=KbNSjyQlyTAqgfmRP4bC79W1GLucK3Z4MF/jrPCQISWx5muP6J7AfG+IzRpFzLZKH4yMY4tNa7D1pPVXwjUc4yhx1uqKMYD0vcZlxMxOIeaLSH1MUHMVSZixd9ucPyyktz1gSgnwxo/ElZYSQfa+aI9CLfdmlDkM5/vlS4WVcEGdZXDegP4XpGLAelXq68uO7QlIBVr0EpPn+441T4SS3P66zwQ0jglRly0CxpYW5eLOTRKNfWUPiEZWGmZVOpsp21ct/0/wkZJlwxn1EnWtJOYco7abeAOEpValLDGpcHlOl/kA3R8sv7MVzZ1fyyZnjGZagrFYXxnpEC+DLrIS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782893366; c=relaxed/relaxed;
	bh=riGYQfpgPU3zQ2rItHrXCy3BDoJJjBe08B+hIHSv+rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6Q79b+SmY0MgVdNn6U1G4qpaqlW8dRIvnebzTfP1LplQ2eBiAOsaBjLnMOulMlNW3Gh4vvpiNp3NTJ20h+6I6koQ5B3g6nOcECJ1UVEwnzjdkK1JOZrayGrngPJ/UVx7s4OeBeyr1nkQjVLN53/8+ZoknvtIiym90jAXkocybjqwjrDmVNP3kpWxDe/LdI9mIDzPMJR00slebo3aE4StNEypn0bBaYzcTGLjGguzNqEL5RGbGK+uDQ5V1KACPGmY4DnN+HkRaJ4VeqkXsrwTNVtm/0YNudettxKhurhbiE560Mc9v5UDf0UsyEQajSnRvsG9NwN0rPgzb68pF1kFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=brb67ulU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=brb67ulU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqt2s5zT0z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:09:25 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613ICWj3925049;
	Wed, 1 Jul 2026 08:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=riGYQf
	pgPU3zQ2rItHrXCy3BDoJJjBe08B+hIHSv+rk=; b=brb67ulUk5D1nqHy2jjZhp
	j0HysGqKcZuUZmMENChSnYsIgJ2U6xGXsCpaR3nfN9+LOaD80chstAf6wkdPeSjs
	AC8u59r4m3vjekPi6+bVzljv2+oKaQTz6pK2df4jE7eFHlv3TTmmM2R6mvOXIYd8
	xCc1Kv1faEWvonVuR9dIvi0auGIlK4Uqj67uaktNAvMGKdNaZ7G52UqH7i+Bxo3e
	hBT1krMQP0QJwfF3imTbPI0bF5TPhTZ/sS2WuaYbl9zWFcPaAeE34nDQBYOsJ3we
	rIvATDn06deERuQXohFqofywrhuZlBcJL2GtzboKZKgQonWUHtw7S/wQLkqUj+Og
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3ckh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:09:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66184foO002385;
	Wed, 1 Jul 2026 08:09:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhe95n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:09:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661897MI18088600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:09:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F24958062;
	Wed,  1 Jul 2026 08:09:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C9F658060;
	Wed,  1 Jul 2026 08:09:03 +0000 (GMT)
Received: from [9.123.5.126] (unknown [9.123.5.126])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:09:02 +0000 (GMT)
Message-ID: <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
Date: Wed, 1 Jul 2026 13:39:01 +0530
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
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: STmFlvzKwZ7jAC-87ZIKWybYzzeQ5fkd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OCBTYWx0ZWRfX9RvnTtxxp5Et
 SGyvVRoKF1WsL8lZFqOj19B3CJQrgr87lqE4viI8fM5i7PCp06WSBvfX8oWXB6wF4zZn8DGUMMy
 DPMmce3dJc/gosSFxo38++3eHno8TuU=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44cb26 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=UqCG9HQmAAAA:8
 a=JMnnF-g5AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=1UX6Do5GAAAA:8
 a=NEAV23lmAAAA:8 a=aow-egSQAAAA:8 a=zamrEt3PUCJsTzUkVqsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MIlUOSWcqtxlsnWNI7We:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OCBTYWx0ZWRfXyMEqG+4knwUO
 nG0Tenh7LBKLhwZh9Im4OXBwsP1CxfMrUVWmKhKV0gmNvk+2tUh03KpQ+6kkWi2/4/IdYYQ9Bkb
 bRAsbgrEbQU7/OEjh87p5+M660NmHMt0lhqQCsmO/EhYdekHKgQoYr1pNzucsAkx0+plf1e3dGz
 w4V147KtnIjK02iWjqgmTFKdfe+T8c1oi0YRRyAMz930JLzokdIY+sLfERQwOproKec+BISJMla
 y+cpCkxmzRYfetR73t5k55Cn+bi+1sbFbXQk6NVj9K7iOxDr6PBD8r8AuZsigMZNnC/Atpyom20
 q3KnUgT26EXaucZJhc3LIdbgB9KL+PjeacA4ekbpEBhdsA4bXcGtZjYpLDbyNQ0/mp55cwuywQ+
 l4WlpY74Wx464CVpdGZm0IPfEPT5MVf3JiBsaMWbyDeuFKRkRE0WRjUAnThWCPmjMRJXJ1yRQKH
 po+p7TNL//HiQR9zavQ==
X-Proofpoint-ORIG-GUID: KgwnIGHxi1maYNdwsIJenB-giweDLNpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010078


On 01/07/26 10:26 am, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 01/07/2026 à 06:32, Venkat Rao Bagalkote a écrit :
>>
>> On 01/07/26 7:44 am, Madhavan Srinivasan wrote:
>>>
>>> On 7/1/26 12:41 AM, Paul Moore wrote:
>>>> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan 
>>>> <maddy@linux.ibm.com> wrote:
>>>>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>>>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>>>>> <chleroy@kernel.org> wrote:
>>>>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>
>>>>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>>>>>>> targets") added generic support for AUDIT but that didn't include
>>>>>>>> support for bi-arch like powerpc.
>>>>>>>>
>>>>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>>>>>>> added generic support for bi-arch.
>>>>>>>>
>>>>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>>>>
>>>>>>>> With this change generated text is similar.
>>>>>>>>
>>>>>>>> Thomas has confirmed that the previously failing 
>>>>>>>> filter_exclude/test
>>>>>>>> is now successful both without and with this patch, see [1]
>>>>>>>>
>>>>>>>> [1]
>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260306115350- 
>>>>>>>> ef265661-6d6b-4043-9bd0-8e6b437d0d67%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771399964577%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FtCHXFR5np67gntCnXqv7Eemo5WuwaIEcywxZQzDADA%3D&reserved=0 
>>>>>>>>
>>>>>>>>
>>>>>>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F412&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400190794%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4fPEX7HuGBcxOcXlcJVQvDdP7Y9InhDpbz3z%2BS9lkCQ%3D&reserved=0
>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>> ---
>>>>>>>> Venkat, a test result with
>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinux-audit%2Faudit- 
>>>>>>>> testsuite&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400214912%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=yHp3p5zNx%2BqQg2cKBsKJADWcUcKVtZstzNScBfWzF%2FQ%3D&reserved=0 
>>>>>>>> would be appreciated.
>>>>>>> Yes, I'd like to see confirmation that the audit test suite runs 
>>>>>>> clean
>>>>>>> on ppc systems with this patch applied, and unfortunately without a
>>>>>>> ppc system I have no way to test this myself.
>>>>> My bad, this is a miss from my end.
>>>>> Venkat is already on this and will update the results here.
>>>> Do we have an update on this?  Maybe I missed it, but I don't recall
>>>> seeing any test results.
>>> Venkat, did run the test but I guess he missed to respond here,
>>> Details of his test run that he shared me in the internal chat from 
>>> May 13.
>>
>>
>> Sorry, My bad. I missed updating here. Yes, this was tested in May. 
>> Please let me know, if a re-run is required?
>
> It looks like netcat (https://linux.die.net/man/1/nc) is not installed 
> in you setup. Are you able to install it and rerun the test ?


I investigated the failure on the RHEL 10 ppc64le test system.


The netfilter_pkt failure is due to missing userspace dependencies:

Can't exec "nc": No such file or directory
Can't exec "iptables": No such file or directory
Can't exec "ip6tables": No such file or directory

I checked the system and confirmed that nc, ncat, iptables, and 
ip6tables are not installed:


which nc
which ncat
which iptables
which ip6tables


all return "not found".

The system has nftables installed (/usr/sbin/nft), but I was unable to 
locate packages providing nc/ncat or iptables/ip6tables in the currently 
enabled repositories (epel, rh10_base, rh10_app, rh10_crb).


At this point, the remaining failure appears to be an environmental 
dependency issue rather than a test failure. Please let me know if there 
is a recommended package/repository for EL10 ppc64le that provides 
netcat and iptables compatibility tools, and I can re-run the test.


Regards,

Venkat.

>
> Thanks
> Christophe
>
>>
>> Regards,
>>
>> Venkat.
>>
>>>
>>> backlog_wait_time_actual_reset/test .. ok
>>> bpf/test ............................. ok
>>> exec_execve/test ..................... ok
>>> exec_name/test ....................... ok
>>> fanotify/test ........................ ok
>>> field_compare/test ................... ok
>>> file_create/test ..................... ok
>>> file_delete/test ..................... ok
>>> file_permission/test ................. ok
>>> file_rename/test ..................... ok
>>> filter_exclude/test .................. ok
>>> filter_exit/test ..................... ok
>>> filter_saddr_fam/test ................ ok
>>> filter_sessionid/test ................ ok
>>> io_uring/test ........................ ok
>>> login_tty/test ....................... ok
>>> lost_reset/test ...................... ok
>>> netfilter_pkt/test ................... Can't exec "nc": No such file 
>>> or directory at netfilter_pkt/test line 83.
>>>
>>> Venkat, can you please re-run if possible and paste the log here.
>>>
>>> Thanks
>>> Maddy
>>>
>>>
>

