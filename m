Return-Path: <linuxppc-dev+bounces-22657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48416CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 19:27:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfKrX2rSWz3btJ;
	Tue, 16 Jun 2026 05:27:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781551644;
	cv=none; b=aXNKSHlEwrkuC+PtW0OCTuvPAuce8buIbOC+zEMEdKirV0TyIljW8abyki3es/x/c/9HJ5x6VixQZMh8n1LrNOH2M+25maHf4SC1keOJjJAvY9+WoVgUAusuxFZ1ZiY+sl0vqqnaum+1j3u8VvXkG6I3ZUGuSYAlJ23UzkWNXHC+Pc+Yay9cZ/czRRiasnu1dR6+KB5hm2JEcv4FsuMW/7eHvV7iokSUeFMqmPok9NFP8E8CaSDo9FQuiwoUeuciS4d6JeTvxmmjbzshF75pBE5pZEiPso5zkDG1JaYYOsoR+BCU21QTdTK1T/TJA4DudxUezroHjQW0R7k7DK+sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781551644; c=relaxed/relaxed;
	bh=EE1xkBH2P1ERRsk72Q0xnAE5cD/XOzLD/miuPzJnCDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+nosnNMb6LXTK28SeLNyWRVu5H+AYZNiPBnzC/CEO4GW3EnQkBD+kemJFue4jevt98BR8Ni6YRikrzDvpgPwrqgR/wiPQqTDyuudB7eJB0oaymg8AEKFZe1DdtkwMo1GCD7ft8hQSOqcwYqGjMTCSONU0JzrGwXtcWs4dQopDRkqpxaXEBuGcTvWxnKlNqSaQAcZ4wor0K79w0JeclFaZX3PU0UqhKlTD6zkVVF54h//ZXd8PRBSx8j4D6o9ssvOBena7X7mtBAoXYO9GbemQzGdN83XsMtTXUOFOR7IUoMQg3379TJHoDfHEvDh2M78ad2slnjdq2m/YGl0jVTqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qApq/AK6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qApq/AK6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfKrV3z5Bz3bsy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 05:27:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJIohi3345169;
	Mon, 15 Jun 2026 19:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EE1xkB
	H2P1ERRsk72Q0xnAE5cD/XOzLD/miuPzJnCDE=; b=qApq/AK6zQf3FGq88AOX4h
	DhKOXnUyrHXrCZuZD9pD68V6GeeTEnFI9xlnJwguLsWFsx9ZjXDDowRirfC1d/Rt
	J5zGaek5FpnzMWI9wKqDkDKqnfEgUlJ3srZxrP8MO+FLnGl2oiQyar5iS4+Lfzjc
	ESc7+6DPSuP7LquQzuxZPzq7xjsp+cY3WdNR2+QzNqiaedK8eUzZlhBHcvrgjdSr
	CtwiKnUvAFPp3ksybJbTbTuJrfZqph2ZYks/s8dqoGPKL16yI4jAXhP8ummrBBAA
	pYTJ71oooMII1RvaT6p+gzCMvvpWnn+aFCW/b/4vGWtYXq2yJbBEa835+m4Df6/Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h82chu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 19:27:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FJJc2t030767;
	Mon, 15 Jun 2026 19:27:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg7uyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 19:27:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FJR5Di787234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 19:27:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 732A058055;
	Mon, 15 Jun 2026 19:27:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4BD58059;
	Mon, 15 Jun 2026 19:27:04 +0000 (GMT)
Received: from [9.61.95.246] (unknown [9.61.95.246])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 19:27:04 +0000 (GMT)
Message-ID: <55fd8413-34d6-4dda-8a65-1aefaa8585e6@linux.ibm.com>
Date: Mon, 15 Jun 2026 12:27:03 -0700
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
Subject: Re: [PATCH v2 4/7] ibmvfc: define asynchronous sub-queue
To: davemarq@linux.ibm.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
 <20260608-ibmvfc-fpin-support-v2-4-d41f540fba5c@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260608-ibmvfc-fpin-support-v2-4-d41f540fba5c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNCBTYWx0ZWRfX58KeYWOrkyNA
 kNYC+H+ZCHulPiQggCswIIBYGUkebEYSsXW4+nIlEr57S/KqzJXykOPGHdlcydF1QiZjjEx6EDK
 +Hbj3vFG1WFHUI6u2+VNt6vJBkBF/zY=
X-Proofpoint-ORIG-GUID: PDl5QFKKL4gsMVvQqm1R_zeS8oqclSSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNCBTYWx0ZWRfX9nPU2nS5PkYH
 DI+Psw/3ek0po7bK1yYCgMqO1HTSfPkVKdAWgF1ZWGAWzhnabw871KVJ/YfJpySiRDptzZHIhBR
 feoywxjiyD658FKGacgiM4RQMMnA+C14mY99BtlnIOfgLtlUa8hvoLA0QaiuTeny9WKp0CzbGeX
 OAnwJKMK0bFsfk4w9YJGTsnyB6vUtdNZuYP7izBtavXSUVEyVYJdEya7sXvRX228ueb5/rKUxYY
 zbmhR1U77CmgNJR7e1Gk+kdnAcW4R/ONdOUWeeCuIBSeEA/rhiHjFGPa7/6abRm7Nf+we1tzszZ
 osHSrGleiOz7mD5md1coBvUYxZO39MAFtlxJ1FpsOGV2nRQva065qyqXGtLUTcl55OjcP6/80JD
 nnGra7ZG4DT+2UrTsfs577oYNAM1jnSBMhSYxqKqKJIuw+/3YsooDS9ay6K8RUBMyUdtHGez83k
 TZrLVXDoGTfr72QBBgg==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a30520c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=0_Hg0MBJ2Sj-jJcl_T4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TTTaU4K14aRKthogn8fZfIzEukUShl4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150204

On 6/8/26 11:30 AM, Dave Marquardt via B4 Relay wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Adds the asynchronous sub-queue structure, modifies the existing
> channel setup structure, adds the asynchronous sub-queue to the
> channels structure, and adds flags needed to tell VIOS to use the
> sub-queue.
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
> index c996b36d335d..f026f30f98d3 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.h
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.h
> @@ -181,6 +181,8 @@ struct ibmvfc_npiv_login {
>  #define IBMVFC_CAN_HANDLE_FPIN		0x04
>  #define IBMVFC_CAN_USE_MAD_VERSION	0x08
>  #define IBMVFC_CAN_SEND_VF_WWPN		0x10
> +#define IBMVFC_YES_SCSI			0x40
> +#define IBMVFC_USE_ASYNC_SUBQ		0x100
>  #define IBMVFC_CAN_USE_NOOP_CMD		0x200
>  	__be64 node_name;
>  	struct srp_direct_buf async;
> @@ -229,6 +231,7 @@ struct ibmvfc_npiv_login_resp {
>  #define IBMVFC_HANDLE_VF_WWPN		0x40
>  #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
>  #define IBMVFC_SUPPORT_SCSI		0x200
> +#define IBMVFC_SUPPORT_ASYNC_SUBQ	0x800
>  #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
>  	__be32 max_cmds;
>  	__be32 scsi_id_sz;
> @@ -563,7 +566,7 @@ struct ibmvfc_channel_setup_mad {
>  	struct srp_direct_buf buffer;
>  } __packed __aligned(8);
>  
> -#define IBMVFC_MAX_CHANNELS	502
> +#define IBMVFC_MAX_CHANNELS	501
>  
>  struct ibmvfc_channel_setup {
>  	__be32 flags;
> @@ -578,6 +581,7 @@ struct ibmvfc_channel_setup {
>  	struct srp_direct_buf buffer;
>  	__be64 reserved2[5];
>  	__be64 channel_handles[IBMVFC_MAX_CHANNELS];
> +	__be64 asyncSubqHandle;

No camelCase please. Kernel style prefers snake_case. Something like
async_sub_crq_handle for consistency.

-Tyrel


