Return-Path: <linuxppc-dev+bounces-19213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BA1D39410
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 10:58:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmf3m3h9hz2ySk;
	Thu, 02 Apr 2026 21:58:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775127524;
	cv=none; b=BLaZ22DtdqHYWktvumPr9rQhRCm4wNaIaOj+yam8lTFreMhNkeuRKxLRtTUEqq3BC8wzEyjAMH8LdreZI/sfVSWWWI0NphGl3iMw/u1nz7olMJDZpiuVFr2vF62fvHewOYa3tpiLN6FdpIvfLOa7uErHlKf6qyLqSumFKaWMy4tzQn7Wq/aVS6CEO7xk/BWxpa5hn8fcKI8HQhDWUdj9ystFzKkX5rPGSkewtdbFNCCpmGfX9YUFMkMn+w8hy873UBYH5icvV4/85QGkXGTolMDu3V2cw2jZr1uEJq8nG047LI1uHbzzHl8D7Zk7x0o5fZhjUi9gswd3/LPlSs1Cww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775127524; c=relaxed/relaxed;
	bh=0gFINy0J7hWuSvPyF4Me4RwxZxrtep5gKamQFyCNyNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QNm4fEsV/c3kvDUn6v818Cg26udtTqZRNqUNve+k9w2dXrqSWQwnZBIs5tyuNyCP+odvqoEKd5orwoVm7z/ZDxoFsK6L8ivtKJ4549q2ELF8zsoK9Sytxoe8cJKlgq5kxu2E5P5E9HJXPKu2BYZBLn8+O/q/FvkuuHOwK4vZVBihakh8oxg5e1f8T/Y4pB078nq8si/dE0L/hj1D6tVW5bNeLNRO5coVN9SCm/07jUordZ13DqWgwcgtBYiI4XK5Bm78kpdG43zOPblbQPQ2fyYvFIM2F9sLOQoRMDduBESS/reX7QJnyqABj07uvsc2cNL2ZOonyLP9eY/Q9cOlFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ojGOrxnC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ojGOrxnC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmf3l4hynz2xls
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 21:58:43 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632AtPbk3747399;
	Thu, 2 Apr 2026 10:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0gFINy
	0J7hWuSvPyF4Me4RwxZxrtep5gKamQFyCNyNA=; b=ojGOrxnCUvdzydYHvSVTnA
	aCREMJ1+dHb6lGYgjcl+9JLNDbp6kXiIk3LVupebs8lBF9FbGRzard4JbrcKnIEa
	X8QYs6M6pLmM8eru24rmv3oIwoMOpfSwd4tTEYkis9zKhhWAx/PePPRgmx2HA3aQ
	0OkV3SKLULF74dQ0KXQ9phYk9MZX19fLFD6phVwN/dWFKH2RFT8y0ogAydf2Xqsj
	ilWshU4BzEGaBjitQBz5UIOWHA7brAkhA0QBpx9cw7AXF63RHml6nNzqfuckqgKD
	I36vdi8CYXhm0j5wlLdjPb47elLDBuh2SB6F8M8Bbw8ZeZKQAeY0cWMWfGgcdoyQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msbg4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:58:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6325kFcn022227;
	Thu, 2 Apr 2026 10:58:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan9prq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 10:58:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632Aw6Iw45023654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:58:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3140520043;
	Thu,  2 Apr 2026 10:58:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8D1220040;
	Thu,  2 Apr 2026 10:57:52 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 10:57:52 +0000 (GMT)
Message-ID: <cd9fc3a0-701a-45f9-a218-86a846b091fc@linux.ibm.com>
Date: Thu, 2 Apr 2026 16:27:51 +0530
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
Subject: Re: [PATCH v12 02/15] powerpc/crash: Fix possible memory leak in
 update_crash_elfcorehdr()
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
        peterz@infradead.org, pawan.kumar.gupta@linux.intel.com,
        feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
        kees@kernel.org, elver@google.com, paulmck@kernel.org,
        lirongqing@baidu.com, rppt@kernel.org, leitao@debian.org,
        ardb@kernel.org, jbohac@suse.cz, cfsworks@gmail.com,
        tangyouling@kylinos.cn, ritesh.list@gmail.com, hbathini@linux.ibm.com,
        eajames@linux.ibm.com, guoren@kernel.org, songshuaishuai@tinylab.org,
        kevin.brodsky@arm.com, vishal.moola@gmail.com,
        junhui.liu@pigmoral.tech, coxu@redhat.com, fuqiang.wang@easystack.cn,
        liaoyuanhong@vivo.com, takahiro.akashi@linaro.org, james.morse@arm.com,
        lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        kexec@lists.infradead.org
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
 <20260402072701.628293-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260402072701.628293-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ce4bc4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=VlouDxB3MAwdfIDnmSwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX7sTiPpQy79zU
 K27F0Aadqv20eVmWi70LMSBPyFOePevJ8HXyavRnK2TMzHBaqSwuLuxWghuZlrQko5p05QNG2B+
 9Bgt6FzwoOQe968GS2CqUCWPF85d/PVlPRIHZxewHdS/5BZRUaIOvRMExp1EA0wnq/FfmfkRbml
 xUoUXHVAC39mqNXXBSfHbajz0Jy/x3ZUV/ETZpslbrsNw6IuxYsEP9fksyG6DmoBcTvr0vzUs7p
 +NMUSXiYvqxVsqVr2xYwpkjuI4M8zrAJ9QmTnvurotV7fIoCBsSulbmEh6HFEQfxV+LhGIu+pD3
 ZkhK78O/fbw0C/N0oaillpJX3t5VHm7NQrh0Rt1lDmpLs33W+LZxzNIlnrJzPTtWD6qTBPjbzCv
 THCMfLanh5h1/u6vlboXEIhI/aKd0Ic+FIzYIGcrqQgvJfN9B4u08rwVs/g8A7mVn8Dgt16cloJ
 0Db6BgmrWybcSycnenw==
X-Proofpoint-GUID: y-dDzylxSChSlhSY3DLcHWQcfmdGadgb
X-Proofpoint-ORIG-GUID: qB0ckh-l6XGO78PdLdPfSeeapsEZWdAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097



On 02/04/26 12:56, Jinjie Ruan wrote:
> In get_crash_memory_ranges(), if crash_exclude_mem_range() failed
> after realloc_mem_ranges() has successfully allocated the cmem
> memory, it just returns an error but leaves cmem pointing to
> the allocated memory, nor is it freed in the caller
> update_crash_elfcorehdr(), which cause a memory leak, goto out
> to free the cmem.
>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 849599b702ef ("powerpc/crash: add crash memory hotplug support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/powerpc/kexec/crash.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index a325c1c02f96..1d12cef8e1e0 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -440,7 +440,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
>   	ret = get_crash_memory_ranges(&cmem);
>   	if (ret) {
>   		pr_err("Failed to get crash mem range\n");
> -		return;
> +		goto out;
>   	}
>   
>   	/*
Thanks for fixing this Jinjie.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

