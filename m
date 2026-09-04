Return-Path: <linuxppc-dev+bounces-26518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3DDC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:04:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmBB60zHz2xpn;
	Fri, 04 Sep 2026 16:04:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788501842;
	cv=none; b=VLrNnQDkItM/nE03qixz47jemKIaVczAfi0ARsvXtVn5KkIwc6Qsu558Fwb08G8PefgHtAQ3yisCVEo9QaqwzrkzdVAYfaOKDewg8eOthWMU2d9irNkj83T7Wl8npK6ZNVV/U0EORmoubyVh41rGZaQ670Fyzi1freXzB3GjVectw31m1arH4t1EztxquIP3lzGWiMGlx2VfOzKZBeNi+nv8wMWquesPyk2TV9FwfjYdHX3DCLCihDpr9BCO/hHGMeQg43Krwyozw24ZAg50Ve1tywBl/wCtQgRvB1JIXBj5DzYuRnlWUCOkiVE/uzXp33r1+SRIt5VCHmXjAAmiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788501842; c=relaxed/relaxed;
	bh=Ye6cOX802ZzZri16Xvh5i7MdcxBGeDBPODGuw8HpoKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RYlQeaOuCqO3/Ly9ccgwrB6N+YZplcLQqysQOaRxT8/HilXu6xs93gD9UesXOHhSE11vBACsp01m0o3Rtz+zr122kUSKadl9NuCH5SSheS0ySM2kc7qXogyWggvko/IQcFCFvkr+d4Ej3dvhIQbW3v+pzUC/3P+mQaXG2+Sb7YyMyP+3FS6bijO1cVDMq+LXA+lh2SC4uynjpAcChlgB60dDxW4ggVCcaqh4kHIr5VAHI5qp/wZFWDPoDRnUm7vIbYgAyUhJWZzaFgaxUB03Oy+TNrTi0+CBrNqqTjaJVJue+5b1j03N6lzBY2BtXQiwYKFKnoVeiwO+6VUS/+x5DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gFQZLLY9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gFQZLLY9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmB94QFRz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:04:01 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68431Q5l571234;
	Fri, 4 Sep 2026 06:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ye6cOX
	802ZzZri16Xvh5i7MdcxBGeDBPODGuw8HpoKs=; b=gFQZLLY9f49F3kv31svbgK
	SD/4wgJLCVRi1xPuLmduqLn/MoNt0X1ddKZExxHFODklJQNQIS1XIcKa5zkC8Mjv
	Voow1EtibeP7O9yy/A8heMIPhXC2oc1V2mpgQdwFms8N/Ohwx8Jzb+MXa6Anllv6
	CpgjZygZ59/JY6gVs0tj7/cvR/IOUEEAl8gCsEdUlYDroVd8cyKVof5WojY08MpC
	qU6To4bphY19n3OrCjm1cAxO06uKX2EoT42tPyfzKiVY0tI6xFLp6IsPFit/DZ0D
	ufu6bq5odiAINpyeCdWf8KheE7BEtf8N0wnaNyelXBRGUeB5eZYFjY6Al9ZNs9Nw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq5592hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:03:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uJZ6015890;
	Fri, 4 Sep 2026 06:03:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjauucb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:03:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68463fc950200848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:03:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D23792004D;
	Fri,  4 Sep 2026 06:03:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B5E20043;
	Fri,  4 Sep 2026 06:03:40 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.27.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:03:39 +0000 (GMT)
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
Subject: Re: [PATCH] powerpc/pseries/htmdump: Fix leak in htmdump_init_debugfs
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <anJDq-JckR6j-6EJ@michalis-linux>
Date: Fri, 4 Sep 2026 11:33:27 +0530
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, chleroy@kernel.org,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8815BE1-1914-443C-A3D7-F1A85AFFB181@linux.ibm.com>
References: <anJDq-JckR6j-6EJ@michalis-linux>
To: Michail Tatas <michail.tatas@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0OSBTYWx0ZWRfXw4pJtyjcH2Kd
 Kcc8UKmWsXAIHHtSgprzf1HA3cf392w77oOXX9jTo+CjJQqY2R44abqqTpQOcVJ4YtfLw05osX8
 x1wIgc3VB7/HP7QL45x78mbHHbxT62xfAaSH0GHuWfRtpM+7IVYvtiFofLzPV5W2roSByBsgW+t
 HAuymJEdvgMUYPpm+BU0+JNbl3YHGjjP9KllFGA6CTwaAx2e977XHJMULh71uUXwg0Kz4ApsgtY
 tvPeCag8NSeT0OKRezNVv/e4yUWUsOJ6r94K0ultA7VHkLVG6jvjt6Gb9mTXTeYxITk9szK8FdM
 39GQLp96L+t5oVI5kbhIsqx6KuLwgWzjdQfu6fMfPpe1N6FrLtG/C7dDMR/NDnjwmr2+1i1K+I2
 buF7WdE9hG5b1KSeDT0A8xqF5k/VJ1RvoC3x7WEvVm1Hrm5m7yoq22Ke2daAM5jAT9nBG0v9HuK
 eG/PlT3DUwo+HPlRzNA==
X-Proofpoint-ORIG-GUID: N_ZEmS4srIsW-tgHny2FYU9l7AgYglBQ
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9a5f41 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=aGPZjXX-TVm_6tD4aQsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Z_YaLQNdQrr4p4xtNjJqptg6ugTMFM8K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0OSBTYWx0ZWRfXxzvIhZha/g77
 QcA+/Nhfp436HehuVA9Dw1boz0i1dFq7K4uCDXU4Q8XjDTpSmqK2PgOCS7iYzxU8SXhDcYCMR/G
 bTITqmf9Ba4hFuHm7cSs6BiUFm0eTi8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040049



> On 5 Aug 2026, at 1:25=E2=80=AFAM, Michail Tatas =
<michail.tatas@gmail.com> wrote:
>=20
> If any allocation fails during init all previous allocations are
> leaked and the debugfs directory is left.
> Fix by freeing the allocations that have already happened and also
> remove the directory that has been created.
>=20

Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks
Athira
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
> arch/powerpc/platforms/pseries/htmdump.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/htmdump.c =
b/arch/powerpc/platforms/pseries/htmdump.c
> index 489a80e87082..f33941b80ada 100644
> --- a/arch/powerpc/platforms/pseries/htmdump.c
> +++ b/arch/powerpc/platforms/pseries/htmdump.c
> @@ -527,28 +527,28 @@ static int htmdump_init_debugfs(void)
> htm_status_buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> if (!htm_status_buf) {
> pr_err("Failed to allocate htmstatus buf\n");
> - return -ENOMEM;
> + goto htm_status_buf_err;
> }
>=20
> /* Debugfs interface file to present System Processor Configuration */
> htm_info_buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> if (!htm_info_buf) {
> pr_err("Failed to allocate htm info buf\n");
> - return -ENOMEM;
> + goto htm_info_buf_err;
> }
>=20
> /* Debugfs interface file to present HTM capabilities */
> htm_caps_buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> if (!htm_caps_buf) {
> pr_err("Failed to allocate htm caps buf\n");
> - return -ENOMEM;
> + goto htm_caps_buf_err;
> }
>=20
> /* Memory to present HTM system memory configuration */
> htm_mem_buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> if (!htm_mem_buf) {
> pr_err("Failed to allocate htm mem buf\n");
> - return -ENOMEM;
> + goto htm_mem_buf_err;
> }
>=20
> debugfs_create_file("htmstatus", 0400, htmdump_debugfs_dir, =
htm_status_buf, &htmstatus_fops);
> @@ -557,6 +557,17 @@ static int htmdump_init_debugfs(void)
> debugfs_create_file("htmsystem_mem", 0400, htmdump_debugfs_dir, =
htm_mem_buf, &htmsystem_mem_fops);
>=20
> return 0;
> +
> +htm_mem_buf_err:
> + kfree(htm_caps_buf);
> +htm_caps_buf_err:
> + kfree(htm_info_buf);
> +htm_info_buf_err:
> + kfree(htm_status_buf);
> +htm_status_buf_err:
> + debugfs_remove_recursive(htmdump_debugfs_dir);
> + kfree(htm_buf);
> + return -ENOMEM;
> }
>=20
> static int __init htmdump_init(void)
> --=20
> 2.43.0
>=20


