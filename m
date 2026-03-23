Return-Path: <linuxppc-dev+bounces-18626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B51EC01DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 12:19:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffXKK1MWfz2ySc;
	Mon, 23 Mar 2026 23:19:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774268357;
	cv=none; b=g2jCYUW6GZziR5ThXdKEIXdX+H6IROIANoNWtPERyXjhzXcz/br3cy/MNpalHMU4cos2JgvrXy+JDK9Ao3WcxPFw/5oDtT2AdFjwCLyT1GZJgqsFMhNzA+LmKDrtFOO2RL2n97xPy75EZwX7VXX5pnsOCrlhhqL5+W2o3QVVd3gg70jruCs2iMfAiNiJgt4IfZfF2waeohnIfJyw7bKsGZC/R0T5tWOR1sslkFpOgzFfTVDMxO+SDiSCLWd79oXYJVWTXm/rY5di9rQEEKtvwW80OkQZzXjugc7v5FJEXSC+HPnOk4Apxrd9IH4O8J4E2Lh1A3IIl5XPTuucOBr5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774268357; c=relaxed/relaxed;
	bh=BPmRPLaG9m4IUFbDU8qNklYFuDzI78vCH8hmr5+thZc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nTM7vZiyvHCfUY7kzTmxzJNz5eLqlPrvajTqJv8CzK83of3YmcD9f3kuwFKKROB3WJUZGqC3ynPrAn1MeCAX4tqwB8wwSvV+lD8mZudQlEHzp8T/B17BMprm6MYhNOSQrGImmpCJNaqTbNd+Qy5AYvlc+fXqCkvIOeAWe4ghaii4wStS6SAftCICTXGLAKjGOXi9Q4eVYTqVhoGOY1Wd5CjfGw1RnYqOad26Smsqv/R8enOrLWfKkgdlaYiax708dn5EZCQyxNnj2+UMSPraNWrTWxKTXiy396pU74YAyQoPl+C+AaJr7469DVwFofAVSy+p3vP9QvbMzyiXhmnY9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MAIw58J6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MAIw58J6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffXKH5BGgz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 23:19:15 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBJMPE4104871;
	Mon, 23 Mar 2026 12:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BPmRPL
	aG9m4IUFbDU8qNklYFuDzI78vCH8hmr5+thZc=; b=MAIw58J6WIfhGxLqXCIsXs
	mEuQD0/rxJgtqnpVVXvxmdGnFlimI3xkiOAEn5KRJRqD+/Rw5y83IXKPP2xv6x4F
	RK7gBJXYD/85UvHII4AiB7s1j4Wa6wSVBAFepizixVuLsbNTAQlHC+osT9EsnbTw
	jb2d6dlpzhiZQ19vi7FJlggLB+OOQCDckLzX0bsjkqk4W5kvHbB4/conXfRFCE5H
	MDhSOMQectPKt447cyaaSB1QOeGX8SX3EeGyP65UZirA0jZHdggrzC5PzCMwPWvA
	WmPB9OF9KyLybOISUDde13aMUpEonZnbkTiibT5ConVgSJfhDVvtLLG0jFOUGktQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq6qt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:19:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8gA2V004375;
	Mon, 23 Mar 2026 12:19:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1w0ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:19:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NCJ4Rm35127640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 12:19:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1A682004D;
	Mon, 23 Mar 2026 12:19:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B312004B;
	Mon, 23 Mar 2026 12:19:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.130])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 12:19:01 +0000 (GMT)
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
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <AD8DAAE1-50E9-45CD-AD81-D9DFF139B362@linux.ibm.com>
Date: Mon, 23 Mar 2026 17:48:49 +0530
Cc: Venkat <venkat88@linux.ibm.com>, jolsa@kernel.org, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C75E314-2038-4A76-BA4F-F36AE3F30B0B@linux.ibm.com>
References: <20260314083304.75321-1-atrajeev@linux.ibm.com>
 <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
 <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
 <AD8DAAE1-50E9-45CD-AD81-D9DFF139B362@linux.ibm.com>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DfzVb3pwluT6TT378xFqg5f5VYHC_7o7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NSBTYWx0ZWRfXyFoFjp2mBstr
 lRqcFxNlc2kssJuhu4wxZ9pPfeb3dl33SmR9mtmr1BKPTfuuwcvA2tyg8A5M9DDdY5YTfyB/sLT
 t0IHkzmIJGrcQBZEMyEVPvtG7rUynKrKcC9pEHQ0mdscntjl8/tInnBBHL3uEjIP+Wtstiswqou
 jlo8n757PfeW4aiRVXUlHwrJcX66Ag9CIwud+QGsaBIzof8qM+BBLG52UrtnLRtfccmqf7om/di
 vhvzEF+70I2Ujh2N2fprtrmHDM57RPQsnaeU1KAUufX/oyODJ+p1hGXNE+YJjYtZFHVMC7JZem9
 +/MEYeS4LDfRmyjO52+Cmfe6NT2fRLWgkTTcrChqvtc8SKdP4taAKEtIGdkfCtFrByvDURvrqjr
 hOah3q/x7TWs4fqozgAbyih2RieGqwc4C2msVQJlHEBpuZH0ZVTVzmF7AI8GnTbikCzEYAOl3ZO
 e0M/NiUIvoq5orGQFqQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c12fbe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=1OdA4DPBu-XEpwGrtEIA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: qheSxO-CKL7fRwCKVdkZim9ft0JUCBhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230095



> On 18 Mar 2026, at 12:05=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
>=20
>=20
>> On 17 Mar 2026, at 9:39=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>>=20
>> On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat =
<venkat88@linux.ibm.com> wrote:
>>>=20
>>>> On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>>=20
>>>> The format_alias() function in util/pmu.c has a check to
>>>> detect whether the event has parameterized field ( =3D? ).
>>>> The string alias->terms contains the event and if the event
>>>> has user configurable parameter, there will be presence of
>>>> sub string "=3D?" in the alias->terms.
>>>>=20
>>>> Snippet of code:
>>>>=20
>>>> /* Paramemterized events have the parameters shown. */
>>>>      if (strstr(alias->terms, "=3D?")) {
>>>>              /* No parameters. */
>>>>              snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>>>>=20
>>>> if "strstr" contains the substring, it returns a pointer
>>>> and hence enters the above check which is not the expected
>>>> check. And hence "perf list" doesn't have the parameterized
>>>> fields in the result.
>>>>=20
>>>> Fix this check to use:
>>>>=20
>>>> if (!strstr(alias->terms, "=3D?")) {
>>>>=20
>>>> With this change, perf list shows the events correctly with
>>>> the strings showing parameters.
>>>>=20
>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>=20
>> Thanks Athira, Sashiko is noting in its review:
>> =
https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux.ibm=
.com
>=20
> Thanks Ian for pointing this. Its interesting to see this review.
> I will check through the review.
>=20
> Thanks
> Athira
>>=20
>> By inverting this check, parameterized events now proceed to
>> parse_events_terms() and the rest of format_alias().
>>=20
>> If a parameterized event uses a built-in perf keyword for its =
parameter name
>> (e.g., config=3D?), the lexer parses it as a predefined term token, =
which sets
>> term->config to NULL.

Hi All,

sashiko brought up a scenario :

=E2=80=9CIf a parameterized event uses a built-in perf keyword for its =
parameter name
(e.g., config=3D?), the lexer parses it as a predefined term token, =
which sets
term->config to NULL."

Existing usage for parameterized events in perf:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In perf,  =E2=80=9C?=E2=80=9D is often used in event aliases to indicate =
that a parameter needs to be provided=20
by the user (e.g., param1=3D?). This information is exposed via =
=E2=80=9Cformat=E2=80=9D in sysfs too.  The current way,=20
how this is consumed in different PMU drivers is: example:

  # cat /sys/devices/pmu/format/param1
    config:12-15

   # cat /sys/devices/pmu/format/param2
    config1:0-17

Here param1 uses bits 12:15 in config and param2 used bits 0:17 in =
config1

And event will use these parameterized fields:
    #cat /sys/devices/pmu/events/event1       domain=3D1,param1=3D?,param2=
=3D?

=E2=80=9CPerf list=E2=80=9D expects "param1=3D?,param2=3D?=E2=80=9D In =
the event listing
   # perf list|grep event1
   pmu/event1,param1=3D?,param2=3D?/                       [Kernel PMU =
event]

The patch here address fix in =E2=80=9Cstrstr=E2=80=9D check in =
format_alias for =E2=80=9Cperf list=E2=80=9D to display these user =
expected =E2=80=9C?=E2=80=9D fields
in event alias.  Traditionally, perf treats config, config1, and config2 =
etc as hardcoded numeric
keywords or builtin keyword.=20

The scneario sashiko brought up is interesting. Where a parameterized =
event
uses a built-in perf keyword  for its parameter name.

sashiko review : Scenario where parameterized event uses a built-in perf =
keyword=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Example, having =E2=80=9Cconfig2=E2=80=9D in sysfs format-driven logic. =
Below is an example case.

    #cat /sys/devices/pmu/events/event1
     config2=3D?,domain=3D1,param1=3D?,param2=3D?

      # cat /sys/devices/hv_24x7/format/config2        =20
         config2:0-16
 =20
 Here =E2=80=9Cperf list=E2=80=9D will show as (null) or might crash too =
as sashiko review pointed out.

    # perf list|grep event1
    pmu/event1,(null)=3D?,param1=3D?,param2=3D?/                    =
[Kernel PMU event]

This is because term->config is null for built-in keywords. perf lexer =
sets this to NULL
for predefined keywords ( like 'config', 'period'), storing the type in =
the enum instead.

To fix displaying the =E2=80=9C=3D?=E2=80=9D in =E2=80=9Cperf list=E2=80=9D=
 for keywords like config2,  format_alias() function needs to handle
null term->config , ie by using parse_events__term_type_str() to map =
NULL config=20
pointers back to their string keywords

But this only will fix the =E2=80=9Cperf list=E2=80=9D part of it.  =
=E2=80=9CPerf stat=E2=80=9D or record will still fail since
currently these keywords are not considered as placeholders for =E2=80=9C?=
=E2=80=9D values.

If a PMU wants to use any builtin-keywords in parameters and want to =
ensure
it is set by user, this could be useful.  Again considering this as a =
use case, we need other changes
to allow these built-in keywords to function as placeholders (e.g., =
config2=3D?) within a PMU alias.

I am adding changes which I have identified needed for this support.
If it is better to post this separately as patch set and discuss, =
definitely will do that.
I wanted to run the idea of this new scenario with everyone. Apologies =
for the long text.

Thanks and looking for comments.=20


=46rom 21179a76be97ef81c69a9492f0f432dec5b5361c Mon Sep 17 00:00:00 2001
From: Athira Rajeev <atrajeev@linux.ibm.com>
Date: Mon, 23 Mar 2026 08:38:30 -0400
Subject: [PATCH] tools/perf: Enable parameterized values for keywords =
like
 config1

PMU defines events that require user-supplied parameters (like chip
or core) are packed into specific bit-fields of the different config
registers. Traditionally, perf treats config, config1, and config2
as hardcoded numeric keywords, causing it to bypass the sysfs
format-driven bit-masking logic.

This patch allows these built-in keywords to function as placeholders
(e.g., config2=3D?) within a PMU alias.

Changes includes:
- Updated config_term_pmu in parse-events.c to recognize string
  placeholders for event terms. otherwise it will expect those to
  be of type PARSE_EVENTS__TERM_TYPE_NUM
- Updated pmu_config_term in pmu.c to make sure if keywords are used
  as placeholders , they pass through sysfs based format logic
 (pmu_find_format) and pmu_resolve_param_term() logic
- Modified format_alias() to ensure "perf list" display the =
parameterized
  events correctly
- Replace snprintf with scnprintf in buffer offset calculations to
   ensure the 'used' count will not exceed the "len"

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/parse-events.c |  5 +++++
 tools/perf/util/pmu.c          | 37 +++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c =
b/tools/perf/util/parse-events.c
index b9efb296bba5..282b0a0a5340 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1051,6 +1051,11 @@ static int config_term_pmu(struct perf_event_attr =
*attr,
                 */
                return 0;
        }
+
+       if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR && =
term->val.str)
+               if (strstr(term->val.str, "?"))
+                       return 0;
+
        return config_term_common(attr, term, parse_state);
 }

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..2c4503e1a11b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1442,10 +1442,19 @@ static int pmu_resolve_param_term(struct =
parse_events_term *term,
                                  __u64 *value)
 {
        struct parse_events_term *t;
+       const char *name =3D term->config;
+
+       if (!term->config)
+               name =3D parse_events__term_type_str(term->type_term);

        list_for_each_entry(t, &head_terms->terms, list) {
+               const char *t_name =3D t->config;
+
+               if (!t_name)
+                       t_name =3D =
parse_events__term_type_str(t->type_term);
+
                if (t->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM &&
-                   t->config && !strcmp(t->config, term->config)) {
+                   t_name && name && !strcmp(t_name, name)) {
                        t->used =3D true;
                        *value =3D t->val.num;
                        return 0;
@@ -1453,7 +1462,7 @@ static int pmu_resolve_param_term(struct =
parse_events_term *term,
        }

        if (verbose > 0)
-               printf("Required parameter '%s' not specified\n", =
term->config);
+               printf("Required parameter '%s' not specified\n", name);

        return -1;
 }
@@ -1494,6 +1503,7 @@ static int pmu_config_term(const struct perf_pmu =
*pmu,
        struct perf_pmu_format *format;
        __u64 *vp;
        __u64 val, max_val;
+       const char *name;

        /*
         * If this is a parameter we've already used for =
parameterized-eval,
@@ -1507,7 +1517,8 @@ static int pmu_config_term(const struct perf_pmu =
*pmu,
         * traditionally have had to handle not having a PMU. An alias =
may
         * have hard coded config values, optionally apply them below.
         */
-       if (parse_events__is_hardcoded_term(term)) {
+       if (parse_events__is_hardcoded_term(term) &&
+                      term->type_val !=3D PARSE_EVENTS__TERM_TYPE_STR) =
{
                /* Config terms set all bits in the config. */
                DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);

@@ -1576,7 +1587,11 @@ static int pmu_config_term(const struct perf_pmu =
*pmu,
                return 0;
        }

-       format =3D pmu_find_format(&pmu->format, term->config);
+       name =3D term->config;
+       if (!name)
+               name =3D parse_events__term_type_str(term->type_term);
+
+       format =3D pmu_find_format(&pmu->format, name);
        if (!format) {
                char *pmu_term =3D pmu_formats_string(&pmu->format);
                char *unknown_term;
@@ -2117,7 +2132,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
                                                   skip_duplicate_pmus);

        /* Paramemterized events have the parameters shown. */
-       if (strstr(alias->terms, "=3D?")) {
+       if (!strstr(alias->terms, "=3D?")) {
                /* No parameters. */
                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
                return buf;
@@ -2129,15 +2144,19 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
                pr_err("Failure to parse '%s' terms '%s': %d\n",
                        alias->name, alias->terms, ret);
                parse_events_terms__exit(&terms);
-               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
+               scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
                return buf;
        }
-       used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);
+       used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, =
pmu->name, alias->name);

        list_for_each_entry(term, &terms.terms, list) {
+               const char *name =3D term->config;
+
+               if (!name)
+                       name =3D =
parse_events__term_type_str(term->type_term);
                if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
-                       used +=3D snprintf(buf + used, sub_non_neg(len, =
used),
-                                       ",%s=3D%s", term->config,
+                       used +=3D scnprintf(buf + used, sub_non_neg(len, =
used),
+                                       ",%s=3D%s", name,
                                        term->val.str);
        }
        parse_events_terms__exit(&terms);
--  2.47.3



Thanks
Athira

>>=20
>> Does this cause a NULL pointer dereference in the term iteration =
loop?
>>=20
>> list_for_each_entry(term, &terms.terms, list) {
>> if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
>>   used +=3D snprintf(buf + used, sub_non_neg(len, used),
>>     ",%s=3D%s", term->config,
>>     term->val.str);
>> }
>>=20
>> Passing a NULL pointer to the %s format specifier for term->config =
might
>> cause a segmentation fault or formatting corruption.
>>=20
>> Can this also lead to a stack buffer overflow due to how snprintf() =
return
>> values are accumulated?
>>=20
>> snprintf() returns the number of characters that would have been =
written.
>> If the event names and terms are long enough, the "used" variable can =
exceed
>> "len" (which is typically 1024 bytes).
>>=20
>> When evaluating "buf + used" in the same loop:
>>=20
>> used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);
>>=20
>> If "used" exceeds 1024, this creates an out-of-bounds pointer. Modern
>> compilers can use this undefined behavior to infer that "used" <=3D =
1024
>> must be true, which optimizes out the safety check inside =
sub_non_neg():
>>=20
>> static int sub_non_neg(int a, int b)
>> {
>> if (b > a)
>>   return 0;
>> return a - b;
>> }
>>=20
>> The compiler can reduce this to simply "a - b" (or "len - used").
>> If "used" is actually greater than 1024, "len - used" evaluates to a
>> negative integer. This negative value is implicitly cast to size_t =
for
>> snprintf(), resulting in a massive size limit.
>>=20
>> Would this cause snprintf() to write past the end of the stack buffer
>> without bounds checking? Using scnprintf() might prevent "used" from
>> exceeding "len".
>>=20
>> Thanks,
>> Ian
>>=20
>>>> ---
>>>> tools/perf/util/pmu.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>> index 23337d2fa281..0b8d58543f17 100644
>>>> --- a/tools/perf/util/pmu.c
>>>> +++ b/tools/perf/util/pmu.c
>>>> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>>>> skip_duplicate_pmus);
>>>>=20
>>>> /* Paramemterized events have the parameters shown. */
>>>> - if (strstr(alias->terms, "=3D?")) {
>>>> + if (!strstr(alias->terms, "=3D?")) {
>>>> /* No parameters. */
>>>> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>>>> return buf;
>>>> --
>>>> 2.47.3
>>>>=20
>>>=20
>>> Tested this patch, and its working as expected.
>>>=20
>>> Before Patch:
>>>=20
>>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>>> hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU =
event]
>>>=20
>>> After Patch:
>>>=20
>>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>>> hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
>>>=20
>>>=20
>>> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
>>>=20
>>>=20
>>> Performance counter stats for 'system wide':
>>>=20
>>>       2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
>>>=20
>>>    229.938231314 seconds time elapsed
>>>=20
>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>=20
>>> Regards,
>>> Venkat.



