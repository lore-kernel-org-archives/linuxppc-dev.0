Return-Path: <linuxppc-dev+bounces-18936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA28B10F2863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 17:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj7dV28x0z2xmX;
	Sat, 28 Mar 2026 04:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774634238;
	cv=none; b=Slz+/tKRRxeFdvBbfKSAPcp5gIXzqAvYPqP/xlEBoCBNZa0+a61d0j/ltMcFzGwma13ula+zg1GvnGWGFP6SgpsIwDeIz++F/QSoJELO41Jc+sRDKfkhZln6gLbKUcalocBnH9pi0tzmCZ0Zf3+2dHv/HCeQIXY8sHWTMbSQBTKlFgOzIzkqYj45mixKyjh0sOkka1/FXmlZYRYtk7htdghe+jcsjoi6JNrzICOjGgwLyzRoU54zkPGQEpeLrn+M/8vExzes+XGVFZmheixf0y6vPLreAOdruVT6iAqH6SYehxHT+mcIY6awBKHUPDODYu5Ni+k5w7C5/hGmz/TIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774634238; c=relaxed/relaxed;
	bh=KWvxAKIn1mg7ZsC2kQgIAMarMuSPnc3PTW2t0Os0tHs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=b8NW6Nd10BsZs5kfTS2X082Hyvup3LJavhBQ434aJ63SfgCCu5q9ULfI5n33qo2rnOr9r2+3ag40Ik+y3N98A890ga/PRLiS2quBEirPaIE2VHhjEDZOEG01A6LICP7Hkokm3juLzhygMaH3XvAZ4MUHDa30Q0AyrhlqkYwTBSLOkNr3vXtiRiLoiHWdUXZuB3ucs8FRC+nWS8HZIBiiag/+wZjgRMIyQBjiJiwip2b38k1T+mElkrgkFe4tnVs8hDaun9jTKPmcGjU3JsNzcgkNqgYypLyxy/oOPP9TwD80KIOa91z31e3HRGUl8pkVE1irWoM4MSZadE4rimgm+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=APeqX8SO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=APeqX8SO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj7dT2Xtqz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 04:57:16 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RDJTKv194143;
	Fri, 27 Mar 2026 17:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KWvxAK
	In1mg7ZsC2kQgIAMarMuSPnc3PTW2t0Os0tHs=; b=APeqX8SO/0aNBHcKHTY1Ny
	p8R+gd0AI1UhIvR6L3obp/wuUjcBxW/wp7O2xQ1b2w0rj4PoNDkbdRzUS9Ds0WST
	8zOGK5jSixyGO3f9xcF1/2PhAek9jnD+vvcC3IqzUcfwrDQ9frTkKl4rZuGB+tH4
	4A1Bsl0c6OvaubQxRCISrzIHceeSVJiv+JbjKGIoZRkM9OYVBfh5vOHic058NyTY
	xo3R6O7bVUXYY+CiGyWToPBQUHO+NIAtShIWTSuIt3iHld5KyyyU704eL6LwML8F
	XYh3bZvgSgD5p2Doz5SKA0G9CaiFAJWTzG7T1oYYrFb3ZR5Y+DbaPxbxjvGh1FVw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktybfjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 17:57:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RErlr7005996;
	Fri, 27 Mar 2026 17:57:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26200q02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 17:57:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RHv3qB12321096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 17:57:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC7820040;
	Fri, 27 Mar 2026 17:57:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B470B20043;
	Fri, 27 Mar 2026 17:57:00 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.208.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Mar 2026 17:57:00 +0000 (GMT)
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
Subject: Re: [PATCH V2] tools/perf/tests: Update test_adding_kernel.sh to
 handle proper debuginfo check
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <acW9tz0KZWgaJjTV@google.com>
Date: Fri, 27 Mar 2026 23:26:48 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E20DA19-2C2A-45EC-A2AA-7C05CE89C4FE@linux.ibm.com>
References: <20260323122424.88068-1-atrajeev@linux.ibm.com>
 <acW9tz0KZWgaJjTV@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c6c4f5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=36Hm3MojdHijgLfdx7wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyMyBTYWx0ZWRfX6kpRY9H3deNa
 f3S9VVmWbfB5eJV5k5ZEGsSDTIePrdH5VQBtcgcdzgIRYCrFtj2JwT8ZiU9+p8eCwXhXp0q+Q/r
 bWshhBJBf1d6PCOvIUYyLOVHneXBGGIzNVqoPfh+1RrrLGTXUqW8j6TBvSh+8dNZ1a3c3LL8noW
 Oh0/kWheu9dYHx3edPFNsPbCFcZpFKITCKXQgHnJoYpH413AbhQY/BtcjFNGvaotYVGJxO7UEPV
 6qiXiLsR4/CqQK5EiyXbfN3tnH2WW73EOXio8pQjagWnDD6D4wFxN7JnTtaMulnyoMk/K8Yd77I
 lYLyV4iXymR1qjLpRDCeAYzyp8rFPyBZgM5gFIH8Su3Y4xGHPTqUxAW5E5AawyZvmzxxCwWeIIQ
 7nddsD9jxxsjnKeYL4NjVRDDuY82c54c14J/YxVvcJ64VKKrLt+rzjAhJH8rvjKnn+BueO8K3gq
 qMrfCOfwGOmQvTvAZGQ==
X-Proofpoint-GUID: 22rq_JJl9ZW-1bKW9IhRJx4aakYTV052
X-Proofpoint-ORIG-GUID: X-j0dFSJcJQ5OuUaI9NlB3JbeB5oHD3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270123



> On 27 Mar 2026, at 4:43=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Mon, Mar 23, 2026 at 05:54:24PM +0530, Athira Rajeev wrote:
>> Perf test perftool-testsuite_probe fails as below:
>>=20
>> Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on =
inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added =
probe :: perf probe -l (output regexp parsing)
>> -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple =
probes
>> Regexp not found: "probe:vfs_mknod"
>> Regexp not found: "probe:vfs_create"
>> Regexp not found: "probe:vfs_rmdir"
>> Regexp not found: "probe:vfs_link"
>> Regexp not found: "probe:vfs_write"
>> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding =
support (command exitcode + output regexp parsing)
>> Regexp not found: =
"somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>> Regexp not found: "in this function|at this address"
>> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing =
variable (output regexp parsing)
>> ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures =
found
>>=20
>> Further analysing, the failed testcase is for "test_adding_kernel".
>> If the kernel debuginfo is missing, perf probe fails as below:
>>=20
>> perf probe -nf --max-probes=3D512 -a 'vfs_* $params'
>> Failed to find the path for the kernel: No such file or directory
>>  Error: Failed to add events.
>>=20
>> skip_if_no_debuginfo has check to handle whether debuginfo is present
>> and the testcase checks for debuginfo since this :
>> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
>> testcases fail when kernel debuginfo is not present")
>>=20
>> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
>> via this another fix:
>> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no =
suitable
>> line detected")
>> Since this commit, first add_probe_vfs_getname is used to prevent =
false
>> failures. And based on return code of add_probe_vfs_getname, =
skip_if_no_debuginfo
>> is used to skip testcase if debuginfo is present. And this modified =
other
>> testcases to call add_probe_vfs_getname first and invoke
>> skip_if_no_debuginfo based on return value.
>>=20
>> The tests in test_adding_kernel.sh which depends on presence of
>> debuginfo are:
>> 1. probe add for inode_permission
>> 2. probe max-probes option using 'vfs_* $params'
>> 3. non-existing variable probing
>>=20
>> For these tests, probe check for specific line is not required.
>> So call skip_if_no_debuginfo with argument to say if line check is
>> needed. This is to convey to skip_if_no_debuginfo() function
>> that test only needs to check for debuginfo, and not specifically
>> line number. Update skip_if_no_debuginfo to use simple "perf probe"
>> check if test only needs to check for debuginfo. And for other
>> tests which rely on line number, use add_probe_vfs_getname()
>>=20
>> With the change, verified that only three which required debuginfo =
only
>> is skipped and others ran successfully. Also tested with debuginfo
>> to make sure tests are not skipped.
>>=20
>> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>> Changelog:
>> - First version used "perf probe -v -L getname_flags" for debuginfo
>>  check. This will not catch fail string "Debuginfo-analysis is not
>> supported" which is used in cases when perf is built without dwarf.
>> So use "perf probe -vn add inode_permission" to capture cases when
>> tools built with NO_LIBDWARF=3D1. This will capture debuginfo missing =
as
>> well as tool built without dwarf case.
>>=20
>> .../tests/shell/base_probe/test_adding_kernel.sh  | 15 =
++++++++++++++-
>> tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>> 2 files changed, 26 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh =
b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>> index 555a825d55f2..f3db125c8669 100755
>> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>> @@ -23,10 +23,23 @@ TEST_RESULT=3D0
>> . "$DIR_PATH/../lib/probe_vfs_getname.sh"
>>=20
>> TEST_PROBE=3D${TEST_PROBE:-"inode_permission"}
>> +PROBE_NO_LINE_CHECK=3D1
>=20
> I'm not sure I follow but shouldn't it depend on the return value of
> `perf check feature -q dwarf`?
>=20
> Thanks,
> Namhyung

Hi Namhyung

Thanks for checking the patch.

Yes, "perf check feature -q dwarf=E2=80=9D checks if perf is compiled =
with dwarf support.
But for =E2=80=9Ctest_adding_kernel=E2=80=9D , we need to check if =
kernel debuginfo is missing.
The check this path is trying to, also includes =E2=80=9Cdebuginfo=E2=80=9D=


In environment without debuginfo: perftool-testsuite_probe fails as =
below:

Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on =
inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe =
:: perf probe -l (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple =
probes
Regexp not found: "probe:vfs_mknod"
Regexp not found: "probe:vfs_create"
Regexp not found: "probe:vfs_rmdir"
Regexp not found: "probe:vfs_link"
Regexp not found: "probe:vfs_write"
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding =
support (command exitcode + output regexp parsing)
Regexp not found: =
"somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
Regexp not found: "in this function|at this address"
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable =
(output regexp parsing)
## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures =
found

We have =E2=80=9Cskip_if_no_debuginfo=E2=80=9D check in =
tools/perf/tests/shell/lib/probe_vfs_getname.sh and
=E2=80=9Ctest_adding_kernel=E2=80=9D calls this to find out presence of =
debuginfo.=20

Recently a change got added via commit 92b664dcefab ("perf test =
probe_vfs_getname: Skip if no suitable
line detected=E2=80=9D) where we return if specific line is not found =
using perf probe. And hence debuginfo check is not
happening.


The tests in test_adding_kernel.sh which depends on presence of
debuginfo are:
1. probe add for inode_permission
2. probe max-probes option using 'vfs_* $params'
3. non-existing variable probing

For these tests, probe check for specific line is not required. So this =
patch updates
skip_if_no_debuginfo to use an argument that communicates whether line =
check is needed.
If only debuginfo/dwarf check is required, use simple "perf probe=E2=80=9D=
. And for other
tests which rely on line number, fallback to default =
add_probe_vfs_getname().

Thanks
Athira

>=20
>>=20
>> # set NO_DEBUGINFO to skip testcase if debuginfo is not present
>> # skip_if_no_debuginfo returns 2 if debuginfo is not present
>> -skip_if_no_debuginfo
>> +#
>> +# The perf probe checks which depends on presence of debuginfo and
>> +# used in this testcase are:
>> +# 1. probe add for inode_permission
>> +# 2. probe max-probes option using 'vfs_* $params'
>> +# 3. non-existing variable probing
>> +#
>> +# For these tests, probe check for specific line is not
>> +# required ( add_probe_vfs_getname does that ). So call
>> +# skip_if_no_debuginfo with argument as 1. This is to convey
>> +# that test only needs to check for debuginfo, and not specifically
>> +# line number
>> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
>> if [ $? -eq 2 ]; then
>> NO_DEBUGINFO=3D1
>> fi
>> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh =
b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> index 88cd0e26d5f6..8ae2ea2bc8a2 100644
>> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
>> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
>> }
>>=20
>> skip_if_no_debuginfo() {
>> - add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the =
path for the kernel|Debuginfo-analysis is not supported)|(file has no =
debug information)" && return 2
>> + no_line_check=3D$1
>> + debug_str=3D"^(Failed to find the path for the =
kernel|Debuginfo-analysis is not supported)|(file has no debug =
information)"
>> +
>> + # search for debug_str using simple perf probe if the
>> + # test only needs to check for debuginfo, and not specifically
>> + # line number.
>> + if [ $no_line_check -eq 1 ]; then
>> + perf probe -vn add inode_permission 2>&1 | grep -E -q "$debug_str" =
&& return 2
>> + else
>> + add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
>> + fi
>> +
>> return 1
>> }
>>=20
>> --=20
>> 2.47.3



