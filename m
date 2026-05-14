Return-Path: <linuxppc-dev+bounces-20932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BB5CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 03:57:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGGkR5Tbyz2xlQ;
	Thu, 14 May 2026 13:57:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778731055;
	cv=none; b=QHKslEy7huLkp1ig4JkkVATK2m7jpuAyKHn2JT2SUyPmhSvCD+Er4CH3e3Bgb0EMP7IIfD8IQ0VEne4mBkQzI2cD4wk0fGaklKUV58+2C7p+YLY7aLaCVcbht+v7AauVAS/ovSVe7Nis7NqCD8jvP/sAq9SAqkmR76izlFfuk2aKYaS4GBtrybogwMg4Mc7iWBwuONSKU+6Xf4FjmRgiv0TDMibihfCSjvkcnikOCVgaYWUXDFumuuisnK2xqPAhSAE2FI4eq8bQpasBsuwjtidZSexIxgHl68y4Zjebrhm1i6eg+ZUNwPnmgfDYgJC2G5v3v7VwPEUHp8QVH3WbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778731055; c=relaxed/relaxed;
	bh=NkZPuusqbBifLgBp7OKn0Hy38J6c7hQsR7qHZZ8b8/M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i+VYEp9kRiaiNoLdsHrbnz/7HWFjURWapLlRCoSE8QTXTJyYkcN2TGBsnEaXqWc9BrkBdA0SpgUMpbShz0dKymE3FeXwB5ptCSxgDUoowHltsA+/ispJYX8C1xJv1MxmTQ7idh/W9S9wVRJ1rLWS2OekiXs9hlId8mQDArPdCB5eeyeE7vay91Xp4Gya3yOkryaPQzY/WflLOq6lqp2xuftZrlIfzLWe93JC305Olg44RIqIUKCR/qsCJFB98GAVkLp22JpQrK+eBlHNN8MKGj2EXuGxUktx5QNagU8WeJQP/UVrPagqHQWfctliGfyz0iKfq70TNkTu8HnlL7Jqyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MYuqrcYb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MYuqrcYb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGGkQ4jSRz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 13:57:34 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DF8mjX3179816;
	Thu, 14 May 2026 03:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NkZPuu
	sqbBifLgBp7OKn0Hy38J6c7hQsR7qHZZ8b8/M=; b=MYuqrcYbiHnG3FRuucMaqR
	oVwIKpP1FAbaMVAr51bWxk9ZvEtMS+9hOdCQKsyf9SlYSE/OgfFSGJ/DOlva/ch0
	S53JI5+hfu0Y6iEpc4MD2h2ib5EbmCcIQZNIXyUI181jxmLhmqvEQITVhPqUysvc
	shDhGGT9FJwusciMwCpC2Xxk9Y+wMzdGnsqPc0JjEpKDBuoJVhXMXQFwL7GZ3qLe
	9i2OAswjTq5JUdGr0YBlg68omXiacAj2lBD46WEEAWa5BSMfLhafxB/pILM27l5k
	u7kO9CUOXBSylAaWeyleZIKv/1rBw5W7Gp0GgjIv1kylSBghuSlnOY1+I3xmx6QA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6t87m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 03:57:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64E3sZlI020232;
	Thu, 14 May 2026 03:57:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjrvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 03:57:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64E3vOPu19595926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 03:57:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE6F5805F;
	Thu, 14 May 2026 03:57:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 182B858059;
	Thu, 14 May 2026 03:57:21 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.247.73])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 May 2026 03:57:20 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v5] char/nvram: Remove redundant nvram_mutex
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260428061540.73668-1-venkat88@linux.ibm.com>
Date: Thu, 14 May 2026 09:27:07 +0530
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC8BDC39-4627-4532-B6FB-C4B88F4DF80E@linux.ibm.com>
References: <20260428061540.73668-1-venkat88@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a054827 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=kHXqOBKBtoXf3GAFd-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -82wwgmnGTBBqlqI576Rb0isCnFyDLa3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzMiBTYWx0ZWRfX0QVPaPmgsQ6d
 nqZvBgQdMVAeZi6BOexvBTA4kHAT3k8dyYQtVK8/M8wGx4P3+/wULXDNgXi3gRaHwI5x+J+9UBQ
 IzGHrf7RfcgvljcIUQDGuP+uIa+Fls5GJlAW0MS6JQHHggZj0kN3pSn3XOpSWjUdBva34Ba1Ci6
 eIqY68sZp9W8OHh4VlxWOsgPyfIc77eNlmmfltR58F7avCpUWQaI81i8LMZ8KtwrzAlfELV2tAa
 3Q85Fp6Rpidk87hfd8oHT3KWWmhetQjPKgM6s2embqXyqmPg+K7ky9uemrLI2qD9raMVGHDau8F
 Cj6WgF1s6+d9btaSB4SBtzXilOP5D4KuN7PhVQ4In7kr8hk1IxVpzbNNx2ixzAyF2GMQb35ZZzG
 VMrwxLzjsUv99iX0YsM1/4cgtzT1W7q4dD4yS2yax4N8sG03RzR17T9DOVFR3TKn4DH5pwbvlyY
 zgoefAR9F4SJMvYGIOg==
X-Proofpoint-ORIG-GUID: VaNAjdiS9LV52jR_PqLzJRjnRjUCyJPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140032


Hi,

Gentle ping on this patch.

This removes the unused global nvram_mutex and relies on the
existing per-architecture synchronization, as suggested earlier.

I=E2=80=99ve re-tested the change, and everything continues to work as =
expected.
No issues observed in validation.

Please let me know if any further changes are needed.

Thanks,
Venkat


> On 28 Apr 2026, at 11:45=E2=80=AFAM, Venkat Rao Bagalkote =
<venkat88@linux.ibm.com> wrote:
>=20
> The global nvram_mutex in drivers/char/nvram.c is redundant and =
unused,
> and this triggers compiler warnings on some configurations.
>=20
> All platform-specific nvram operations already provide their own =
internal
> synchronization, meaning the wrapper-level mutex does not provide any
> additional safety.
>=20
> Remove the nvram_mutex definition along with all remaining lock/unlock
> users across PPC32, x86, and m68k code paths, and rely entirely on the
> per-architecture nvram implementations for locking.
>=20
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Tellakula Yeswanth Krishna <yeswanth@linux.ibm.com>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
> Changes since v4:
> - No code changes
> - Resent after v7.1-rc1 as suggested by Arnd Bergmann
>=20
> drivers/char/nvram.c | 16 +++-------------
> 1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
> index 9eff426a9286..e89cc1f1c89e 100644
> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -53,7 +53,6 @@
> #include <asm/nvram.h>
> #endif
>=20
> -static DEFINE_MUTEX(nvram_mutex);
> static DEFINE_SPINLOCK(nvram_state_lock);
> static int nvram_open_cnt; /* #times opened */
> static int nvram_open_mode; /* special open modes */
> @@ -310,11 +309,8 @@ static long nvram_misc_ioctl(struct file *file, =
unsigned int cmd,
> break;
> #ifdef CONFIG_PPC32
> case IOC_NVRAM_SYNC:
> - if (ppc_md.nvram_sync !=3D NULL) {
> - mutex_lock(&nvram_mutex);
> + if (ppc_md.nvram_sync)
> ppc_md.nvram_sync();
> - mutex_unlock(&nvram_mutex);
> - }
> ret =3D 0;
> break;
> #endif
> @@ -324,11 +320,8 @@ static long nvram_misc_ioctl(struct file *file, =
unsigned int cmd,
> if (!capable(CAP_SYS_ADMIN))
> return -EACCES;
>=20
> - if (arch_nvram_ops.initialize !=3D NULL) {
> - mutex_lock(&nvram_mutex);
> + if (arch_nvram_ops.initialize)
> ret =3D arch_nvram_ops.initialize();
> - mutex_unlock(&nvram_mutex);
> - }
> break;
> case NVRAM_SETCKS:
> /* just set checksum, contents unchanged (maybe useful after
> @@ -336,11 +329,8 @@ static long nvram_misc_ioctl(struct file *file, =
unsigned int cmd,
> if (!capable(CAP_SYS_ADMIN))
> return -EACCES;
>=20
> - if (arch_nvram_ops.set_checksum !=3D NULL) {
> - mutex_lock(&nvram_mutex);
> + if (arch_nvram_ops.set_checksum)
> ret =3D arch_nvram_ops.set_checksum();
> - mutex_unlock(&nvram_mutex);
> - }
> break;
> #endif /* CONFIG_X86 || CONFIG_M68K */
> }
> --=20
> 2.45.2
>=20


