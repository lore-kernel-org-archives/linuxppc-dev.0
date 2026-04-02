Return-Path: <linuxppc-dev+bounces-19224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5184D6AAE7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 15:46:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmmRl0hk8z2xls;
	Fri, 03 Apr 2026 02:46:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775144786;
	cv=none; b=LD8z7tzTnqH082nBnYxli+RKnorPnEYvqnSRA2to4BRhnSO2rKlSMtZHiBztTZA8AioI2v022xlGuPwmH1Fng+JCJ+tvTDBrjmLumThryBS3Z+Kep5se4qAMysYuIZL8nsDYW9hKAwKgcKHV5Av1DNXMJfdwi2v49KtjPf2jTNZYG5TdrGh9QFm/DfxY6ocw0qAxTXM6Rkm/7Xv+SKfCT6o2/RIHR4yMfizt8nNsUbvQpvNeTWUtgkcWBmXZXjZqXUPibj72anbhAIfsyjicgcdRMDdxBKxjkBHRMmm6lL4zE6enuEu9VZq/dHh1Kd491GHkzgw4sskfaO346jTa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775144786; c=relaxed/relaxed;
	bh=csUms11w8sD4yrK8bQgpBN2NcH1O2zwmQoS2J7SG/tI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aRyaQhH3ZgUrgimx6fTsO1UYOTTy9I4CMmiW3eIqYVvNwYpN3BpuiVPuAilqyszACDS7+ErIG2YXLjSV8XNx26mEQshACrf/9TkDDIjhtPjAzTaUnkHpiFdhIuEfg2HTbZOcSPI77fYqFRXCnkYlM3vjdkH2FKHb46nMEka2nj1ADW5Rr1CrVnDMNTYXNb+pUz2+6HyNjqxbIVqO/XN2nB5AYmYRnE5t+lMQtiATqSMP/dS12YwX5adyA29Sl+QuV3ReSqnuaFIfjL5XgMn+CWtJPyOsUT1V5IYGcwkIcn34dEdwUq/sOp9iwLlYGMu9Nte5c5hGOX0weKJ0AMR5Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NXQej2T7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NXQej2T7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmmRj4HwCz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 02:46:24 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632EVRq2330917;
	Thu, 2 Apr 2026 15:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=csUms1
	1w8sD4yrK8bQgpBN2NcH1O2zwmQoS2J7SG/tI=; b=NXQej2T7cFXN0bx3k4Cet5
	iHcuFWOupXTcg0Tb+5x/txMcI3MqKavNTWxI1Ndr29GcQe62cIQlIGeeQIBAVw1y
	Lc3Rh4SNh7Bc9i6SIQfl1CyKpDhGuYZS2/C8Dt6aRrnKEmCH/KEr2H/q2OlUJ7OV
	5uuVpgItDI0icbur9r0BEJVrMa1afjxXrLH5adxruJoAnVw9hxCWhpyjQ1j80s+G
	+o+kqApQqzoUxXuLFGw4xI96YWRRrsYgQnMGpSP8Sh1vcRQy+BWQSSLhJZRsy7mM
	0efrMSnji3lI/p0XFzdEv5Wq773FX2zRjpTMj01VlJ4ZOiIxvX8VrOxz89fTdvwg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgvq3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:46:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632D0oNp008689;
	Thu, 2 Apr 2026 15:46:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11tcw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:46:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632FkDN649742308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:46:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EA1B2004F;
	Thu,  2 Apr 2026 15:46:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DBEA2004D;
	Thu,  2 Apr 2026 15:46:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.17.92])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Apr 2026 15:46:08 +0000 (GMT)
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
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fX6993MzAEgB7JeVEU5GcVk3PxhkEjMX3G4EZgxPBaBqg@mail.gmail.com>
Date: Thu, 2 Apr 2026 21:15:54 +0530
Cc: Venkat <venkat88@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>,
        acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A33EEA7D-DB03-4FA9-A0A8-D10115FEF423@linux.ibm.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ac2uvTXI1iknXwyV@google.com>
 <CAP-5=fX6993MzAEgB7JeVEU5GcVk3PxhkEjMX3G4EZgxPBaBqg@mail.gmail.com>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzOCBTYWx0ZWRfX0/oM6SGp1s8u
 IFKpwXJJu5HYy55U4H2OydF6kJSc6ZrbcOHRvHIi/g0EW+sM2hxtrfPQalBldLdLSI+TiLFBcte
 WWdTw1DkDlJ8+45/ITrtN2++RaziZvUtrptEnxBxmVJK2wiMMYUF4erfEvY++VJUtGkzLHtjiDM
 AFbdJHtwxPTkzkdpc8DQM9uVr1JUjVooHJ4utHnT8iBRXZ0EcuE5zbId0l1IMMfA/PSYkOXo3KS
 aMjs6YVmGvpgzy9U4Ec8iIRLwpC2FpLSQfdQVLRoB4X6UAscqltpP/fKCzCK4m1+Rnr6mpF9uWA
 B16wbaoRGrl35HvnYfLt+10N3RcgXHCpnrRDSIxVQIoZmeqUfU5iDCy9ognizAxDW2FFZBbOUso
 QspfdLKQR69MfBixNKyqkSDkYRnhEbF4uQGlGGHpNWlWm9usEEx57YLN/VcupwS8079V9aCa408
 +NQk894THyCuavdznAg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ce8f4a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=5P6_zFFMFuBFcQzlmxgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ELZTcBwiiz92CdProDJUwfuPWyYx91Gr
X-Proofpoint-ORIG-GUID: NBYhbLeaYpwzozA_h9oOJXCh9G9ez-Aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020138



> On 2 Apr 2026, at 5:27=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Wed, Apr 1, 2026 at 4:48=E2=80=AFPM Namhyung Kim =
<namhyung@kernel.org> wrote:
>>=20
>> On Wed, Apr 01, 2026 at 01:40:47PM -0700, Ian Rogers wrote:
>>> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?
>>=20
>> Are you ok with the change itself then?
>>=20
>> I'm not sure what's the expectation when the test runs with a regular
>> user.  I assume the intention of this change is running as root..
>=20
> So the test is failing as root on Intel, and the log output is
> extensive. I'd prefer not to have the log output, so we may need to
> work past some known broken items. Otherwise, the change looks okay,
> but there are inconsistencies: `grep -q "<not supported>"` is used in
> the existing code, while `grep -q "not supported"` is used here.
>=20
> Thanks,
> Ian
>=20
>> Thanks,
>> Namhyung
>>=20

Hi Namhyung, Ian

Thanks for trying the change and responding.

Sorry, I missed the comment from Sashiko. Next time I will check =
explicitly for Sashiko comments too.

The intention of this patch has two things:

1) It was resulting in =E2=80=9Cfalse pass=E2=80=9D earlier if the test =
fallback to last check where we run with longer workload. Because error
  message contains the event name =E2=80=9C$p=E2=80=9D and hence matches =
the =E2=80=9Cgrep=E2=80=9D check.=20

Example:

   # ./perf stat -e hv_24x7/CPM_ADJUNCT_PCYC/ ./perf bench internals =
synthesize
    event syntax error: 'hv_24x7/CPM_ADJUNCT_PCYC/'
                     \___ Bad event or PMU

    Unable to find PMU or event on a PMU of =E2=80=98hv_24x7'
    Run 'perf list' for a list of valid events

    Usage: perf stat [<options>] [<command>]

        -e, --event <event>   event selector. use 'perf list' to list =
available events
  # echo $?
     129


Here the test checks for :
  <<>>
   output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
   if echo "$output" | grep -q "$p=E2=80=9D
  <<>>

Since the error message contains the event name, it matches grep check =
and declares test as pass.

 To catch this, patch adds a check for =E2=80=9Creturn code=E2=80=9D=20

+  # checked through possible access limitations and permissions.
+  # At this step, non-zero return code from "perf stat" needs to
+  # reported as fail for the user to investigate
+  if [ $stat_result -ne 0 ]
+  then
+    echo "perf stat failed with non-zero return code"
+    err=3D1
+    continue
+  fi

2) If events are supported in system wide monitoring.=20

Namhyung is right here that for regular user it will result in fail . I =
will take care of having check around that.
The reason for using =E2=80=9Cnot supported=E2=80=9D text here is:

Example: There is an event in powerpc "vpa_dtl/dtl_all/=E2=80=9C which =
when run on per thread monitoring:

 # ./perf stat  -e vpa_dtl/dtl_all/ true
    Error: =20
    No supported events found.
    Unsupported event (vpa_dtl/dtl_all/H) in per-thread mode, enable =
system wide with '-a=E2=80=99.

Next running with system wide monitoring:

  # ./perf stat -a -e vpa_dtl/dtl_all/ true
     Error:
     No supported events found.
     The sys_perf_event_open() syscall failed for event =
(vpa_dtl/dtl_all/H): Operation not supported
     "dmesg | grep -i perf" may provide additional information.

This is because this event is supported for only =E2=80=9Csampling=E2=80=9D=
 system wide and not counting.=20
So patch attempts to use =E2=80=9C-a=E2=80=9D, if still it fails, we =
look for =E2=80=9Cnot supported=E2=80=9D in logs

Namhyung, Ian,

If the addition of =E2=80=9C-a=E2=80=9D can cause regression ( like =
intel one if its not suppose to be run system wide ),=20
how about adding a case like this:
- Look for "enable system wide with '-a=E2=80=99 =E2=80=9C in the error =
logs
	- If logs matches this message and if user is root, attempt with =
-a next.
       - With =E2=80=9C-a=E2=80=9D, If the logs has "Operation not =
supported=E2=80=9D , test can continue to next event.

Thanks
Athira



