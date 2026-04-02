Return-Path: <linuxppc-dev+bounces-19241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF50D6AB10
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 23:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmylr3BGmz2yVP;
	Fri, 03 Apr 2026 10:31:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775145829;
	cv=none; b=cBrfgH7JdWn9JhwqBS285JR11Ck7nhmxHGqnCytPPpeGcamcOHKoliHpFJUEg07VlxrGnCzwLZFA9ExH0a8Q6hYz6KpOG7PJjGv+tnk20SXcyWfn1WtnbzA3Ipf1njFSwNqfbPcsjs6dXbyQEG7hNwOql4ZuY9wtJl8mvN+Gzk/tTpHhByyZ7PyugOOvgcHVYsng4HXPqFeW73uibEZSCl29LRiuld8Hof0ZAPS1Z8CnwYPjrC5yPxiGeI9WM3eWT8Ax5cIsQiPnhqxhLMYJT4rPHzr5pzxXtslRHP0OC0oDT0q3Qr+uvPKkyYO1kCgE4y6osGSICie58l7/Gf8n8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775145829; c=relaxed/relaxed;
	bh=Y5KHWzNNVdjfo5yutPVu9X2EtDB1q4HXdRoq7gh/TLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXoG+PusYcFXJsfn+F7GeM0jGHnx+kUmgd/2CIIm935EQaRQ2+MpsjJN5xjKd4O9F1uD+1PNEYkwAeGyr4kP1yj4uJvVi0mflFyeyusm3aWlXJrY5SJFnRIJeE2hVAGUxrgbKuYKVk2uP1Ic4wfBRSWCTPpllTQ8PwRq+iUps7YYD0KSifWse5+l9W/cEKGUpvEYixnp+UaQmkzT2cBRjYLq4r8nnqRhrQOqfZPLJNKCbgxNT8IaEj8ZCICetGSSx0wKKYceWX+fua1BFGyCZlQfn7+0TUAxnDRxIsL5bzYpuXuqs5vf4CCaH7MpYpyCbC/+iE8PwqakCNOJ6S4Vuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fPkDpKLW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fPkDpKLW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmmqm2NzKz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 03:03:47 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6329HUPA3113759;
	Thu, 2 Apr 2026 16:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y5KHWz
	NNVdjfo5yutPVu9X2EtDB1q4HXdRoq7gh/TLU=; b=fPkDpKLWjvDBupgtFU0rWx
	mnQuVcUyy+GyexqJMHrbvA9I3fsjrTUTDKYR6CZDwQzQHa1jwEGSe2ITDxGzPEva
	wClkDaDJNhsyWVSHO0DrIsLt+zQDhhIV+316pnI4wv8Bra8NCli8e6Ro7Vm2WV1t
	NqdMgZFdV01e5umBOV90zIb5IjNydjf/gD9VDJQa3WuywCxSI47fffG001Mp43Jb
	nRrQeti9NQR7GzGNIUxQeTS3WoL6FDISbsFYvIxReaYyc6WwjUi3HI8ZygDMBEvQ
	W55ExhlZLaMtIQX6BSwRY1ENfNF1JudXx7NV/AzUqjkXgEDfGa2ApfADFLHcWoCg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnwg98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 16:03:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632BEjBv013919;
	Thu, 2 Apr 2026 16:03:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttktkmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 16:03:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632G3b9H17367754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 16:03:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F135805E;
	Thu,  2 Apr 2026 16:03:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81F45805C;
	Thu,  2 Apr 2026 16:03:34 +0000 (GMT)
Received: from [9.123.2.252] (unknown [9.123.2.252])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Apr 2026 16:03:34 +0000 (GMT)
Message-ID: <68e9ca6a-c53b-4f15-85b3-7ae9639f9528@linux.ibm.com>
Date: Thu, 2 Apr 2026 21:33:30 +0530
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
Subject: Re: [PATCH v4] char/nvram: Remove redundant nvram_mutex
To: linux-kernel@vger.kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, ritesh.list@gmail.com, arnd@arndb.de,
        Christophe Leroy <chleroy@kernel.org>
References: <20260330103530.6873-1-venkat88@linux.ibm.com>
Content-Language: en-US
From: Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>
In-Reply-To: <20260330103530.6873-1-venkat88@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EE_WTIvePXvXV0R-X_Ii85cZQA63lFue
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ce935c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=XyCmtHQiREEm-KVZo3UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE0MiBTYWx0ZWRfX8gsYTM+8UAcv
 f0/wueSUmdQ1N6/9gzMtRyQDK60mw8O2RMeDlpWhiemm2lJY7x2gIpl/ri9+dZ3v84Ysn56pitF
 k+GKq5CGtvM00RWH/iNqybcFWrLZI1u4bwN/WrWHcbkaPpMGEkc3OqHhYHMkf5p/TZ1FhHWeYLq
 e1mXcGsTM915SGsCHYfH6HbGF11xO29QllhLInGG3s4RUa6lqF6c3t9FME4zhetDlzUprXBN6pe
 U38Q6pPT539+9m/b0KCU38cLO2ZhLCrUKh9/7HrzKTBZ1+YxqphgGg9P8E8xseqsJkm0T4kiiO5
 i69QJbVonnfLEy7Axt3WuC91pxAQPo5cSElKn84pLdeq55oj2qbZ3fzb1rYtRJow79gvSlptVUO
 EYnP/ji7p8cGaMqZVeBc7tjXzHOouehx8SygwQzeo7JzXuFqImJuIccVsW4VN0wc8O53aIFzh9w
 4GiJjpYNJJCoX8mxyuQ==
X-Proofpoint-ORIG-GUID: Dg1k1KckGNmFoIGhYUd_YRKeJOefvVvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020142


On 30/03/26 4:05 pm, Venkat Rao Bagalkote wrote:
> The global nvram_mutex in drivers/char/nvram.c is redundant and unused,
> and this triggers compiler warnings on some configurations.
>
> All platform-specific nvram operations already provide their own internal
> synchronization, meaning the wrapper-level mutex does not provide any
> additional safety.
>
> Remove the nvram_mutex definition along with all remaining lock/unlock
> users across PPC32, x86, and m68k code paths, and rely entirely on the
> per-architecture nvram implementations for locking.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
Without Fix
===============
make -j 33 -s && make modules_install && make install
In file included from ./include/linux/seqlock.h:20,
                  from ./include/linux/mmzone.h:17,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/umh.h:4,
                  from ./include/linux/kmod.h:9,
                  from ./include/linux/module.h:18,
                  from drivers/char/nvram.c:34:
drivers/char/nvram.c:56:21: warning: 'nvram_mutex' defined but not used 
[-Wunused-variable]
    56 | static DEFINE_MUTEX(nvram_mutex);
       |                     ^~~~~~~~~~~
./include/linux/mutex.h:87:22: note: in definition of macro 'DEFINE_MUTEX'
    87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
       |                      ^~~~~~~~~




With this patch issue is fixed


Please add below tag

yeswanth <yeswanth@linux.ibm.com>


Thanks,

Yeswanth Krishna

> v4:
>    - Remove all remaining nvram_mutex call sites, completing the mutex removal
>
> v3:
>    - Removed global nvram_mutex definition
>
>   drivers/char/nvram.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
> index 9eff426a9286..e89cc1f1c89e 100644
> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -53,7 +53,6 @@
>   #include <asm/nvram.h>
>   #endif
>   
> -static DEFINE_MUTEX(nvram_mutex);
>   static DEFINE_SPINLOCK(nvram_state_lock);
>   static int nvram_open_cnt;	/* #times opened */
>   static int nvram_open_mode;	/* special open modes */
> @@ -310,11 +309,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   #ifdef CONFIG_PPC32
>   	case IOC_NVRAM_SYNC:
> -		if (ppc_md.nvram_sync != NULL) {
> -			mutex_lock(&nvram_mutex);
> +		if (ppc_md.nvram_sync)
>   			ppc_md.nvram_sync();
> -			mutex_unlock(&nvram_mutex);
> -		}
>   		ret = 0;
>   		break;
>   #endif
> @@ -324,11 +320,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>   		if (!capable(CAP_SYS_ADMIN))
>   			return -EACCES;
>   
> -		if (arch_nvram_ops.initialize != NULL) {
> -			mutex_lock(&nvram_mutex);
> +		if (arch_nvram_ops.initialize)
>   			ret = arch_nvram_ops.initialize();
> -			mutex_unlock(&nvram_mutex);
> -		}
>   		break;
>   	case NVRAM_SETCKS:
>   		/* just set checksum, contents unchanged (maybe useful after
> @@ -336,11 +329,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>   		if (!capable(CAP_SYS_ADMIN))
>   			return -EACCES;
>   
> -		if (arch_nvram_ops.set_checksum != NULL) {
> -			mutex_lock(&nvram_mutex);
> +		if (arch_nvram_ops.set_checksum)
>   			ret = arch_nvram_ops.set_checksum();
> -			mutex_unlock(&nvram_mutex);
> -		}
>   		break;
>   #endif /* CONFIG_X86 || CONFIG_M68K */
>   	}

