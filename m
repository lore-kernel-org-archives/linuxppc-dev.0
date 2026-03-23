Return-Path: <linuxppc-dev+bounces-18623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2D4EC01C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:40:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffV706CV7z2ySc;
	Mon, 23 Mar 2026 21:40:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774262412;
	cv=none; b=ihrCmm1A5esSlEi2B37uRJqYGEDtmGCW9eE0F1nadPv29fuKyOCeHLIXflCtkzRiQH1UkaChcGsQ4gjuMPaHEeiL9XQitnb9MOCc7kU9PcEooo/8FJUjSIn0pZd61pciLAAWPi2w29g94bYqJtCCKB94MP0QNIk0owe1yKOqVJ9g1UKh5L9uXGKjc/VGmrUaIwvAiF9Tjoyq0IFO2vHVUK+5OK+iLzloFDUVOgDRZESAQ2krc9mApP5/qciF4EZIyg8hKlJ4WE7F7L8VB+sHYVpYlGFRNzb7ZAxHPGsMvdzM+wrGwz0rLlgvkWICQDokZUlzGwEioQ9GyQZ7j7Faog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774262412; c=relaxed/relaxed;
	bh=q9+k3AWLO9c6QlrxhipUsA5HMEqJR/AhKnlNvWBHzXE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PnCyIyMUcUJXZDNBeT1LcGPApaiV1DFvAxXwhBhSeQXg73dURMvZwqErYb2FMjzIr7lO6xSLn7rkvHD2KK31bMmwR/rc0GDV0bwhe6RBxvhQe2xMQrxmg4pwk0L9KxpIWOFreWdyX+arr9m3s6qcdCpUYRASLOt6sn6oMR+3o2zUCaW6qiQZrhxpe9D/vDzgtIkB+wM0WMA0U007kQ1bsKKJYT04JqP6XRegYHe7RSpxyaTFUrhtLCSVsiQBuxJI4FvCNYZgS0uNhyzxUi8Ze19+gZzMs6MPQZBopx/iFUl+5PM6nbcJGBZvHGskIXYVvg9qi3FUek9VwvBYTmgMOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RHbH5KWm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RHbH5KWm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffV6z6gy9z2xN5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 21:40:11 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MB0KH33743898;
	Mon, 23 Mar 2026 10:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q9+k3A
	WLO9c6QlrxhipUsA5HMEqJR/AhKnlNvWBHzXE=; b=RHbH5KWmSKcicGZB7z0xq/
	nlrlZe6zDY84wSgS2eMUztTRCqv/SOko9Cxn7YJeca0q4d2v0GEZ4+DADGxuGWHW
	5IRjuTxfKdiz/YVs8WeDW6fFO7r3PemZocT8f8b+RobHJr+nE3EXFPAn4bywziRG
	Sn1AAdWFkL+vwupWS7zLJURyf7lC5jdr5jRlipMWP3GADM3f4arOO/bjlOXyj1XZ
	P93RWjgIOkbqfglDtdeHGdisatWVytYnhVoLYa894cO2OfjtMxnGVFg8mcXuiE0I
	/irGsyLFDNQE0590eYCgTG+/hq0yYJ49zmJeEgcv7yjqU6aEqNxzkHUfgtAeWycg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq6dun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:40:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6k6pm005972;
	Mon, 23 Mar 2026 10:40:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yd3rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:40:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAdwiC30540358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:39:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557D95806D;
	Mon, 23 Mar 2026 10:39:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8715558071;
	Mon, 23 Mar 2026 10:39:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.247.60])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:39:52 +0000 (GMT)
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
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260315105751.86835-1-atrajeev@linux.ibm.com>
Date: Mon, 23 Mar 2026 16:09:37 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OwuymmdhRHIngyHBs7YgYfHB2jyl0vao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX1jsXhTpSrWlu
 X+LbElu5PX3lwXZVSJUaVZq6cktxAP10QhulC+G0dOg+R+TjzIgZpazVdlgC7cZ80+6UPVidiCj
 lkX65yQ9FA8tXRm5DIWsTtTc5kBI8CHLBGj4aysM5TUKkkzSk8vsN3623vGWXACi1Y800fQfi6g
 6t0SmjqMde18pqordd1p+hTBPn6xWQ79BiLGNjrMaYuIZG8KqO0Zcq22+0CX7RN7QLmJanKcndm
 n5wGmmWoOr0q8LnB3j7tXtQtcjitxqN8JH0QnKe5E5G9ac343osAvosOgqF41DQI4U2uzY8RPI4
 3Wa/MowRYEMlJUzBZQLB//O7pIgqNC8qxK5nfzIlZrTxnaqSdgRumW6E0e6Hbj06rCkIU3Z6K0p
 Er0IBJPKZVy5+xO8mg/40LQEt+0h8zKcwBLDl+tcJG121oTDI1Uips7MUvxaP9S7PPKg4gnxd+q
 K7yLf35WfqZ0ukiIbtg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c11883 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=AKmARop12Lt_5Hk6sGkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hIYsh4in3Phv7Mx4sKL0uhTvKdtyS6Cw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230080



> On 15 Mar 2026, at 4:27=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> Currently in "perf all PMU test", for "perf stat -e <event> true",
> below checks are done:
> - if return code is zero, look for "not supported" to decide pass
>  scenario
> - check for "not supported" to ignore the event
> - looks for "No permission to enable" to skip the event.
> - If output has "Bad event name", fail the test.
> - Use "Access to performance monitoring and observability operations =
is
>  limited." to ignore fail due to access limitations
>=20
> If we failed to see event and it is supported, retries with longer
> workload "perf bench internals synthesize".
> - Here if output has <event>, the test is a pass.
>=20
> Snippet of code check:
>  ```
>  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>  if echo "$output" | grep -q "$p"
>  ```
> - if output doesn't have event printed in logs, considers it fail.
>=20
> But this results in false pass for events in some cases.
> Example, if perf stat fails as below:
>=20
> # ./perf stat -e pmu/event/  true
> event syntax error: 'pmu/event/'
>                     \___ Bad event or PMU
>=20
> Unable to find PMU or event on a PMU of 'pmu'
> Run 'perf list' for a list of valid events
>=20
>  Usage: perf stat [<options>] [<command>]
>=20
>    -e, --event <event>   event selector. use 'perf list' to list =
available events
> # echo $?
> 129
>=20
> Since this has non-zero return code and doesn't have the
> fail strings being checked in the test, it will enter check using
> longer workload. and since the output fail log has event, it
> declares test as "supported".
>=20
> Since all the fail strings can't be added in the check, update
> the testcase to check return code before proceeding to longer
> workload run.
>=20
> Another missing scenario is when system wide monitoring is supported
> example:
> # ./perf stat -e pmu/event/ true
> Error:
> No supported events found.
>  Unsupported event (pmu/event/H) in per-thread mode, enable system =
wide with '-a'.
>=20
> Update testcase to check with "perf stat -a -e $p" as well
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---

Tested this patch.


With this patch:

Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero =
return code
Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero =
return code



Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.



> tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>=20
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh =
b/tools/perf/tests/shell/stat_all_pmu.sh
> index 9c466c0efa85..6c4d59cbfa5f 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -53,6 +53,26 @@ do
>     continue
>   fi
>=20
> +  # check with system wide if it is supported.
> +  output=3D$(perf stat -a -e "$p" true 2>&1)
> +  stat_result=3D$?
> +  if echo "$output" | grep -q "not supported"
> +  then
> +    # Event not supported, so ignore.
> +    echo "not supported"
> +    continue
> +  fi
> +
> +  # checked through possible access limitations and permissions.
> +  # At this step, non-zero return code from "perf stat" needs to
> +  # reported as fail for the user to investigate
> +  if [ $stat_result -ne 0 ]
> +  then
> +    echo "perf stat failed with non-zero return code"
> +    err=3D1
> +    continue
> +  fi
> +
>   # We failed to see the event and it is supported. Possibly the =
workload was
>   # too small so retry with something longer.
>   output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> --=20
> 2.47.3
>=20


