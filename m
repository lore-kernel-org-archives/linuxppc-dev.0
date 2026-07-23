Return-Path: <linuxppc-dev+bounces-24707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A02C4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:38:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FgC4fLmz2yVZ;
	Thu, 23 Jul 2026 12:38:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784774327;
	cv=none; b=kNq+kUUoQVJTuKurz8lJQbtZDypSCDJE+jShV24eiIOPJVjl/q7ytlUVqK79Tw2UzYPc4NLM5JVpQvwdSpZcqGxwy+9/nHvqW7OYmAJ7vfGJTyGeOKowAcr9eROxQ4i1gOJt14Ks6s1565wE5V1LK+dEGbw3HUlyEB+Fh0r04zeBtr9t93eAQK8A2/BAUC+Ph72+GnxXkfrBOnjcQZNuzQzJFvaXTFQ813JkUPiYG6Sk0XZ73vGWYeYY5oF7x9m6KVBB16RG3KkP+SPw7EFokoD2QIataKzJrPpYTiyFIDm/aFCdlHcGcQtcHWRN0kygLoozgTUlpn4u3BRTBPZHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784774327; c=relaxed/relaxed;
	bh=Us5bRphmngrDUYh6s9JPYR65iyLcVLgCHGDEnO73Yks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edh9nybD9IR2GW26JwVSmu7EPaQ1i7ksdrgObbCANeAtvD6KQ1QOgOsnSNUBNN9NRrqPGq4At3OB0VxMfc9r3nwc9QcGbr7m1PTpckiFRuRqo36bzP7wNO/8qM0CsJ9CnTirUekUKoM0iLFcigeNjE7cU2Qk39GN3nBlJQaPOSMrjXxnTVQuzxjSSZlR1cLiudgzO+3B513j6nUsLYxPBmpMgKX+NrJ7Fo5SURO/kUGoATww4Wja9UdcL2tMurmhnQWqxyK8UxnhEz9eBGeZEjnsdst01Mn2Q1LPW/QueUPHqCYr2MGzYZ7YE3UUjF1A8yff00KBq7NNC61cE/iuCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kXL39hoO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kXL39hoO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FgB4g7qz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:38:46 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0g4OE1521912;
	Thu, 23 Jul 2026 02:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Us5bRp
	hmngrDUYh6s9JPYR65iyLcVLgCHGDEnO73Yks=; b=kXL39hoOI7OKd45/KHXE7g
	r8D/w0LloR1JkJ3PDInYIZ6wfzBvdJM2DzhPrFaebPYalTFfz9bOSfA7ZDk/rWZv
	CFCriSQcoHWvInVTbo+2K6oJGTwpWIERaMUojCOqZ81xIOs0OKQghEfc3398f9HC
	s0JJjVP8TlYci2rwngDsHhSrzB0lJUAttGmSHIHdabjj+HVIS73Uqx5Cs1mX87yQ
	JINXTd8iBdjqjpj+hNCbW1RFQqM4mSK3bocdF7iYLBLGjF5jgfrZB0dz4OSTS0bi
	iStFhaLaLi2GBm0ZtyIwBYouN7AHGv69Ib9H7e3JhpAzF81/kjXVPCo9cGERKlNA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abndm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 02:37:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N2Yabn022994;
	Thu, 23 Jul 2026 02:37:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnaha5yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 02:37:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N2bAZY16384582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 02:37:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6943258056;
	Thu, 23 Jul 2026 02:37:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A2E58052;
	Thu, 23 Jul 2026 02:37:36 +0000 (GMT)
Received: from [9.123.5.176] (unknown [9.123.5.176])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 02:37:36 +0000 (GMT)
Message-ID: <a68d04e4-baa1-4a36-b118-59def0d52a49@linux.ibm.com>
Date: Thu, 23 Jul 2026 08:07:34 +0530
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
Subject: Re: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
To: "Dmitry V. Levin" <ldv@strace.io>,
        Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com,
        kees@kernel.org, luto@amacapital.net, wad@chromium.org,
        mchauras@linux.ibm.com, thuth@redhat.com, ruanjinjie@huawei.com,
        sshegde@linux.ibm.com, akpm@linux-foundation.org, charlie@rivosinc.com,
        deller@gmx.de, macro@orcam.me.uk, segher@kernel.crashing.org,
        peterz@infradead.org, bigeasy@linutronix.de, namcao@linutronix.de,
        tglx@linutronix.de, mark.barnett@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
 <20260123073916.956498-6-mkchauras@linux.ibm.com>
 <20260722070155.GA11808@strace.io>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260722070155.GA11808@strace.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAyMCBTYWx0ZWRfX2Hq/g4yybqGu
 wQzGMsme4gAzQN4UJnCs9Tq6s8ouUEVnOc627pRED6njT+30AO7x2C9XvdPSEU1XzG9We3f0mUG
 1+HlGYUE2LGWgbPYj7DqIHINOg5f84eOGbXvEzOMfX9NOzjp9jatGVJBMfUjYQZy9NiEG++l/Hh
 YP48Aj3erBH5uyyWv/ON0VlMbO8GIlziSGHyZd5Yx7hU4gnN1jtMO7k85f78slKo7by1phudddO
 BbE36//wBzWUI5ypTt1rbzh1xqmRxLjC/UGg5i6vuGkts9WIVM/9Bb7NisLV2d+gT5q2Uu2YuW4
 98m3r2MiZRP6H5rrIVIGxBhPZBrvyJv5FbR94Nm1jzMAlj0FsW2YFSwSz56TGNuDq7AElNCzj1o
 iAIyOTHdRgZdWOyEbEoAP04dICam2/8VCwnbnFRQzyYXnj7+n0AxrMuUjnIfACdO84FvEL8CXjQ
 AGwlqXGk/R5OI3I7atw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a617e7d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=qIVBIAJNVL5Tnlm7AV4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lDaye0mxTD91XvAu3S5x8TCSG4Ip6YYG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAyMCBTYWx0ZWRfX/d2omvyBS/te
 0clmY3eLICR2Iaw/SHqnlo9CauZK2jvmcdrBx65NgKxt1ANsnLFYRDhY0tSIZdqoPj7AWpua0ob
 L57vm2kyvp17jLPt/kdUJSyESzfKons=
X-Proofpoint-GUID: vouE8ss57iOTnrsdCdpkOawVldg4Xt3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230020


On 7/22/26 12:31 PM, Dmitry V. Levin wrote:
> On Fri, Jan 23, 2026 at 01:09:13PM +0530, Mukesh Kumar Chaurasiya wrote:
>> From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
>>
>> Add a new field `exit_flags` in the pt_regs structure. This field will hold
>> the flags set during interrupt or syscall execution that are required during
>> exit to user mode.
> Apparently, this change breaks PTRACE_GETREGS as the latter has no means
> to communicate the size of struct pt_regs being written to userspace.
We added the exit_flag at the end of the struct so that other element
offsets will not be affected with this change.
> As result, the kernel with this patch will write to userpsace 32 more
> bytes than before, and unless the userspace is re-compiled with the latest
> ptrace.h, 32 bytes of userspace memory after struct pt_regs will be
> overwritten.
We are looking at other options and thanks for reporting this
Maddy
>
> This issue was detected by strace test suite, specifically, the test that
> checks whether the actual number of bytes written by
> ptrace(PTRACE_GETREGS) matches sizeof(struct pt_regs), and that test failed
> with runtime version v7.1 and headers version v7.2-rc1.
>
>> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
>> index 01e630149d48..a393b7f2760a 100644
>> --- a/arch/powerpc/include/uapi/asm/ptrace.h
>> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
>> @@ -55,6 +55,8 @@ struct pt_regs
>>   	unsigned long dar;		/* Fault registers */
>>   	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
>>   	unsigned long result;		/* Result of a system call */
>> +	unsigned long exit_flags;	/* System call exit flags */
>> +	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
>>   };
>>   
>>   #endif /* __ASSEMBLER__ */

