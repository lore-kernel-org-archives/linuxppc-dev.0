Return-Path: <linuxppc-dev+bounces-22616-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1170CD98D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:40:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf28S2qR4z30gJ;
	Mon, 15 Jun 2026 17:40:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781509208;
	cv=none; b=ggPQADhj16LeEx5cUF6ZndRR0dDA1kdGLxhhm2OFtYblQE+YuqI/rcn7TzbOHVu6VhFRoWJOLlXyP9OKbDEXdXq5oOTLf8IiStcKQAK9zMzFXOJMT3d0wUP07IH9QJH7t1g/Xgm05WIT2IsI6BzSBTYLJH7BoJai21QO9clhC5yG8hvZc3C9X4PhWqudcWqtnKVQuAhHWImM/7zqF6OaeirNKqlMOful5mVXpx5t7uzBoRvG8otMCwY6PMPkKHaZMNamgmZfSWftg/s3eLhvxqKwrefPfG27ygi0N4fV9Hjbs3nnVWNiOE0Rrvxbie9lXwf780qLCjc0MShmzAi1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781509208; c=relaxed/relaxed;
	bh=FS9kIa6OUcuzSV0c68Lo6rSeNDkiovDeRrA91Kb1nxw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eBHhiI98xoBYpgSAaO8FzY2n3JLocYSnXQkC6ZUGLvgUqa46zE+chmDx5h0BaahPJhRgsxmUImZksseS0sYt4g0X9l0HfbIm6BPh3nFK1sOjlmBFqenM9mQhw6+Lum61xpw2+YxxXbNuEseCERN0zOvYyQtYth+fljMrxJUycp6BE7VtNAlS8NNxRDVmiDq2w7eE8LVNZHkevQnmjliPGe+Scpz9p1gbc/spYerKJQpFQN5NpaiJsI4y37F553T1KgH3UXotOPBN2lrLbbBwD9fQvHlDcRsPXmFk0SQXzIcWgCkeYyVYGqxGfZ0F6iCytwwYJa9XPz87ENk8W9uTtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DZAVRQ/x; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DZAVRQ/x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf28R2jHGz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 17:40:06 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6IkkX1565063;
	Mon, 15 Jun 2026 07:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FS9kIa
	6OUcuzSV0c68Lo6rSeNDkiovDeRrA91Kb1nxw=; b=DZAVRQ/x6L3gfAR8e9aEZP
	ZIU+NH9OzfIFY6gKGa+AsVcYyDzpw+EbWoimFLRAzM1pyydTEu0I9bu1Tv36w9+O
	HJY9kE6FwbiuHUqT8GpjyoUa0uA/c7SoOihQUCNITbY6jYqejNUIwyHo/JiOZcxq
	jzkXbx5pOqgm+3A8irXG1rbGqMQ4tEQOGqdvgEb7G05ebHKQ8ZEq3MF6IXrpuwSe
	Bsp+Dq8fZJitMAAam/QKgsq+kuJ0rIVfSOPTI1Uciv5NkDymaeqGePektLm6bWwZ
	csbF8e3negBcRxdowRnwpGte0Gnl14BQb64W8IKaQybLHBc1Dl7dzo+xDZXrrSGg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkycrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 07:39:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F7Yqtk016872;
	Mon, 15 Jun 2026 07:39:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvwn2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 07:39:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F7diRf55574814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 07:39:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A0B32004D;
	Mon, 15 Jun 2026 07:39:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324F420043;
	Mon, 15 Jun 2026 07:39:41 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.9.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 07:39:40 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 1/2] perf script powerpc: Update the hcall list with
 new hcalls
From: Shivani Nittor <shivani@linux.ibm.com>
In-Reply-To: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
Date: Mon, 15 Jun 2026 13:00:01 +0530
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0E7A32C-CC5B-41B5-87DE-150947DBA12C@linux.ibm.com>
References: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX30SjxwnGwI6S
 mpAtK5PPQe7fGy6APA2RECa7Djp4Y2Rm5SkPboA+tXV1EEHTc1phmGBqNhKDLYXlkbzMhbMQD/B
 560fN5L5PkX8VS/arwT4ynLV6XEzPfk=
X-Proofpoint-GUID: mG415jIiPaS93vcvfLf9Clk7rJoZAcPn
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2fac45 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=9AdMxfjQAAAA:20 a=Eu7ggDVoetdrdGGIGtIA:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX7Ui3ACUhewDA
 mMVyN4RAK3aY+5arinAB4VpK/6YGS9aMBFugPEEB9+yRVdDNvDJNCLFqDq0+3toxmv7BjvU1503
 rwnCnMthYDFrQM5VyEpQjoHHwWVhHA7MOU1pXBYk7PIc0+NlVkVd0AprAL8KRgzvnzZQteDkKVX
 6XV0VVguklugaogiiH6VqNZ3zSVmo4ZOPjGH4IN1kJizv6U03/VRzI1oJ1/IpSQoMh3U19leDBT
 LBLdzD+l3h9zcroDcoFQB1gObX1I8HbNqJuMp6zCniRiUwly+J9kVa+bEidCZxOhPF5H6LZ18fr
 ZtJhO8ZG1Wo5C650NSWp45NUGMOWyFzEXB3FCHpgA/0r9MAUUZ9pajsFArB99gx/cgUPTlkU3zt
 69qEgZsrBBWRBcmsYYCDY1HkaDBceo1d808gquq7WA1J8vW0Di8fhlVgzcpakmlgUprZpC7ZhCL
 9e8cU/NPGvuMR9eGiKA==
X-Proofpoint-ORIG-GUID: 85MvA3p4zkrPeh-pOY6UdhKEW_5OOKNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150075



> On 2 Jun 2026, at 17:26, Gautam Menghani <Gautam.Menghani@ibm.com> =
wrote:
>=20
> From: Gautam Menghani <gautam@linux.ibm.com>
>=20
> Update the hcall list with the newer hcalls in PPC.
>=20
> [1]: =
github.com/torvalds/linux/blob/master/arch/powerpc/include/asm/hvcall.h
>=20
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Add some of the missing hcalls. (Tejas)
> 2. Separate out the typo fix for H_DISABLE_AND_GET in another patch.
>=20

Changes looks fine to me. I have checked the names and hcall numbers in =
hvcall.h header file.

Reviewed-by: Shivani Nittor <shivani@linux.ibm.com>

> tools/perf/scripts/python/powerpc-hcalls.py | 89 +++++++++++++++++++++
> 1 file changed, 89 insertions(+)
>=20
> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py =
b/tools/perf/scripts/python/powerpc-hcalls.py
> index 8b78dc790adb..f897d6a5e051 100644
> --- a/tools/perf/scripts/python/powerpc-hcalls.py
> +++ b/tools/perf/scripts/python/powerpc-hcalls.py
> @@ -117,10 +117,12 @@ hcall_table =3D {
> 440: 'H_GET_HCA_INFO',
> 444: 'H_GET_PERF_COUNT',
> 448: 'H_MANAGE_TRACE',
> + 456: 'H_GET_CPU_CHARACTERISTICS',
> 468: 'H_FREE_LOGICAL_LAN_BUFFER',
> 472: 'H_POLL_PENDING',
> 484: 'H_QUERY_INT_STATE',
> 580: 'H_ILLAN_ATTRIBUTES',
> + 584: 'H_ADD_LOGICAL_LAN_BUFFERS',
> 592: 'H_MODIFY_HEA_QP',
> 596: 'H_QUERY_HEA_QP',
> 600: 'H_QUERY_HEA',
> @@ -135,11 +137,17 @@ hcall_table =3D {
> 644: 'H_ADD_CONN',
> 648: 'H_DEL_CONN',
> 664: 'H_JOIN',
> + 672: 'H_VASI_SIGNAL',
> 676: 'H_VASI_STATE',
> + 680: 'H_VIOCTL',
> 688: 'H_ENABLE_CRQ',
> 696: 'H_GET_EM_PARMS',
> 720: 'H_SET_MPP',
> 724: 'H_GET_MPP',
> + 732: 'H_REG_SUB_CRQ',
> + 736: 'H_FREE_SUB_CRQ',
> + 740: 'H_SEND_SUB_CRQ',
> + 744: 'H_SEND_SUB_CRQ_INDIRECT',
> 748: 'H_HOME_NODE_ASSOCIATIVITY',
> 756: 'H_BEST_ENERGY',
> 764: 'H_XIRR_X',
> @@ -147,7 +155,88 @@ hcall_table =3D {
> 772: 'H_COP',
> 788: 'H_GET_MPP_X',
> 796: 'H_SET_MODE',
> + 808: 'H_BLOCK_REMOVE',
> + 856: 'H_CLEAR_HPT',
> + 864: 'H_REQUEST_VMC',
> + 876: 'H_RESIZE_HPT_PREPARE',
> + 880: 'H_RESIZE_HPT_COMMIT',
> + 892: 'H_REGISTER_PROC_TBL',
> + 896: 'H_SIGNAL_SYS_RESET',
> + 904: 'H_ALLOCATE_VAS_WINDOW',
> + 908: 'H_MODIFY_VAS_WINDOW',
> + 912: 'H_DEALLOCATE_VAS_WINDOW',
> + 916: 'H_QUERY_VAS_WINDOW',
> + 920: 'H_QUERY_VAS_CAPABILITIES',
> + 924: 'H_QUERY_NX_CAPABILITIES',
> + 928: 'H_GET_NX_FAULT',
> + 936: 'H_INT_GET_SOURCE_INFO',
> + 940: 'H_INT_SET_SOURCE_CONFIG',
> + 944: 'H_INT_GET_SOURCE_CONFIG',
> + 948: 'H_INT_GET_QUEUE_INFO',
> + 952: 'H_INT_SET_QUEUE_CONFIG',
> + 956: 'H_INT_GET_QUEUE_CONFIG',
> + 960: 'H_INT_SET_OS_REPORTING_LINE',
> + 964: 'H_INT_GET_OS_REPORTING_LINE',
> + 968: 'H_INT_ESB',
> + 972: 'H_INT_SYNC',
> + 976: 'H_INT_RESET',
> + 996: 'H_SCM_READ_METADATA',
> + 1000: 'H_SCM_WRITE_METADATA',
> + 1004: 'H_SCM_BIND_MEM',
> + 1008: 'H_SCM_UNBIND_MEM',
> + 1012: 'H_SCM_QUERY_BLOCK_MEM_BINDING',
> + 1016: 'H_SCM_QUERY_LOGICAL_MEM_BINDING',
> + 1020: 'H_SCM_UNBIND_ALL',
> + 1024: 'H_SCM_HEALTH',
> + 1048: 'H_SCM_PERFORMANCE_STATS',
> + 1052: 'H_PKS_GET_CONFIG',
> + 1056: 'H_PKS_SET_PASSWORD',
> + 1060: 'H_PKS_GEN_PASSWORD',
> + 1068: 'H_PKS_WRITE_OBJECT',
> + 1072: 'H_PKS_GEN_KEY',
> + 1076: 'H_PKS_READ_OBJECT',
> + 1080: 'H_PKS_REMOVE_OBJECT',
> + 1084: 'H_PKS_CONFIRM_OBJECT_FLUSHED',
> + 1096: 'H_RPT_INVALIDATE',
> + 1100: 'H_SCM_FLUSH',
> + 1104: 'H_GET_ENERGY_SCALE_INFO',
> + 1108: 'H_PKS_SIGNED_UPDATE',
> + 1112: 'H_HTM',
> + 1116: 'H_WATCHDOG',
> + # Platform specific hcalls used by KVM on PowerVM
> + 1120: 'H_GUEST_GET_CAPABILITIES',
> + 1124: 'H_GUEST_SET_CAPABILITIES',
> + 1136: 'H_GUEST_CREATE',
> + 1140: 'H_GUEST_CREATE_VCPU',
> + 1144: 'H_GUEST_GET_STATE',
> + 1148: 'H_GUEST_SET_STATE',
> + 1152: 'H_GUEST_RUN_VCPU',
> + 1156: 'H_GUEST_COPY_MEMORY',
> + 1160: 'H_GUEST_DELETE',
> + # Key wrapping hcalls
> + 1168: 'H_PKS_WRAP_OBJECT',
> + 1172: 'H_PKS_UNWRAP_OBJECT',
> + # Platform-specific hcalls used by the Ultravisor
> + 61184: 'H_SVM_PAGE_IN',
> + 61188: 'H_SVM_PAGE_OUT',
> + 61192: 'H_SVM_INIT_START',
> + 61196: 'H_SVM_INIT_DONE',
> + 61204: 'H_SVM_INIT_ABORT',
> + # Platform specific hcalls used by KVM
> 61440: 'H_RTAS',
> + # Platform specific hcalls used by QEMU/SLOF
> + 61441: 'H_LOGICAL_MEMOP',
> + 61442: 'H_CAS',
> + 61443: 'H_UPDATE_DT',
> + # Platform specific hcalls provided by PHYP
> + 61560: 'H_GET_24X7_CATALOG_PAGE',
> + 61564: 'H_GET_24X7_DATA',
> + 61568: 'H_GET_PERF_COUNTER_INFO',
> + # Platform-specific hcalls used for nested HV KVM
> + 63488: 'H_SET_PARTITION_TABLE',
> + 63492: 'H_ENTER_NESTED',
> + 63496: 'H_TLB_INVALIDATE',
> + 63500: 'H_COPY_TOFROM_GUEST',
> }
>=20
> def hcall_table_lookup(opcode):
> --=20
> 2.53.0
>=20
>=20


