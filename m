Return-Path: <linuxppc-dev+bounces-22773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB2FCD98F6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gh48F72g2z2yRF;
	Fri, 19 Jun 2026 01:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781795821;
	cv=none; b=gfgJF8qJQ7ibe7wxb0M5QAN8OIhKOAv1JjVmVhVTNewghFVRVFTJPQFD9HlG8T1pyC11C6YHij2DtLDp8HdXDbdbBZBkPhdFeeINGAR1hoW7iGev51Rz2H7wfziLBRNRX8goHwYIy0Ua3PhFUKtPh1ybbkfj6qjPKXjmYPVBk+rjwYsRTm1v8rtEDvTRPuRv2zTAl7KYptchf5Jyc+YVlb5fqgDj6YPnzc4mMQIUlfKLgA31GArznR6cwEOQksREzRW2faoRa6zlqhz7c3lrK7oENAgcsephUrDcfzNXRxQ2lCyA1iTeztq00r0xeRRSc4i3ZIYLDnkuiC4PSCxOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781795821; c=relaxed/relaxed;
	bh=HQDw9hBFhF4z6kW9UOyzfabpUtvuruXQ8qavzcET9vU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XP8h1mV5LehVcmYM6vaScEzxutfiPlfGoJzXLg6xvSmOwMh3qOxEiClnE6/H9lROdTxyesmDyiyyb6CzonL0e7XnuDD1dzlwG/U+Ka9m+Qp6oaGQ+m93Galxi1r4SrlphkXjIG6N/LZdT7BhDvrzmYoHfsBNW9/4ldKOmUjNzaVAYmX0lmZGfRC3r62pGU1grApL3vXOeUA84v4RdflE2/Qsbgv2STLseMNvCbiQtu3UoyoMd/eaLSL+//YBwtWkN4S3u4M1KETOBNev6KQF/ctSN7AcO/0ZL1OheOYWLAxOr/gUr5QYlfa3pmeuggw+Ft3QlQrGo9W0mFbLo3Pdug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BF/HWDqb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BF/HWDqb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gh48D2KP5z2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 01:16:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IEIFU23688654;
	Thu, 18 Jun 2026 15:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HQDw9h
	BFhF4z6kW9UOyzfabpUtvuruXQ8qavzcET9vU=; b=BF/HWDqbrrGPvFyiJb0oGe
	i5Xnpe0XwbZ+zwOeiQ6ejWnhtX/Z+o/LcIF6ZRugTtJallzsBqHP3byAvRl8AlvL
	ZXGlkF9dXLbnTGOv0dddtm/aN0tFj+6TbkwWoc9PvlWOdvFfFnge+6mYi3AAgK4h
	dm7b50nZe1QWLoTi799ybI/heCTeqadRBv9nSH/LOdtwEkJMs/oonIEeKsm/JO0g
	UMVc+KUEDL7IDi2CZ9bL4EbJx95MMfDF4318fa2+sJ95l4Ou6liKK+VIKqkazfMb
	XoDe2SP9WM6jDKbT6MVnvGwZ4yOaYIdNpkI/HxNV3+BLryIUjcWTxAKXlwr+Tb4w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtruqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 15:16:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IF4tS6019185;
	Thu, 18 Jun 2026 15:16:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1724bfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 15:16:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IFGmoo50135314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 15:16:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B407F20043;
	Thu, 18 Jun 2026 15:16:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0DE20040;
	Thu, 18 Jun 2026 15:16:45 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.31.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jun 2026 15:16:45 +0000 (GMT)
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
Subject: Re: [PATCH V2] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260607140245.95706-1-atrajeev@linux.ibm.com>
Date: Thu, 18 Jun 2026 20:46:33 +0530
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, shivani@linux.ibm.com, venkat88@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93D649E9-C919-43D3-A812-25D6C9605DB3@linux.ibm.com>
References: <20260607140245.95706-1-atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: oN5ochPhrt11UfsJK6g_4Y27ZFQfiJL4
X-Proofpoint-GUID: SpBU6xznXNzAHlKBMn9QUNt8EEaIqIDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzNyBTYWx0ZWRfXxod8C9vIYVeY
 S0fNbn3c6i810q/xE2a1A/9ht41bf8y99hUsfBD5vYce48mxQkp8ZZtp01SGOUH2WUrYPWGe77R
 246PkLyJH3l2m1Ii5BkXc3WvM3+I4JnSP8taMuLnlNhWJJxMYRbzIXz5jWzYCcVoi7OQ10EpK2L
 NL2re5nkWRW0n2d1raePUw5jqUrR5iAPmVtHTdvbz2X4AkrMm81LZ5sfCCaq1pwQiktoPhlIUSy
 l6V7fcXZx/Ka7paohye9yO4g0T26QvJ+8d2+1ViUmtsQlFC3L+tA91sKIBCKE5/hEf0P5pufIPm
 ln0YeuICyEnGw/hb4uysvhUz6xWjeF/7l9hWgBomq6linwK6xY504WlTrbJ1QneqpydcNROc41M
 /n5VP4J5HhdgOpvqd3MjddMeUGaXwCG0jzGHBpFQqpgphhMEH64Q6EDuFI/nkYK/I93C59Q0JSV
 osGdeQGF3sJUqduSzMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzNyBTYWx0ZWRfX7WHJ0l/CflIS
 BINOrKkt6cTyFsi4gpxUj/ZpolAhUmH2I5I+Nh7vaGNIAOZYskrCUpiGa3Jm4gXvqOyW5XWNge/
 rfP7jZC1n9QSWfwLITL90OU5SXXjXvY=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a340be6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x5QCPqNzQhPJdF4W:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=5G33EI8LH34GI3k0to8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180137



> On 7 Jun 2026, at 7:32=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> In redhat perftool testsuite, observed fail for this test:
>    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary =
(output regexp parsing)
>=20
> This led to analysis of "perf sched timehist" summary options.
>=20
>  # perf sched record -a -o ./perf.data -- sleep 0.1
>   This will record using perf sched record
>=20
> perf sched timeliest has two options "-s" and "-S"
>  # perf sched -i ./perf.data timehist -S
> -S : Captures summary also at the end
>=20
>  # perf sched -i ./perf.data timehist -s
> -s : Captures only summary
>=20
> The test saves -s result which has only summary and compares with
> summary which comes at the end from -S . Since there is a difference
> in these two, test fails.
>=20
> Checking the behaviour change in -S and -s results, difference is:
>=20
>                  rcu_sched[16]       2          4        0.013      =
0.001       0.003       0.006   33.23       0
>               migration/11[73]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
>                migration/3[33]       2          1        0.006      =
0.006       0.006       0.006    0.00       0
> -               :216753[216753]      -1          1        0.041      =
0.041       0.041       0.041    0.00       0
> +                 sleep[216753]      -1          1        0.041      =
0.041       0.041       0.041    0.00       0
>                migration/8[58]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>            NetworkManager[811]       1          2        0.089      =
0.028       0.044       0.060   36.06       0
>               migration/13[83]       2          1        0.005      =
0.005       0.005       0.005    0.00       0
>=20
> Here 216753 is pid for sleep which is a zombie process. This is
> happening in latest kernel due to an update in "-S" result.
> In -S, the process name appears in the results "sleep[216753]",
> where as in the -s, only pid is present in the summary result
> ":216753[216753]".
>=20
> After commit 39f473f6d0b2 ("perf sched timehist: decode process names
> of processes in zombie state")
> for -S option, if process name is using pid, it uses different way to
> set it. So that we get the process name and not just Pid.
>=20
> This change went in only for timehist_print_sample() function.
> Add this improvement in generic place so that even -s option (which
> captures summary) also will have meaningful information.
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog
> v1 -> v2:
> - Rebased on top of latest perf-tools-next
> - Since there is no change in logic, carried Acked-by from
> Namhyung Kim and Tested-by from Venkat Rao Bagalkote
>=20
> tools/perf/builtin-sched.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)

Hi,

Looking for comments on this patch

Thanks
Athira
>=20
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b7ccdc6a985d..5d3761a27e67 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2259,12 +2259,6 @@ static void timehist_print_sample(struct =
perf_sched *sched,
> printf(" ");
> }
>=20
> - if (!thread__comm_set(thread)) {
> - const char *prev_comm =3D perf_sample__strval(sample, "prev_comm");
> -
> - thread__set_comm(thread, prev_comm, sample->time);
> -        }
> -
> printf(" %-*s ", comm_width, timehist_get_commstr(thread));
>=20
> if (sched->show_prio)
> @@ -2965,6 +2959,16 @@ static int timehist_sched_change_event(const =
struct perf_tool *tool,
> thread__zput(itr->last_thread);
> }
>=20
> + /*
> + * If the process name is not set for the thread, use "prev_comm"
> + * to set it. Otherwise the sched summary will have just pid =
information
> + */
> + if (!thread__comm_set(thread)) {
> + const char *prev_comm =3D perf_sample__strval(sample, "prev_comm");
> +
> + thread__set_comm(thread, prev_comm, sample->time);
> + }
> +
> if (!sched->summary_only)
> timehist_print_sample(sched, sample, &al, thread, t, state);
> }
> --=20
> 2.52.0
>=20


