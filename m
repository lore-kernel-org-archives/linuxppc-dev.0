Return-Path: <linuxppc-dev+bounces-23240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22825C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 04:32:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqnF52zf8z2yQL;
	Wed, 01 Jul 2026 14:32:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782880377;
	cv=none; b=J2HDPYvRj1+LhRUWUhs9nmyJ1NnYQNlJX8l8Y4zUSG1kW+ylYjkoko5osCxr08UeXeSCl0yK8a2Q5VP9ayODZn2A3NgiLxBK1wSzAgXhvP2HnAMx6BT1vvxcITc0+/LGDgOWPEaOiFTloqycsJ487Od5lqOv5Bazni7OfoOE6egfZZFqrLRoBpR0n1qvE13jyfdVtuyHvEzSm4UmA9uGgOsmYPUy+6yKs2oAEze+sohCPqmOCiymSxy1EPthjD1ln34/rL5XpZ+8TnEGKWOra0pSLBRnonnMq9IAfhPaoJtUqH0bP+JvnXbOkrcfx13zsfrC8OxKid700dbrLpeOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782880377; c=relaxed/relaxed;
	bh=KR07QVSSDEYvycuyPUALTiuQWDSedko9F2gVEE/K1wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoeITF90DXK7gWm2mZNryCc3FCDbU5ibMwWzTaKc08NoTmC4M/kMzxq8R3KQz2RuzlhoSnHegTfaSi0qSqh0eWF83U5cAVV73wBPUcuurrrlIUAnEsl/zvLlMoUYQtEkgRg60v2IL8KL00np2blGJZ6vdpaxpuSl8OKSI730/gmx4EOflnUfOg9e24rTu6sOefu4lWgxLEQMVu7KfRyymWH2WZDflEMHTzu7c++EFKBI5MZ0Lap4A1OrHAbQAQTo4dPSYDbPmZDM/+GlTml4o3uJDP4ycf4O+lMkhwdbxCokXz/jOS8BVGrWCSSL7Lf2SdALvmBV2+lYp9hzpJbdOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y0xDI/Pe; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y0xDI/Pe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqnF40hxvz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 14:32:55 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IbpA3806419;
	Wed, 1 Jul 2026 04:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KR07QV
	SSDEYvycuyPUALTiuQWDSedko9F2gVEE/K1wo=; b=Y0xDI/PeO2Pl/5oj+Qd75l
	6CRdz1g0QCLj2Qj+82wSJlgY0JOsm6c+iYAhcGfWXdK3LhPNKKYB9HH4Yy49nrVn
	SczCmFHUkAx33D1cYPaB5DML6GLqe01c+M9gEDbqyZ6JNwF+iJMLu3L9oIf3jvwu
	4Ai7uHCoNwIW9uJmy/1m9YwqNdSFJea2EwyzzAS1LikywcZSXulHdZKJCNG2rmV/
	XRs+G2VfGXemShhe+B0bWez8O42kdHowPmbFpSrjMGUg641OykaAFvx4Eu34Amvg
	dl9/kCkep8hoBYkaQkCmY//DdW0qvrI7QSMPf1Xh2nN7XvXPHIOWPVqfGEFvsPrA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa2677-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 04:32:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6614KBA7019140;
	Wed, 1 Jul 2026 04:32:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w5phc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 04:32:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6614WCbS32506426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 04:32:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77F5D58054;
	Wed,  1 Jul 2026 04:32:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0905803F;
	Wed,  1 Jul 2026 04:32:07 +0000 (GMT)
Received: from [9.123.5.126] (unknown [9.123.5.126])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 04:32:07 +0000 (GMT)
Message-ID: <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
Date: Wed, 1 Jul 2026 10:02:06 +0530
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
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0MSBTYWx0ZWRfX26fUMa9e+dzf
 jV54JAqIUU6qWVT7K1puzbM6VTdUwWobM2eZT8I2enJE2cYztvg9nV2Rgbi79FjfeoCtL+hjoLJ
 gNRbWoOQMPsMehaxyPSIU12UOeLIMZUhpkKNTkIeNTKAkAv3S6VNahNI+s0ZSGLcg4INUrahFIG
 mlooGkNLb/i12893niFNaM0CsbUiEOMPYmMfKuxRPgyoZ/Gy6+W/cKQcGY7MsE8WAVxP/Tvs/aH
 676ck6dwiEATcJSf8tgjrnTqqU6PSLl/CP6uCiFVFdFNJLgDi5FUpj6XjSalBbkAjEtj2bcZDx3
 c0n1bHdWfG6dHCTvIGB1ohsMIfJOYNwDUNKZnzk4aiBJDyWBCh2obMMTlyjn4RR+sHlfQO+mTVk
 hA7geWyC+vzTKnDlZc5WvTvG6ER2vFv9ohOTGK9DaNGZhjtwdOskXhoTkL7GY0qD5aE/yyqjaro
 OgeWRlKeqHz4QckpgAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0MSBTYWx0ZWRfXxtJVljgEWdyT
 QKGrGiOSBj35P9V4TjFq+PpozqltfzHH2BrL0e7uTXJxWowPfdyw8ui90SmcyyClLrAh1Wteg7X
 XWeCKE++JzpiSIXe7STuWi9NxYCaRW8=
X-Proofpoint-GUID: 9MWPVextx98ji73r7A4b6eDRO_E14MI9
X-Proofpoint-ORIG-GUID: z7SpAtaZm-81-f06poyur8xe1pHtRgEr
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44984e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8 a=aow-egSQAAAA:8
 a=REQlIFMOIXFrVupGOfgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Et2XPkok5AAZYJIKzHr1:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010041


On 01/07/26 7:44 am, Madhavan Srinivasan wrote:
>
> On 7/1/26 12:41 AM, Paul Moore wrote:
>> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan 
>> <maddy@linux.ibm.com> wrote:
>>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>>> <chleroy@kernel.org> wrote:
>>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>
>>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>>>>> targets") added generic support for AUDIT but that didn't include
>>>>>> support for bi-arch like powerpc.
>>>>>>
>>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>>>>> added generic support for bi-arch.
>>>>>>
>>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>>
>>>>>> With this change generated text is similar.
>>>>>>
>>>>>> Thomas has confirmed that the previously failing filter_exclude/test
>>>>>> is now successful both without and with this patch, see [1]
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de/ 
>>>>>>
>>>>>>
>>>>>> Link: https://github.com/linuxppc/issues/issues/412
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>> Venkat, a test result with
>>>>>> https://github.com/linux-audit/audit-testsuite would be appreciated.
>>>>> Yes, I'd like to see confirmation that the audit test suite runs 
>>>>> clean
>>>>> on ppc systems with this patch applied, and unfortunately without a
>>>>> ppc system I have no way to test this myself.
>>> My bad, this is a miss from my end.
>>> Venkat is already on this and will update the results here.
>> Do we have an update on this?  Maybe I missed it, but I don't recall
>> seeing any test results.
> Venkat, did run the test but I guess he missed to respond here,
> Details of his test run that he shared me in the internal chat from 
> May 13.


Sorry, My bad. I missed updating here. Yes, this was tested in May. 
Please let me know, if a re-run is required?

Regards,

Venkat.

>
> backlog_wait_time_actual_reset/test .. ok
> bpf/test ............................. ok
> exec_execve/test ..................... ok
> exec_name/test ....................... ok
> fanotify/test ........................ ok
> field_compare/test ................... ok
> file_create/test ..................... ok
> file_delete/test ..................... ok
> file_permission/test ................. ok
> file_rename/test ..................... ok
> filter_exclude/test .................. ok
> filter_exit/test ..................... ok
> filter_saddr_fam/test ................ ok
> filter_sessionid/test ................ ok
> io_uring/test ........................ ok
> login_tty/test ....................... ok
> lost_reset/test ...................... ok
> netfilter_pkt/test ................... Can't exec "nc": No such file 
> or directory at netfilter_pkt/test line 83.
>
> Venkat, can you please re-run if possible and paste the log here.
>
> Thanks
> Maddy
>
>

