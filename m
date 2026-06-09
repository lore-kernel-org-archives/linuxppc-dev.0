Return-Path: <linuxppc-dev+bounces-22319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B30FCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:14:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZSWw6skJz2yv2;
	Tue, 09 Jun 2026 22:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781007276;
	cv=none; b=bXm7LhF2CpQsvTQBgZjxbJGBpB7FZqFnMZCSTG3v4+0QqlF0aIFIJDBKZLLS2sNUg0a+HjCjRHiJJtxZEB2otgj+lUiRHEDsUfVJ42gJQyFAYuWkY2pWu7dsgiogt5F2+U1fWcVs3h+WTKjf7yrEukvo7PkTtoco8UbsBMhhP4XzDQoIH04yLjJ7LNHpYpEeaw3wMinp1DQj0IMzboY6YHzLojo3pSpuYwvi7KDZ5BZkOLN+LRDBOV+gbaQL2Hnyzs4U1ogaYmtJB+pWT6vL8BP0W+QVLu2EP6NPUiXRM+kHA8Eapv4jssJdTs2ZAkVya1K0WkCK2f2V8HgiaW5CSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781007276; c=relaxed/relaxed;
	bh=57Yx+iqumQuBEpoVCz+tbrxnNc/RDV5vHnP2PPk7DVc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a0vPSD6aYZ9o1sJDD+W+49FYdSK3YT49lrE9FF5pNIfpYt5o5HA/x60bog8GQB3Lepyojo9vB+j747DT54cAJx1zX+0lgwqF6e0RnZ6IVJi+HemTlhrUYMutvdSZE9ykn5NpZRl+M9yAoGdchVivFNxjH1+l0n/Z/UMsUTbwozfYQQyt4Jrk8jFa7p4S3V3NxhpIsIAW/xNmW2hYAaSAKCKZwUd0t5i/R0JRZQHgG+7a0dMP17GT4FGktnf1/mL9R3pXtkrELc4GbjbttOe+Rx3kqHNC/u5by8AKkDaA1eVmGL7VIiUlPwzMoLjlj9reXhOwPeXT0NGTLLBtzslI2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3LKVma/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h3LKVma/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZSWv2GR3z2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 22:14:34 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658NeRma3804276;
	Tue, 9 Jun 2026 12:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=57Yx+i
	qumQuBEpoVCz+tbrxnNc/RDV5vHnP2PPk7DVc=; b=h3LKVma/myCflykoSBeQuX
	IpeFtLXCaVNqnSRbLeeKhoomznCdL1LMHv3ZupbFAuiygCA9IaoKASUAPhsKNrYA
	t1uGGeyuXQFGdVb5syka+l9HmXx3yytuFBGDWSby2IvlU2nVo8YWirdztYYslccK
	/J5cfXZBUq/zvaDKPp3lFq7XcV6yE5KXt9wOZzCuTVo5YTwWVtnwzqdcVCU47OD0
	383aOTCSKFAHE2KTHc8z1Er0wr/VF2couMVo0nijsrWOjnayCWvpxiMsUWllBcVU
	/ifCtJAMv/6dKDkRLnGnDbOjeJ0abq+G4rbDcTaF50sn0AqMssAYKei2LB72loXg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye3v4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 12:14:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659C4dvB015587;
	Tue, 9 Jun 2026 12:14:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g1p6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 12:14:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659CETV051052824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 12:14:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E46B62004B;
	Tue,  9 Jun 2026 12:14:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1E1A20040;
	Tue,  9 Jun 2026 12:14:25 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.212.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 12:14:25 +0000 (GMT)
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
Subject: Re: [PATCH V4 2/2] tools/perf: Use scnprintf in buffer offset
 calculations
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <aiH2BnKXmur79SSR@google.com>
Date: Tue, 9 Jun 2026 17:44:13 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1A886CC-5C1C-4BA7-9F1D-56356281DC28@linux.ibm.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
 <20260504154205.21394-2-atrajeev@linux.ibm.com> <aiH2BnKXmur79SSR@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNCBTYWx0ZWRfX3mrKSriTwtCn
 lEdAOBBA0ZaK95Du2tsQ3YCT8y4foST7E57pRv7WkwMt4PMSVKE/lcoFv8YzmNJKLF6IucIQxo5
 C5JNG6Z5JywCb1OnX32BLvYWkY6fDA5l8yfAhGnQCJ5Z8aJjSzoIf5HcmBgxcn1FN+1wi9qhDXn
 bvjDXWd3Z/AwRP99U1JzffO6J1ypmxHYAuHP6bSrqur4JcgxMqJDfMOtq5A1kVBbB/tJ6QuDigR
 Iw6Fu1BIK1TXYNVY7ASKL9RTH7Sth093DwvUYY27UKUDBN261gcSaC+dphZwcXeYh+nHLAsLWwl
 hCV221m/jGVVV+AC0hNMiZsN4i22uMi6tsBCdm0btMa/tUl3jsFj2TCXzffVQ2O+9Mp5ziU4HZw
 fBlz20aO2jomVVJLMxcJ6qXhC1I3xGtkWvrJBCBGx0EOus49PN44NgRw/9kPIBOYmdHPEHAikys
 ku+xlRyzcNaOgBjvmww==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2803a7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yDw2nYwaqeuPlelgnKwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g7jEU3E_DzTwddrYo3arXrvUaMaGxeNy
X-Proofpoint-ORIG-GUID: g7jEU3E_DzTwddrYo3arXrvUaMaGxeNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090114



> On 5 Jun 2026, at 3:32=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Mon, May 04, 2026 at 09:12:05PM +0530, Athira Rajeev wrote:
>> Replace snprintf with scnprintf in buffer offset calculations to
>> ensure the 'used' count will not exceed the "len".
>>=20
>> The current logic in perf_pmu__for_each_event uses an unconditional
>> + 1 increment to buf_used to account for null terminators. This can
>> cause a a stack buffer overflow in the subsequent scnprintf call.
>> When the local stack buffer buf (1024 bytes) is full, buf_used can
>> reach 1025. This causes the subsequent remaining space calculation
>> sizeof(buf) - buf_used to underflow.
>>=20
>> Use sub_non_neg() to see if space actually existed, and only
>> increment the offset if remaning space is present.
>>=20
>> Changes includes:
>> - Use sub_non_neg to check if space exists
>> - Replacing snprintf with scnprintf to ensure the return value
>> reflects the actual bytes written into the buffer.
>> - Only increment buf_used by 1 if space exists
>> - If a parameterized event uses a built-in perf keyword for its
>> parameter name (eg, config=3D?), the lexer parses it as a predefined
>> term token, which sets term->config to NULL. Add check to use
>> parse_events__term_type_str() if term->config is NULL.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>> Changelog:
>> v2 -> v3:
>> - Split the scnprintf related changes in separate patch
>> - Handle the overflow issues and unconditional increment
>> wrapped around sub_non_neg addressing review comment from Sashiko
>>=20
>> tools/perf/util/pmu.c | 46 =
++++++++++++++++++++++++++++++++-----------
>> 1 file changed, 35 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 0b8d58543f17..4b9ade1a4cf9 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>> pr_err("Failure to parse '%s' terms '%s': %d\n",
>> alias->name, alias->terms, ret);
>> parse_events_terms__exit(&terms);
>> - snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>> + scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>> return buf;
>> }
>> - used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
>> + used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
>>=20
>> list_for_each_entry(term, &terms.terms, list) {
>> + const char *name =3D term->config;
>> +
>> + if (!name)
>> + name =3D parse_events__term_type_str(term->type_term);
>> if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
>> - used +=3D snprintf(buf + used, sub_non_neg(len, used),
>> - ",%s=3D%s", term->config,
>> + used +=3D scnprintf(buf + used, sub_non_neg(len, used),
>> + ",%s=3D%s", name,
>> term->val.str);
>> }
>> parse_events_terms__exit(&terms);
>> @@ -2201,6 +2205,7 @@ int perf_pmu__for_each_event(struct perf_pmu =
*pmu, bool skip_duplicate_pmus,
>> int ret =3D 0;
>> struct hashmap_entry *entry;
>> size_t bkt;
>> + size_t size_rem, len;
>>=20
>> if (perf_pmu__is_tracepoint(pmu))
>> return tp_pmu__for_each_event(pmu, state, cb);
>> @@ -2234,17 +2239,36 @@ int perf_pmu__for_each_event(struct perf_pmu =
*pmu, bool skip_duplicate_pmus,
>> }
>> buf_used =3D strlen(buf) + 1;
>> }
>> +
>> info.scale_unit =3D NULL;
>> if (strlen(event->unit) || event->scale !=3D 1.0) {
>> - info.scale_unit =3D buf + buf_used;
>> - buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
>> - "%G%s", event->scale, event->unit) + 1;
>> + /* Check the remaining space */
>> + size_rem =3D sub_non_neg(sizeof(buf), buf_used);
>> +
>> + if (size_rem > 0) {
>> + info.scale_unit =3D buf + buf_used;
>> + len =3D scnprintf(buf + buf_used, size_rem, "%G%s",
>> + event->scale, event->unit);
>> + /*
>> +  * Increment buf_used by 1 only if
>> +  * it fits remaining space
>> +  */
>> + buf_used +=3D min(len + 1, size_rem);
>=20
> Hmm.. it seems scnprintf() cannot return a number greater than or =
equal
> to size_rem.  Can we just do like this?
>=20
> buf_used +=3D scnprintf(...) + 1;
>=20
> Thanks,
> Namhyung

Sure

I will address this change in next version

Thanks
Athira
>=20
>> + }
>> }
>> info.desc =3D event->desc;
>> info.long_desc =3D event->long_desc;
>> - info.encoding_desc =3D buf + buf_used;
>> - buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
>> - "%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
>> + info.encoding_desc =3D NULL;
>> +
>> + /* Check the remaining space */
>> + size_rem =3D sub_non_neg(sizeof(buf), buf_used);
>> + if (size_rem > 0) {
>> + info.encoding_desc =3D buf + buf_used;
>> + len =3D scnprintf(buf + buf_used, size_rem, "%.*s/%s/",
>> + (int)pmu_name_len, info.pmu_name, event->terms);
>> + buf_used +=3D min(len + 1, size_rem);
>> + }
>> +
>> info.str =3D event->terms;
>> info.topic =3D event->topic;
>> info.deprecated =3D perf_pmu_alias__check_deprecated(pmu, event);
>> @@ -2254,7 +2278,7 @@ int perf_pmu__for_each_event(struct perf_pmu =
*pmu, bool skip_duplicate_pmus,
>> }
>> if (pmu->selectable) {
>> info.name =3D buf;
>> - snprintf(buf, sizeof(buf), "%s//", pmu->name);
>> + scnprintf(buf, sizeof(buf), "%s//", pmu->name);
>> info.alias =3D NULL;
>> info.scale_unit =3D NULL;
>> info.desc =3D NULL;
>> --=20
>> 2.47.3



