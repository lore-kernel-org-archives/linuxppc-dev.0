Return-Path: <linuxppc-dev+bounces-24046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A44C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 13:21:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gy8VK05Trz2y8F;
	Sat, 11 Jul 2026 23:21:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783776088;
	cv=none; b=ked0oIj53+9MWWrGDj+EVJ3EbV+gq49db1TUMh6cuwWNZECr+Y0b9Sz+Po6JOs5zr3CFwulTgFR/3a+OhozU5O76MS4pXg8MoQ5/02KneO6w3VIcmq/bO/kysK3yTPRwBGh0yfFWHw9ABkXPasFd9BVxw8uSHKN8xJPkyQrVEkk8rMC7JaHLjkLha7mnh1Vt8yvFEQVb+5l5l0qMG38aAGqEO9cI+pXKRsq4lJJ51jaGYxUF4Gb+JZfqIcOwkg2jZtT83yKOeQUozj9hh9ps0NMvxbB8+jkDc6LMGF52y7aLgKWmYsxivyXkPc1qUGPBi1AMBejyYzvOS1F4CSyKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783776088; c=relaxed/relaxed;
	bh=O7lnCKXnQW2QPH2AldFO23uDPdCuDkc7c/nYmFujzPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FR/EgaOgCaXuQD17+fO4x/AFK45Tg7agNPRRe6f3IIfyqOrQ/B56iQirmhgYFcMQC/CFThbkGFRJlCqj/oy3EWc94Av26XhItcQ3KG5czDIlxCRBKL4j9mYQzjhZeMhoJj/l9mep69lKKz3jeDaj3G0Kk2PqtwwNQafFNeCUcPephDOwOvCyiceXO/3zmMa6cf/PWP4Elvqye8Pag244r/fAWkeOfabVX2yr+zqxEmD0P4Za32ICp5aA1AiSNwtMUxzayn8gMD2N7KhNmfPJySTZTdIC33qk9tvY1TPV3BJnUvC+q1SATfZMgEFIv7LGk5u1YyAZEh1M0Qy9WMoiTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y8/X9YQc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y8/X9YQc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gy8VJ4bQWz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 23:21:27 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BBBrUp800067;
	Sat, 11 Jul 2026 13:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O7lnCK
	XnQW2QPH2AldFO23uDPdCuDkc7c/nYmFujzPY=; b=Y8/X9YQc9yU/XnaCLjWF7r
	uUchAEqouSYg7cSx9WNzAx96N+iqCSfOpP3UnByT6n9dbYYziAafmSgkfmy1zMzK
	qtxEWXuPZZISpmaSgQ4LL2GGJ3+Vj/A+dMuvM3BWn3QvHw4r5mLXqt0Gf8A1LiSd
	dp+1hyRtPk8PCt2vDXHqBcJlNH5i2LO1mXtU6CrPHXx/TiVDuvbQH9cVIX0JtMKj
	Svr4f59X79PxpbHWltrDnGJPCJ2fYPOBg6sxJ/Tk4jehyJRHzifbFP+koZIRG05L
	XvTBy234TLv+BrQnzGLqPxPT1GsIZ4Kr9iD8nNzY1Lnfwb4xw4fnvztA+a09vDWg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber8168p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 13:21:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66BDK1MD007646;
	Sat, 11 Jul 2026 13:21:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hxc8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 13:21:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66BDLBFj50069844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Jul 2026 13:21:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66A320043;
	Sat, 11 Jul 2026 13:21:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E83D020040;
	Sat, 11 Jul 2026 13:21:09 +0000 (GMT)
Received: from [9.39.28.176] (unknown [9.39.28.176])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Jul 2026 13:21:09 +0000 (GMT)
Message-ID: <8e6869e6-4d7b-4cbe-93f4-d3ee242fea6a@linux.ibm.com>
Date: Sat, 11 Jul 2026 18:50:40 +0530
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
Subject: Re: [powerpc:fixes-test 10/12] include/linux/static_call.h:223:9:
 warning: data definition has no type or storage class
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <202607110847.u4TL0RJC-lkp@intel.com>
 <621a46b3-74a3-4a1f-b81f-f50ea18a541e@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <621a46b3-74a3-4a1f-b81f-f50ea18a541e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEzMCBTYWx0ZWRfXx6GfIUTh6iXd
 QGwn5xcm/UmCT2hDYNzV8k4aHxhAH2u5z02JAmFACE5eHwvyITSnawZDPv2ivaHg6W44UJd1EPi
 bznFR/Jzs1mg/W9o4gv+iV5n0+vK3RuIEOGFsRb1YsDAXFBOHKPulToeW6faVTABvbTb3BnLNUe
 xhNSWMMiLGkL7rFf41dhUXVC2L/4XJIpbQSdQJCWZLHg7W3cQ3aB5q9o9dSiuIGkndQ9kmFVTrg
 hOneOSOLlkwNtXHKO5hcgvdGE+CrQdUD3fKLAEVGzlsFfFLQW/w4u+RKRdJWS9JYrMqFwFYuA2U
 zAJoFiPAkVfcdQzP2dalxJelT/+oCOVmApI7r1rFCjUTKgTX3QxEzXP6ChK0NAvsudgYYNCcY4/
 +4FcuAUEqvrvCCyVCLrJdK/CC3cIegXPNYdE07Hl46+x50fb1ASu5wcM95iQWKillSQUllVbQRa
 vgSZNbNGPrgkLkB8ECA==
X-Proofpoint-ORIG-GUID: V0otMKFZ1wVeNx_I_OVpQ3vuExixvjPp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEzMCBTYWx0ZWRfX+2oFb/gbwxps
 81XGxChyhfFTIp0Bsb0cdq81GFfiQBhQNHSDFktJ8mvGs84zvVreKJWva5jCDT3LZh7PMqUp0JF
 yiGiJMMuFSGeKJKgoJKM5hyctCsbM/o=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a52434b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=i3X5FwGiAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=yH6aI7yIYFAsTmX0VQgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: V0otMKFZ1wVeNx_I_OVpQ3vuExixvjPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110130

Hi Christophe,

On 7/11/26 1:10 PM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 11/07/2026 à 03:52, kernel test robot a écrit :
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/ 
>> linux.git fixes-test
>> head:   afc2830892a128a13a65f677271a0a48aeb61b5e
>> commit: 4747e17fe063720a30b1c0075bae3e8f8acd26f4 [10/12] powerpc/32: 
>> Use HAVE_PREEMPT_DYNAMIC_CALL instead of HAVE_PREEMPT_DYNAMIC_KEY
>> config: powerpc-randconfig-001-20260711 (https://download.01.org/0day- 
>> ci/archive/20260711/202607110847.u4TL0RJC-lkp@intel.com/config)
>> compiler: powerpc-linux-gcc (GCC) 11.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/ 
>> archive/20260711/202607110847.u4TL0RJC-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202607110847.u4TL0RJC- 
>> lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from include/linux/tracepoint.h:22,
>>                      from include/trace/syscall.h:5,
>>                      from include/linux/syscalls.h:95,
>>                      from include/linux/syscalls_api.h:1,
>>                      from kernel/sched/core.c:16:
>>>> include/linux/static_call.h:223:9: warning: data definition has no 
>>>> type or storage class
>>       223 |         ARCH_ADD_TRAMP_KEY(name)
> 
> Looks like powerpc is missing ARCH_ADD_TRAMP() macro, introduced by 
> commit 73f44fe19d35 ("static_call: Allow module use without exposing 
> static_call_key") for x86. I missed it when adding inline static calls 
> with commit f50b45626e05 ("powerpc/static_call: Implement inline static 
> calls").
> 
> I will have to fix that before we can activate HAVE_PREEMPT_DYNAMIC_CALL.
> 
> Christophe
> 

One more thing to note,

Below series would remove all the EXPORT_STATIC_CALL_TRAMP
instances in scheduler.
That series make sense given that none/voluntary can't be selected now.

https://lore.kernel.org/all/20260703133358.698078-1-mark.rutland@arm.com/

