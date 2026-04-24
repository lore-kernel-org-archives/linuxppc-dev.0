Return-Path: <linuxppc-dev+bounces-20059-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D432FE51FD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:07:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g27tS0g3Lz2yTQ;
	Fri, 24 Apr 2026 20:07:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777025248;
	cv=none; b=Plf6Gilwkeev89/Bb9F2SWpt51QqIW4hJmxxKg1lsZ1r0tsT92gqDgDryPXVq7AyC4L9YLNkdFvOetbSj/+9n2fsFCE65czYC7CpcZgZoiORLNnFVyMNKUQQWFGnBAXn4p92WX05pVjuuW05KGMmRh5OcFTf6txP2Xz2pDsdpl3EDs5/Eq98mO2FK2YgQmIC2e86SWpA+zHpllvW8M8xKkIL7uQUWlmI8N7sCB2P5vdm+9337Xd9TUgr2jkhbWBnNXQdcvVVM+rrGIp0MUeWjuZ7luq3eDbAchJbXhZfOWhU/QXAFVsQ5Db584fGfUiF3e8xwfJkK4humu7mtzXK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777025248; c=relaxed/relaxed;
	bh=2e4cLyvCeUYn/m/JWr1++G6Lw+UXEferIhyfZI1nahg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lxz9NDIouJoxY+BU0A8iMJuRD+7yvlUSZzqWnnEf94slY1unz4Pji3Do5Z3kAJqZwQKMNfG1ScqhQwR9pC3c2pEpPNOlILowPYVAXriiZtEOrDgzECnuZM4FGxgZNCxA4KUuvN1LUfg9IrZRCraRaYJg5Lq9mAQeQBIcN7a8N9ch8+a/AgYZeGelInDJ1ZWFYa5lbyLj9D+uIcOgLDw5uz9u09piQPqKKps9TV8rNM1oML6ySckKi2BkWS3Ky3fkPR+wiS04CEEuIBZ7QApmeCqVuHJmM1Z/dSdkRKPASAt2E6qGKD5f4nVqQ4yLvEx8W2SHAFQhwUNKUc0lOBTp4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T/sspNRH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T/sspNRH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g27tQ0KJFz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:07:25 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NKBQkw3229166;
	Fri, 24 Apr 2026 10:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2e4cLy
	vCeUYn/m/JWr1++G6Lw+UXEferIhyfZI1nahg=; b=T/sspNRHjvS2upDJKfLqE6
	Eah5RBBur5vIl9gYj2+fWe2RD9WVGxkc+cVq7GBLn2NYW5ABi34yCnxmxYVd5ULw
	U/JgBmWD6BTWkKZqV+1zFb6LiVs8LZImN11xlm3xUlnDUFGmi4AM+2JEItFpfW0p
	CjjY+T5Vqrgi+BJXdXAnUnNUST02Uxp0VFmyG2wLQArYwrK7xi/t9phY+8p7cuQk
	trON7QE05rqOouNEUZY35Vbm1UndNFEUc58DyIsndctTx02TxOsvEWGph2ppGswy
	Ue0pSPodE3ox0qv1bjzHOKwIva4EgwPGppoUY56ytY/sCAZ57rMLY4kHZ+Y7GNbQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2d75k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 10:07:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OA5GdL024228;
	Fri, 24 Apr 2026 10:07:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyjb82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 10:07:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OA7A7Q27787882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 10:07:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E1225812F;
	Fri, 24 Apr 2026 09:40:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A910C58127;
	Fri, 24 Apr 2026 09:40:47 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.242.34])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Apr 2026 09:40:47 +0000 (GMT)
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
Subject: Re: [PATCH] perf sched: Fix crash in sched stats diff due to
 uninitialized perf_data structure
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <e6358476-d85a-441e-97e9-80abc9e1dee6@linaro.org>
Date: Fri, 24 Apr 2026 15:10:34 +0530
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2E0C2AA-F6D5-427C-92DB-47777491C76D@linux.ibm.com>
References: <20260422173545.73144-1-atrajeev@linux.ibm.com>
 <e6358476-d85a-441e-97e9-80abc9e1dee6@linaro.org>
To: James Clark <james.clark@linaro.org>,
        Athira Rajeev <atrajeev@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0VQAzIRii6Ewj9C4fKNGiXCx9TwcCJyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MSBTYWx0ZWRfXzzU3XwzMMTau
 R7vWjLK1r3cB2qV/OxdFqWtqhQSaQ1UuQmqyo9xSPLQU4bPPqjVXGkTdfuUVTl2z8uzRQHyMAJt
 jgMDuwZINQ6ea3n1a+DKZCguRlPFPh5FxYrnvjo604vV9UlwImziDLdblvONAhNUFB1uGAbUFOn
 fKWuMKo9IdGoq4aCM6joX8CyszPaFl6mQ9NrX0uudpt3G6R7VTBSsyeZVw8JKv765DPJ3rQDKIc
 Q0LcVHZxzPgROa2SJRjE7R6+VELfL869ldMUQymK+2/Ir2L8QeCcVtNC004Y+2URON1RMVCGqnH
 TxL92Cn+32T9ny62P7g+f0iqQGqfRXCFHdPj2zLwA+drltPBzpnJAofYVZdGkwp72tsNQJNOSmt
 cBzPN1Kf26vh4iER+IBYMlL+0dOgT5sCWuOvFway8Tfi3zyqaZ4kY3Tcw4gOILlw2MZt9G0R5ng
 ibDAuZxRO/zCYK05fmA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69eb40d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=9k4NiTpGiv_xEMfOVrAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BxHAVBhDVeiwQbiBGzSSdhPOSaO93wmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240091



> On 24 Apr 2026, at 2:57=E2=80=AFPM, James Clark =
<james.clark@linaro.org> wrote:
>=20
>=20
>=20
> On 22/04/2026 18:35, Athira Rajeev wrote:
>> perf sched stats diff fails sometimes with below logs:
>>  # perf sched stats record ls
>>  # perf sched stats diff
>>   *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: =
terminated
>>   Aborted (core dumped)
>> Also in some runs, perf sched stats tests fails
>>  ./perf test "perf sched stats tests"
>>  92: perf sched stats tests                                          =
: FAILED!
>> =3D=3D172375=3D=3D Conditional jump or move depends on uninitialised =
value(s)
>> =3D=3D172375=3D=3D    at 0x10393BD0: open_file_read (data.c:264)
>> =3D=3D172375=3D=3D    by 0x10393F63: open_file (data.c:317)
>> =3D=3D172375=3D=3D    by 0x10394067: open_file_dup (data.c:334)
>> =3D=3D172375=3D=3D    by 0x103942DF: perf_data__open (data.c:379)
>> =3D=3D172375=3D=3D    by 0x102F7CAF: __perf_session__new =
(session.c:169)
>> =3D=3D172375=3D=3D    by 0x100B5E63: perf_session__new =
(session.h:116)
>> =3D=3D172375=3D=3D    by 0x100D5D37: perf_sched__schedstat_diff =
(builtin-sched.c:4568)
>> =3D=3D172375=3D=3D    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
>> =3D=3D172375=3D=3D    by 0x1010231F: run_builtin (perf.c:348)
>> =3D=3D172375=3D=3D    by 0x1010262F: handle_internal_command =
(perf.c:398)
>> =3D=3D172375=3D=3D    by 0x1010286F: run_argv (perf.c:442)
>> =3D=3D172375=3D=3D    by 0x10102C67: main (perf.c:549)
>> =3D=3D172375=3D=3D
>> =3D=3D172375=3D=3D Conditional jump or move depends on uninitialised =
value(s)
>> =3D=3D172375=3D=3D    at 0x10393D20: open_file_read (data.c:282)
>> =3D=3D172375=3D=3D    by 0x10393F63: open_file (data.c:317)
>> =3D=3D172375=3D=3D    by 0x10394067: open_file_dup (data.c:334)
>> =3D=3D172375=3D=3D    by 0x103942DF: perf_data__open (data.c:379)
>> =3D=3D172375=3D=3D    by 0x102F7CAF: __perf_session__new =
(session.c:169)
>> =3D=3D172375=3D=3D    by 0x100B5E63: perf_session__new =
(session.h:116)
>> =3D=3D172375=3D=3D    by 0x100D5D37: perf_sched__schedstat_diff =
(builtin-sched.c:4568)
>> =3D=3D172375=3D=3D    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
>> =3D=3D172375=3D=3D    by 0x1010231F: run_builtin (perf.c:348)
>> =3D=3D172375=3D=3D    by 0x1010262F: handle_internal_command =
(perf.c:398)
>> =3D=3D172375=3D=3D    by 0x1010286F: run_argv (perf.c:442)
>> =3D=3D172375=3D=3D    by 0x10102C67: main (perf.c:549)
>> The valgrind logs and error message from the logs points to
>> below snippet:
>>      static int open_file_read(struct perf_data *data)
>>      {
>>             int flags =3D data->in_place_update ? O_RDWR : O_RDONLY;
>>             struct stat st;
>>             int fd;
>>             fd =3D open(data->file.path, flags);
>> The "struct perf_data" is defined here :
>>     static int perf_sched__schedstat_diff(struct perf_sched *sched,
>>                                       int argc, const char **argv)
>>     {
>>         struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
>>         struct list_head cpu_head_ses0, cpu_head_ses1;
>>         struct perf_session *session[2];
>>         struct perf_data data[2];
>>         int ret =3D 0, err =3D 0;
>>         static const char *defaults[] =3D {
>>                 "perf.data.old",
>>                 "perf.data",
>>         };
>> Here due to uninitialized "struct perf_data", the arguments to "open"
>> is getting wrongly passed sometimes depending on value in stack.
>> When perf_data__open() function calls open_file_read(),the
>> "in_place_update" could contain garbage value.
>> After initializing "struct perf_data" in perf_sched__schedstat_diff() =
function,
>> perf sched stats tests runs without issues in multiple attempts and =
also
>> "perf sched stats diff" ran individual without issues.
>> for i in {0..20}; do ./perf test "perf sched stats tests"; done
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>>  92: perf sched stats tests                                          =
: Ok
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>>  tools/perf/builtin-sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 555247568e7a..5d2740099eed 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -4538,7 +4538,7 @@ static int perf_sched__schedstat_diff(struct =
perf_sched *sched,
>>   struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
>>   struct list_head cpu_head_ses0, cpu_head_ses1;
>>   struct perf_session *session[2];
>> - struct perf_data data[2];
>> + struct perf_data data[2] =3D { 0 };
>>   int ret =3D 0, err =3D 0;
>>   static const char *defaults[] =3D {
>>   "perf.data.old",

Tested this patch by applying on top of linux mainline kernel and it =
fixes the issue.

WithOut this Patch:

# ./perf sched stats diff
*** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: =
terminated
Aborted (core dumped)

# ./perf test -v "perf sched stats tests"
--- start ---
test child forked, pid 11151
Basic perf sched stats record test
Basic perf sched stats record test [Success]
Basic perf sched stats report test
[ perf sched stats: Wrote samples to =
/tmp/__perf_test_sched_stats.perf.data.dysu3 ]
Basic perf sched stats report test [Success]
Basic perf sched stats live mode test
Basic perf sched stats live mode test [Success]
Basic perf sched stats diff test
[ perf sched stats: Wrote samples to =
/tmp/__perf_test_sched_stats.perf.data.dysu3 ]
[ perf sched stats: Wrote samples to =
/tmp/__perf_test_sched_stats.perf.data.p0lnk ]
*** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: =
terminated
/linux/tools/perf/tests/shell/perf_sched_stats.sh: line 67: 11170 =
Aborted                 (core dumped) perf sched stats diff =
"${perfdata}" "${perfdata2}" > /dev/null
Basic perf sched stats diff test [Failed]
---- end(-1) ----
 92: perf sched stats tests                                          : =
FAILED!

With This Patch:

#=20
for i in {1..20}; do
    ./perf test "perf sched stats tests"
done
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok
 92: perf sched stats tests                                          : =
Ok

Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
>=20
> I had a quick look for other instances of the same thing and didn't =
see any.



