Return-Path: <linuxppc-dev+bounces-21285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312A9CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:33:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhWP5lvyz2xSN;
	Thu, 21 May 2026 18:33:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352401;
	cv=none; b=eoKw1cVvCRExvWGeYz1WiLyHnslW3TPcYDhpw7Q2quuSu2ETp+Y0JaaCblYG33Ap/He27kFuxw01gXIeU8plMLiX/s7iVy0x/1yqMvjjJfnb1fPM2I7o/mnR4ugpLa2vATqgfW6Twmz3k4HOMjYyIaVZmxuzlVIjpCPfvDXE2m3sv2gYcfhaTOvm9BE83V3faKw8JsBXipxbws8Otu48ghgpzBmJkZKOfVRrpTx49LegND+SRYSgMjz0q93JCGbQ+jddtwIbqOKfbCdFDes0mtF+yaT2X2mbHwY21CBauWfP1R6QKbsDKRtpbCWS/zbmc65EFKLuQHbSblhj1BVlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352401; c=relaxed/relaxed;
	bh=UDxrjDQ1Qigs9HU77TYHFDgStlyHi9r3tZLycrcQsfA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OzWYcNj1ghARdIyK4D7w2caN9bLl61s9grPlkhtIdomMIXRq2OS/NJ83ioRgHNrRf/bMCkMSOfvyi032tkkwFtzqkrQlaAWeacEnOg6Y7OvQU4zr1k0H/z/pyWdKCcMjDQIFh7Pws3NphvBQuMJDM9IMdB0p6CO5+thkXFyloVo/3chGN4gXpnNf1+ayFMCxSZxp2efEhi69QnR5N2KnyDraRlRQ7m/wnahelrXZx6xRqt0xgksoObU/M0NoZmEu3cpIbq2NN84OQJ/cATfXkADSap4AyOYp/rHrIEK1OeSx07BMQQpvdCr8xSKmbFQTKp+1IJcWdqQAQvlTWNPgIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tCTIflYU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tCTIflYU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhWN0Mskz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:33:19 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L894tu610903;
	Thu, 21 May 2026 08:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UDxrjD
	Q1Qigs9HU77TYHFDgStlyHi9r3tZLycrcQsfA=; b=tCTIflYUwRmBXuw+rs1xo1
	MmiQkgL7Ayp1f93qFhgj0zQ1SVEBlaP3SA6Jyb8vEwSXSk/gwFNHr6XDnwvFP1Jt
	KqFSePNRe2w1k20x45PhjwmczlJ1eGotsnLvZ24mSzL/pR9FVwBwzpPmekfTJzwG
	ppaZUJw7OymUiyO8rPXcCZ2ykpiC3z/ByFPbKmzMn6r0DLC37cqZU6NkieHYSj8U
	wLVgwrThi5JTjzeqPtbgrqKNsvkqYxV2lFK0lAdSBgPFuulZVkMLbcyvxGc1NkA8
	2qB8u5Ojb+n+9o6CcWXLenFglGwxbV0GXNXIO0mSbdNA6dB/InXHYuLAuk0uhUaw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8mr4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 08:33:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L895hC002368;
	Thu, 21 May 2026 08:33:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gjye5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 08:33:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L8X8UV31064692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:33:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49EB32004B;
	Thu, 21 May 2026 08:33:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D8AE20043;
	Thu, 21 May 2026 08:33:05 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.10.78])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 08:33:05 +0000 (GMT)
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
Subject: Re: [PATCH] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <ae76k1BvfgcYI18K@google.com>
Date: Thu, 21 May 2026 14:02:53 +0530
Cc: jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <230801A2-5F9C-42A6-9390-B44786309E30@linux.ibm.com>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
 <ae76k1BvfgcYI18K@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA3OCBTYWx0ZWRfX7hYXvhnzdZEq
 KyK7ovhhBoLBPJLw5NW6iwvFeeeDmYlOAWjDiXuieYIUXOjEMRGD3r5AOSpuF/58KQyhI1/055c
 Br8qkddmwl/BTmArWdMVFS4pYxLvI5LGlApQt8pd+1kFvwZ8s4ebgzGjiis6Aj/ev7n1T1yGKZZ
 6QGpkCHpeqevZKot7faHvnu4wbQJ+uBzkL67EV4omWXCC/3xbvScKDbQ0DICEm+xQuja1+RxCGu
 //ljDRNm5SDZOBqKgTyIDNWrkbCG0HilipwvSxrB4DbTW0Y6bILuQGVhtYRB0mnMalCvpZAdAcD
 a32fky4+qFfRCN9cKRmYYgvDJjgbyevPTVKuYNToEEe4dO5R7I2Gak7oKZIMb22N2BCC0CENAPD
 FotjM8ZLPzK0j7KJ78RH0pbpFzTPBOWybxpNWu5cfLTo4UUB4cTxmKxY6RuaxOesHp67rnSbbk5
 qXAJ3jBe9Mq3+mCgoOQ==
X-Proofpoint-GUID: a2pE93EWymwcmmo0wADmif4s4dzGK_WX
X-Proofpoint-ORIG-GUID: BEqEtiNPoHrHtR6hRaH68wspo0AZuZoX
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ec349 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x5QCPqNzQhPJdF4W:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=SjViIxCRcNrQwX7awCYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210078



> On 27 Apr 2026, at 11:26=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Sun, Apr 26, 2026 at 03:09:30PM +0530, Athira Rajeev wrote:
>> In redhat perftool testsuite, observed fail for this test:
>>    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary =
(output regexp parsing)
>>=20
>> This led to analysis of "perf sched timehist" summary options.
>>=20
>>  # perf sched record -a -o ./perf.data -- sleep 0.1
>>   This will record using perf sched record
>>=20
>> perf sched timeliest has two options "-s" and "-S"
>>  # perf sched -i ./perf.data timehist -S
>> -S : Captures summary also at the end
>>=20
>>  # perf sched -i ./perf.data timehist -s
>> -s : Captures only summary
>>=20
>> The test saves -s result which has only summary and compares with
>> summary which comes at the end from -S . Since there is a difference
>> in these two, test fails.
>>=20
>> Checking the behaviour change in -S and -s results, difference is:
>>=20
>>                  rcu_sched[16]       2          4        0.013      =
0.001       0.003       0.006   33.23       0
>>               migration/11[73]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
>>                migration/3[33]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
>> -               :216753[216753]      -1          1        0.041      =
0.041       0.041       0.041    0.00       0
>> +                 sleep[216753]      -1          1        0.041      =
0.041       0.041       0.041    0.00       0
>>                migration/8[58]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>>            NetworkManager[811]       1          2        0.089      =
0.028       0.044       0.060   36.06       0
>>               migration/13[83]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>>=20
>> Here 216753 is pid for sleep which is a zombie process. This is
>> happening in latest kernel due to an update in "-S" result.
>> In -S, the process name appears in the results "sleep[216753]",
>> where as in the -s, only pid is present in the summary result
>> ":216753[216753]".
>>=20
>> After commit 39f473f6d0b2 ("perf sched timehist: decode process names
>> of processes in zombie state")
>> for -S option, if process name is using pid, it uses different way to
>> set it. So that we get the process name and not just Pid.
>>=20
>> This change went in only for timehist_print_sample() function.
>> Add this improvement in generic place so that even -s option (which
>> captures summary) also will have meaningful information.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
> Thanks,
> Namhyung
Hi,

Can we please have this pulled in, if the patch looks fine ?

Thanks
Athira
>=20
>> ---
>> tools/perf/builtin-sched.c | 14 +++++++++-----
>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 555247568e7a..ee1b89a6af50 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -2197,11 +2197,6 @@ static void timehist_print_sample(struct =
perf_sched *sched,
>> printf(" ");
>> }
>>=20
>> - if (!thread__comm_set(thread)) {
>> -                const char *prev_comm =3D evsel__strval(evsel, =
sample, "prev_comm");
>> -                thread__set_comm(thread, prev_comm, sample->time);
>> -        }
>> -
>> printf(" %-*s ", comm_width, timehist_get_commstr(thread));
>>=20
>> if (sched->show_prio)
>> @@ -2890,6 +2885,15 @@ static int timehist_sched_change_event(const =
struct perf_tool *tool,
>> itr->last_thread =3D NULL;
>> }
>>=20
>> + /*
>> +  * If the process name is not set for the thread, use "prev_comm"
>> +  * to set it. Otherwise the sched summary will have just pid =
information
>> +  */
>> + if (!thread__comm_set(thread)) {
>> + const char *prev_comm =3D evsel__strval(evsel, sample, =
"prev_comm");
>> + thread__set_comm(thread, prev_comm, sample->time);
>> + }
>> +
>> if (!sched->summary_only)
>> timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
>> }
>> --=20
>> 2.47.3



