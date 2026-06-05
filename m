Return-Path: <linuxppc-dev+bounces-22104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72C5CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 06:07:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWrYn26Zdz2xnK;
	Fri, 05 Jun 2026 16:07:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780639629;
	cv=none; b=QM0lLMvoibGiIkErZWUwK6BKudbWuSyMYgyUvOMoGoyxerdasqvwo7B529tsfgtJJNOjQ+SNJaHLXuSZisi6Ts2sv1Bd3vkhY0boP2CFAze72FviY/yC60oa3GKh7msahKbT0WPK4sQT86M8hIHDEKjipmXdFWDDGP1ADtAtWL4lyhS9U5zMGOSDMY0/ZNFpxIKppwYrv7AyffG2/JsEwN64NVsSSB0OtrGB3V4YZIoYZdUiqqiCPyiyC4Iui5nMC73XtdE/Fmh6VTs6wHhrLaZHPJsNPSjDXKNzBKzEP7P/ZwmQ439tJ27jz5Y9Mso34CYqHhHc//+UZI6RlUbYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780639629; c=relaxed/relaxed;
	bh=3SgxirsFjxZSl+GiBPKA867MoUftR5masuzfQURArwM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=lKOdgxp5IHIRo9TaI0LV5ONNPACSEuWv5yaajmTNwPa0BwpLOZ7dNLtkg7dZP3Z7ear6aKApBmqh66lAsxKTNYx9xQrCKhWGK1GQ9Yd3x9h4xkT30+cUXhhDfF2v51FuhivHF64PXp8j9biKghX7cFCmdcswqS1/YBpqIxzJrU7hbh6jRn9+ICm016/7PoIukSKoKUiTUndy4WxrPpI5KF4snd0K8kXyyYbB1Hjef9o9k2dKlM2bXUYCpntSPvZ6lm8gBpxgQBJfigiY27Hl7FWgWlzFJXtgQ3I/gbLf0ISCMbueJ9brO0/Q+oVCeyic0O5J+D7zCg6Nwg9+v6/hEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H1Ii3mDm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H1Ii3mDm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrYm2KZcz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 16:07:08 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65501b7f2672300;
	Fri, 5 Jun 2026 06:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3SgxirsFjxZSl+GiBPKA867MoUftR5
	masuzfQURArwM=; b=H1Ii3mDma5eLPbZqBcLzDSBrgX9QrzOloccCIVwT9keKoL
	pPCvdXtarraStibXd46zPy+/DdBy/RWFuqf0BDmtPnDrMtmjmCSu7ftN6ATp3+gD
	fw+YXvJAyXq4yJ8L5b4kuiG/fYEm73SEGblG1+I3lMG8ye4/Om6JSlI/QkXEbjGm
	g41D9oWy+Nrdp2bgf1/8csmFof9d+/itRT+e7GS1meOEQSzizxNZsX46xp6oKYUI
	/qWLHoleaA0D59T1KxXD41v1rz5Z6qht+tRKAho1a7eURL60wsNWad2uc6cTFkdn
	WvDj3DPd2Y4C5ZtnDr2EnKQhydeWc+L9JmRYS8aQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtjdc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 06:06:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6555s5IA031814;
	Fri, 5 Jun 2026 06:06:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyr2q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 06:06:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65566g2s28901718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 06:06:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5896120043;
	Fri,  5 Jun 2026 06:06:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9CF420040;
	Fri,  5 Jun 2026 06:06:37 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.24.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Jun 2026 06:06:37 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
Message-Id: <7B428DB0-8274-43B8-88B9-C186D017CF5B@linux.ibm.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D8A9E944-9FA4-4F55-AF09-340F15007C70"
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
Date: Fri, 5 Jun 2026 11:36:25 +0530
In-Reply-To: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
To: Gautam Menghani <Gautam.Menghani@ibm.com>
References: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8NXKl8xwrlS__v-DqzwrAmJE1Ls8JOSg
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a226777 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=9AdMxfjQAAAA:20
 a=Eu7ggDVoetdrdGGIGtIA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=BQKEyPsoxZhxzF-IzbkA:9 a=ruLfN6eCt1bpUoxf:21 a=_W_S_7VecoQA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1NiBTYWx0ZWRfX4G8slDOU3s3A
 7CBU/eIWPmLveWsCKFbFZIaYxhYpCPV4B9OsxgRR9xegN5Btcw3YMRJPGaitRYEJi2YaWttX/JM
 b4X3DTWBVx61OvcQRDy0sizza7uMF4S1V9e2wbc2dGdUmjLnpGqihNs6GS04fjyA9UqzvGH7Cte
 ROO+vj7NzGlD7qVVOtKqG9FwPbvzCKVJ7exVZ71BMBQvqpkcQOCmqpMIABSPGyEEn0Lt5J+WD9F
 kTiGKsMcaN0kYrq+nTXs+FIUoyxhH8cdmcgZF6IHF7timOm1oLm5oeopxFiISwtAjJMjZXxzhg+
 PHD9Z6qF8AWJ/M/GdGo8BTWAaAtbeImksUhMZWb5JPhawCdS1Bt9vMFo2lKWdLEwHXyoZrqiTFY
 G7/SsZA0PgsYgrbBqXqml3EysUteh3P7Omxj+6OhZtwstXs4jLazS2hSQhsfdrIRqy912PRNFbA
 rI2J5pmOCUXna78KtWQ==
X-Proofpoint-ORIG-GUID: GtEEgqTRf0lFX7CdLCTGKWtgPG0qCo95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050056


--Apple-Mail=_D8A9E944-9FA4-4F55-AF09-340F15007C70
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



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

Changes looks fine to me. I have checked the names and hcall numbers in =
hvcall.h header file.

Reviewed-by: Shivani Nittor <shivani@linux.ibm.com =
<mailto:shivani@linux.ibm.com>>

> tools/perf/scripts/python/powerpc-hcalls.py | 89 +++++++++++++++++++++
> 1 file changed, 89 insertions(+)
>=20
> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py =
b/tools/perf/scripts/python/powerpc-hcalls.py
> index 8b78dc790adb..f897d6a5e051 100644
> --- a/tools/perf/scripts/python/powerpc-hcalls.py
> +++ b/tools/perf/scripts/python/powerpc-hcalls.py
> @@ -117,10 +117,12 @@ hcall_table =3D {
> 	440: 'H_GET_HCA_INFO',
> 	444: 'H_GET_PERF_COUNT',
> 	448: 'H_MANAGE_TRACE',
> +	456: 'H_GET_CPU_CHARACTERISTICS',
> 	468: 'H_FREE_LOGICAL_LAN_BUFFER',
> 	472: 'H_POLL_PENDING',
> 	484: 'H_QUERY_INT_STATE',
> 	580: 'H_ILLAN_ATTRIBUTES',
> +	584: 'H_ADD_LOGICAL_LAN_BUFFERS',
> 	592: 'H_MODIFY_HEA_QP',
> 	596: 'H_QUERY_HEA_QP',
> 	600: 'H_QUERY_HEA',
> @@ -135,11 +137,17 @@ hcall_table =3D {
> 	644: 'H_ADD_CONN',
> 	648: 'H_DEL_CONN',
> 	664: 'H_JOIN',
> +	672: 'H_VASI_SIGNAL',
> 	676: 'H_VASI_STATE',
> +	680: 'H_VIOCTL',
> 	688: 'H_ENABLE_CRQ',
> 	696: 'H_GET_EM_PARMS',
> 	720: 'H_SET_MPP',
> 	724: 'H_GET_MPP',
> +	732: 'H_REG_SUB_CRQ',
> +	736: 'H_FREE_SUB_CRQ',
> +	740: 'H_SEND_SUB_CRQ',
> +	744: 'H_SEND_SUB_CRQ_INDIRECT',
> 	748: 'H_HOME_NODE_ASSOCIATIVITY',
> 	756: 'H_BEST_ENERGY',
> 	764: 'H_XIRR_X',
> @@ -147,7 +155,88 @@ hcall_table =3D {
> 	772: 'H_COP',
> 	788: 'H_GET_MPP_X',
> 	796: 'H_SET_MODE',
> +	808: 'H_BLOCK_REMOVE',
> +	856: 'H_CLEAR_HPT',
> +	864: 'H_REQUEST_VMC',
> +	876: 'H_RESIZE_HPT_PREPARE',
> +	880: 'H_RESIZE_HPT_COMMIT',
> +	892: 'H_REGISTER_PROC_TBL',
> +	896: 'H_SIGNAL_SYS_RESET',
> +	904: 'H_ALLOCATE_VAS_WINDOW',
> +	908: 'H_MODIFY_VAS_WINDOW',
> +	912: 'H_DEALLOCATE_VAS_WINDOW',
> +	916: 'H_QUERY_VAS_WINDOW',
> +	920: 'H_QUERY_VAS_CAPABILITIES',
> +	924: 'H_QUERY_NX_CAPABILITIES',
> +	928: 'H_GET_NX_FAULT',
> +	936: 'H_INT_GET_SOURCE_INFO',
> +	940: 'H_INT_SET_SOURCE_CONFIG',
> +	944: 'H_INT_GET_SOURCE_CONFIG',
> +	948: 'H_INT_GET_QUEUE_INFO',
> +	952: 'H_INT_SET_QUEUE_CONFIG',
> +	956: 'H_INT_GET_QUEUE_CONFIG',
> +	960: 'H_INT_SET_OS_REPORTING_LINE',
> +	964: 'H_INT_GET_OS_REPORTING_LINE',
> +	968: 'H_INT_ESB',
> +	972: 'H_INT_SYNC',
> +	976: 'H_INT_RESET',
> +	996: 'H_SCM_READ_METADATA',
> +	1000: 'H_SCM_WRITE_METADATA',
> +	1004: 'H_SCM_BIND_MEM',
> +	1008: 'H_SCM_UNBIND_MEM',
> +	1012: 'H_SCM_QUERY_BLOCK_MEM_BINDING',
> +	1016: 'H_SCM_QUERY_LOGICAL_MEM_BINDING',
> +	1020: 'H_SCM_UNBIND_ALL',
> +	1024: 'H_SCM_HEALTH',
> +	1048: 'H_SCM_PERFORMANCE_STATS',
> +	1052: 'H_PKS_GET_CONFIG',
> +	1056: 'H_PKS_SET_PASSWORD',
> +	1060: 'H_PKS_GEN_PASSWORD',
> +	1068: 'H_PKS_WRITE_OBJECT',
> +	1072: 'H_PKS_GEN_KEY',
> +	1076: 'H_PKS_READ_OBJECT',
> +	1080: 'H_PKS_REMOVE_OBJECT',
> +	1084: 'H_PKS_CONFIRM_OBJECT_FLUSHED',
> +	1096: 'H_RPT_INVALIDATE',
> +	1100: 'H_SCM_FLUSH',
> +	1104: 'H_GET_ENERGY_SCALE_INFO',
> +	1108: 'H_PKS_SIGNED_UPDATE',
> +	1112: 'H_HTM',
> +	1116: 'H_WATCHDOG',
> +	# Platform specific hcalls used by KVM on PowerVM
> +	1120: 'H_GUEST_GET_CAPABILITIES',
> +	1124: 'H_GUEST_SET_CAPABILITIES',
> +	1136: 'H_GUEST_CREATE',
> +	1140: 'H_GUEST_CREATE_VCPU',
> +	1144: 'H_GUEST_GET_STATE',
> +	1148: 'H_GUEST_SET_STATE',
> +	1152: 'H_GUEST_RUN_VCPU',
> +	1156: 'H_GUEST_COPY_MEMORY',
> +	1160: 'H_GUEST_DELETE',
> +	# Key wrapping hcalls
> +	1168: 'H_PKS_WRAP_OBJECT',
> +	1172: 'H_PKS_UNWRAP_OBJECT',
> +	# Platform-specific hcalls used by the Ultravisor
> +	61184: 'H_SVM_PAGE_IN',
> +	61188: 'H_SVM_PAGE_OUT',
> +	61192: 'H_SVM_INIT_START',
> +	61196: 'H_SVM_INIT_DONE',
> +	61204: 'H_SVM_INIT_ABORT',
> +	# Platform specific hcalls used by KVM
> 	61440: 'H_RTAS',
> +	# Platform specific hcalls used by QEMU/SLOF
> +	61441: 'H_LOGICAL_MEMOP',
> +	61442: 'H_CAS',
> +	61443: 'H_UPDATE_DT',
> +	# Platform specific hcalls provided by PHYP
> +	61560: 'H_GET_24X7_CATALOG_PAGE',
> +	61564: 'H_GET_24X7_DATA',
> +	61568: 'H_GET_PERF_COUNTER_INFO',
> +	# Platform-specific hcalls used for nested HV KVM
> +	63488: 'H_SET_PARTITION_TABLE',
> +	63492: 'H_ENTER_NESTED',
> +	63496: 'H_TLB_INVALIDATE',
> +	63500: 'H_COPY_TOFROM_GUEST',
> }
>=20
> def hcall_table_lookup(opcode):
> --=20
> 2.53.0
>=20
>=20


--Apple-Mail=_D8A9E944-9FA4-4F55-AF09-340F15007C70
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 2 Jun 2026, at 17:26, Gautam Menghani =
&lt;Gautam.Menghani@ibm.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>From: Gautam Menghani =
&lt;gautam@linux.ibm.com&gt;<br><br>Update the hcall list with the newer =
hcalls in PPC.<br><br>[1]: =
github.com/torvalds/linux/blob/master/arch/powerpc/include/asm/hvcall.h<br=
><br>Signed-off-by: Gautam Menghani =
&lt;gautam@linux.ibm.com&gt;<br>---<br>v1 -&gt; v2:<br>1. Add some of =
the missing hcalls. (Tejas)<br>2. Separate out the typo fix for =
H_DISABLE_AND_GET in another =
patch.</div></div></blockquote><div><br></div><div>Changes looks fine to =
me. I have checked the names and hcall numbers in hvcall.h header =
file.</div><div><br></div><div>Reviewed-by: Shivani Nittor &lt;<a =
href=3D"mailto:shivani@linux.ibm.com">shivani@linux.ibm.com</a>&gt;</div><=
div><br></div><blockquote type=3D"cite"><div><div> =
tools/perf/scripts/python/powerpc-hcalls.py | 89 =
+++++++++++++++++++++<br> 1 file changed, 89 insertions(+)<br><br>diff =
--git a/tools/perf/scripts/python/powerpc-hcalls.py =
b/tools/perf/scripts/python/powerpc-hcalls.py<br>index =
8b78dc790adb..f897d6a5e051 100644<br>--- =
a/tools/perf/scripts/python/powerpc-hcalls.py<br>+++ =
b/tools/perf/scripts/python/powerpc-hcalls.py<br>@@ -117,10 +117,12 @@ =
hcall_table =3D {<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>440: 'H_GET_HCA_INFO',<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>444: =
'H_GET_PERF_COUNT',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>448: 'H_MANAGE_TRACE',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>456: =
'H_GET_CPU_CHARACTERISTICS',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>468: =
'H_FREE_LOGICAL_LAN_BUFFER',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>472: 'H_POLL_PENDING',<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>484: =
'H_QUERY_INT_STATE',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>580: =
'H_ILLAN_ATTRIBUTES',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>584: =
'H_ADD_LOGICAL_LAN_BUFFERS',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>592: 'H_MODIFY_HEA_QP',<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>596: =
'H_QUERY_HEA_QP',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>600: 'H_QUERY_HEA',<br>@@ -135,11 =
+137,17 @@ hcall_table =3D {<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>644: 'H_ADD_CONN',<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>648: =
'H_DEL_CONN',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>664: 'H_JOIN',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>672: =
'H_VASI_SIGNAL',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>676: 'H_VASI_STATE',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>680: =
'H_VIOCTL',<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>688: 'H_ENABLE_CRQ',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>696: 'H_GET_EM_PARMS',<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>720: =
'H_SET_MPP',<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>724: 'H_GET_MPP',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>732: 'H_REG_SUB_CRQ',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>736: =
'H_FREE_SUB_CRQ',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>740: 'H_SEND_SUB_CRQ',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>744: =
'H_SEND_SUB_CRQ_INDIRECT',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>748: =
'H_HOME_NODE_ASSOCIATIVITY',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>756: 'H_BEST_ENERGY',<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>764: =
'H_XIRR_X',<br>@@ -147,7 +155,88 @@ hcall_table =3D {<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>772: =
'H_COP',<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>788: 'H_GET_MPP_X',<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>796: 'H_SET_MODE',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>808: =
'H_BLOCK_REMOVE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>856: 'H_CLEAR_HPT',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>864: =
'H_REQUEST_VMC',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>876: =
'H_RESIZE_HPT_PREPARE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>880: =
'H_RESIZE_HPT_COMMIT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>892: =
'H_REGISTER_PROC_TBL',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>896: =
'H_SIGNAL_SYS_RESET',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>904: =
'H_ALLOCATE_VAS_WINDOW',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>908: =
'H_MODIFY_VAS_WINDOW',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>912: =
'H_DEALLOCATE_VAS_WINDOW',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>916: =
'H_QUERY_VAS_WINDOW',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>920: =
'H_QUERY_VAS_CAPABILITIES',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>924: =
'H_QUERY_NX_CAPABILITIES',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>928: 'H_GET_NX_FAULT',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>936: =
'H_INT_GET_SOURCE_INFO',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>940: =
'H_INT_SET_SOURCE_CONFIG',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>944: =
'H_INT_GET_SOURCE_CONFIG',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>948: =
'H_INT_GET_QUEUE_INFO',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>952: =
'H_INT_SET_QUEUE_CONFIG',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>956: =
'H_INT_GET_QUEUE_CONFIG',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>960: =
'H_INT_SET_OS_REPORTING_LINE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>964: =
'H_INT_GET_OS_REPORTING_LINE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>968: 'H_INT_ESB',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>972: =
'H_INT_SYNC',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>976: 'H_INT_RESET',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>996: =
'H_SCM_READ_METADATA',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1000: =
'H_SCM_WRITE_METADATA',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1004: 'H_SCM_BIND_MEM',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1008: =
'H_SCM_UNBIND_MEM',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1012: =
'H_SCM_QUERY_BLOCK_MEM_BINDING',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1016: =
'H_SCM_QUERY_LOGICAL_MEM_BINDING',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1020: =
'H_SCM_UNBIND_ALL',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1024: 'H_SCM_HEALTH',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1048: =
'H_SCM_PERFORMANCE_STATS',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1052: =
'H_PKS_GET_CONFIG',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1056: =
'H_PKS_SET_PASSWORD',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1060: =
'H_PKS_GEN_PASSWORD',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1068: =
'H_PKS_WRITE_OBJECT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1072: 'H_PKS_GEN_KEY',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1076: =
'H_PKS_READ_OBJECT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1080: =
'H_PKS_REMOVE_OBJECT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1084: =
'H_PKS_CONFIRM_OBJECT_FLUSHED',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1096: =
'H_RPT_INVALIDATE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1100: 'H_SCM_FLUSH',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1104: =
'H_GET_ENERGY_SCALE_INFO',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1108: =
'H_PKS_SIGNED_UPDATE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1112: 'H_HTM',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1116: =
'H_WATCHDOG',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span># Platform specific hcalls used =
by KVM on PowerVM<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1120: =
'H_GUEST_GET_CAPABILITIES',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1124: =
'H_GUEST_SET_CAPABILITIES',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1136: 'H_GUEST_CREATE',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1140: =
'H_GUEST_CREATE_VCPU',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1144: =
'H_GUEST_GET_STATE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1148: =
'H_GUEST_SET_STATE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1152: =
'H_GUEST_RUN_VCPU',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1156: =
'H_GUEST_COPY_MEMORY',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1160: 'H_GUEST_DELETE',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span># Key =
wrapping hcalls<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1168: =
'H_PKS_WRAP_OBJECT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>1172: =
'H_PKS_UNWRAP_OBJECT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span># Platform-specific hcalls used =
by the Ultravisor<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61184: 'H_SVM_PAGE_IN',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>61188: =
'H_SVM_PAGE_OUT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61192: =
'H_SVM_INIT_START',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61196: =
'H_SVM_INIT_DONE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61204: =
'H_SVM_INIT_ABORT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span># Platform specific hcalls used =
by KVM<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>61440: 'H_RTAS',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span># Platform specific hcalls used =
by QEMU/SLOF<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>61441: 'H_LOGICAL_MEMOP',<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>61442: =
'H_CAS',<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>61443: 'H_UPDATE_DT',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span># Platform specific hcalls =
provided by PHYP<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61560: =
'H_GET_24X7_CATALOG_PAGE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61564: =
'H_GET_24X7_DATA',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>61568: =
'H_GET_PERF_COUNTER_INFO',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span># Platform-specific hcalls used =
for nested HV KVM<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>63488: =
'H_SET_PARTITION_TABLE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>63492: =
'H_ENTER_NESTED',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>63496: =
'H_TLB_INVALIDATE',<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>63500: 'H_COPY_TOFROM_GUEST',<br> =
}<br><br> def hcall_table_lookup(opcode):<br>-- =
<br>2.53.0<br><br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_D8A9E944-9FA4-4F55-AF09-340F15007C70--


