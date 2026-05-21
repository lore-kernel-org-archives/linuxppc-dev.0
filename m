Return-Path: <linuxppc-dev+bounces-21284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2271ECD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:31:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhTN4lMbz2xSN;
	Thu, 21 May 2026 18:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352296;
	cv=none; b=iG1d1FdEHtYQhjZeqof9cqSZ3wrm8UUg5d9csVJSF4qNkxZK5uoY6Z3AhH9dQeyGBMTk20chKIUKp6qnQ0ONhP7Bys3RemsQvmNej+qTrk5HdR58ysTdEv2nBDwSlcSh8FA1PLMxT2PRc5+O5tndzc9oiXAT/1xzKwHIfTZdbQrW8+v7T3pMVHM5t7Dsor+a4ThsDRhCWbT6joBeNwzjJYaUg10zUxcCHh+hq+uGMPl0Pp9dDGMvJRbxuaot5ZswEPJ9hShO7tV2v5ipF7GTgx6WokwisVDnl4hjgg/pw8cRDUvAZOrMNPqmozwlr84AczuZytZ8gnjsQcF1HmzzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352296; c=relaxed/relaxed;
	bh=9B9NvbUnfnsNxR4pEN29F10Q/nlhrz7bG6iaBF2alzc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eiLQMuRwroy66/3mxOX7pcjaxVQTLz8c7yhA38mtMpIE2ruuWe5ZeJ/2rSAjv+0fsZytx3HU9uFWcGTeGHGrH2xKyYk5R9vqTY0FB8hWv7YgXe5pUWghbiBjnvrxPesfJymucTKaJHeYnJi+p5NyVMEYMDDubQBpgagl6KnctvVL5tUrylFk8xgpkgPKinSXZfpr/p9ZZBNgYcmBG0kZq0wkeBG0kov4ns5L72vzHaFHwidxHV5kroYiYU44oBPb+23ZHY6rgXg/wdj+lhHMRE7udtHUSDbnkM8mu77rYyRHcva0KeJtXiMmmUdLumtCK9s0T1YNuFJU22ahKjcn4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FDbxTXDZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FDbxTXDZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhTL6z6Xz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:31:34 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L5Hi6l620482;
	Thu, 21 May 2026 08:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9B9Nvb
	UnfnsNxR4pEN29F10Q/nlhrz7bG6iaBF2alzc=; b=FDbxTXDZr7XEuxX8JM36om
	MGOo+Gh9RfVsnoAfMW71eBqu9QtKZGQHMqOetsX+cFvJAERSyZZZe0soY2WJsRmj
	hkGHPU/pYwN9bDexEImSLgk1EYOe5pjjYf4c2ETPdqaNcIG4l5p1wW7Pb3pPiBWC
	lO++mk9EiI8cIwpxBfktSLAW1UU35jw7r/U9wxgUuXHjMyPJxKu76wrToPKQT+tZ
	Wk1TPFVcVc/df2GGDTXYor5JF2ykKwBKRR3r4RZWmSIgsJGT8dbj1Dr3HQ+rZpAM
	P68DbC0sKYu7jNmsLcW0SnOSj/5HleiqCpOtcmRGRT0ZQinT+Qp75b80U5QEAUeQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88mrm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 08:31:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L8O8eq027659;
	Thu, 21 May 2026 08:31:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqbdqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 08:31:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L8VN5d47317270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:31:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 412CC20043;
	Thu, 21 May 2026 08:31:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548F620040;
	Thu, 21 May 2026 08:31:20 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.10.78])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 08:31:20 +0000 (GMT)
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
Subject: Re: [PATCH V3] tools/perf/tests: Update test_adding_kernel.sh to
 handle proper debuginfo check
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <AEEE2C46-8D1E-442E-B5A9-7B53E681E69B@linux.ibm.com>
Date: Thu, 21 May 2026 14:01:08 +0530
Cc: jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Venkat <venkat88@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7E4148E-DC3F-4FCC-8DD8-AA4A085DAF1D@linux.ibm.com>
References: <20260424172435.91725-1-atrajeev@linux.ibm.com>
 <AEEE2C46-8D1E-442E-B5A9-7B53E681E69B@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Cj6pDQas5MNVB8hiapd83ML7BO9wxlWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA3OCBTYWx0ZWRfX9CZYaV7VTyeK
 dWkcv0bNmFmkvtMCue1OZoVvwq5uHcolwX6HvxuhN5NjHLKaoKsGEVmtp7+ahLLWdtaGNZVjK4r
 V9QSo+bWdOTpAxalqKGkiy4CquWTwn8Ks1SabDkj6ibh9wdTBFhC5vrKEBOYndjkx0sfPcriO0Q
 WzZVSNa8nhIyLYMknRiD7FEsrw0ndnx2mXJTiTPL/5SSZMUxWn+rgMLc4PvLmA6ZAvYhiRyak2G
 yNgkYpPICkCE2w13MgZvCwvUBNLmNhBrzx8fOJmvu1lMDcLkwcLefHx2dosCf5RqecFYP1xVqdf
 QIrQiFuPUCYNYev59POmZGKkgJ5imgmMBSmSj+qNP60ZYPEX1chwrK3b+DLdmYV8Aio++KdXdjG
 42rLCQi8RKplyMWKOuN4XK2iSNOgMdFtVaCplPyM20n+h57XN3cE1tARHn9Lsp5XjgTFPkgXYll
 dtmwmW4I2xdgX/nfwiQ==
X-Proofpoint-GUID: kGhCrZ-ls2Llu91bj0RDk_qHqM0cHMvV
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0ec2e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=SsHi5banC4Tmbct3BegA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210078



> On 29 Apr 2026, at 7:01=E2=80=AFPM, Venkat <venkat88@linux.ibm.com> =
wrote:
>=20
>=20
>=20
>> On 24 Apr 2026, at 10:54=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
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
>> Error: Failed to add events.
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
>> Update other places which uses skip_if_no_debuginfo to use argument
>> as zero.
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
>=20
> Tested this patch, by applying on top of mainline, and it fixes the =
reported issue.
>=20
> Without this patch:
>=20
> # ./perf test -v perftool-testsuite_probe
> --- start ---
> test child forked, pid 15772
> Probing start_text
> -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: adding =
blacklisted function start_text
> -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing =
blacklisted probe (should NOT be listed)
> ## [ PASS ] ## perf_probe :: test_adding_blacklisted SUMMARY
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe =
inode_permission ::
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe =
inode_permission :: -a
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe =
inode_permission :: --add
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe =
:: perf list
> Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on =
inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe =
:: perf probe -l (output regexp parsing)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added =
probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed =
probe (should NOT be listed)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding =
probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes =
:: first probe adding
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes =
:: second probe adding (without force)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes =
:: second probe adding (with force)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple =
probes
> Regexp not found: "probe:vfs_mknod"
> Regexp not found: "probe:vfs_create"
> Regexp not found: "probe:vfs_rmdir"
> Regexp not found: "probe:vfs_link"
> Regexp not found: "probe:vfs_write"
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding =
support (command exitcode + output regexp parsing)
> Regexp not found: "Failed to find"
> Regexp not found: =
"somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
> Regexp not found: "in this function|at this address"
> Line did not match any pattern: "The =
/lib/modules/7.1.0-rc1+/build/vmlinux file has no debug information."
> Line did not match any pattern: "Rebuild with CONFIG_DEBUG_INFO=3Dy, =
or install an appropriate debuginfo package."
> -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing =
variable (output regexp parsing)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with =
retval :: add
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with =
retval :: record
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument =
probing :: script
> ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures =
found
> -- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase =
skipped
> -- [ PASS ] -- perf_probe :: test_basic :: usage message
> -- [ PASS ] -- perf_probe :: test_basic :: quiet switch
> ## [ PASS ] ## perf_probe :: test_basic SUMMARY
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument =
for -a
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument =
for -d
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument =
for -L
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument =
for -V
> -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary =
argument for -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary =
argument for -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -a xxx -d xxx
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -a xxx -L foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -a xxx -V foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -a xxx -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -a xxx -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -d xxx -L foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -d xxx -V foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -d xxx -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -d xxx -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -L foo -V bar
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -L foo -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -L foo -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -V foo -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -V foo -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually =
exclusive options :: -l -F
> ## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: func
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: func:10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: func:0-10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: func:2+10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: func@source.c
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: func@source.c:1
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: source.c:1
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: source.c:1+1
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable =
descriptions :: source.c:1-10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable =
descriptions :: func:foo
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable =
descriptions :: func:1-foo
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable =
descriptions :: func:1+foo
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable =
descriptions :: func;lazy\*pattern
> ## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
> ---- end(-1) ----
> 137: perftool-testsuite_probe                                        : =
FAILED!
>=20
> With This patch:
>=20
> # ./perf test -v perftool-testsuite_probe
> 137: perftool-testsuite_probe                                        : =
Ok
>=20
> Please add below tag.
>=20
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>=20
> Regards,
> Venkat.

Hi,

Can we please have this pulled in, if the patches looks fine ?

Thanks
Athira
>=20
>> Changelog:
>> v2 -> v3:
>> - Update other callsites to use "skip_if_no_debuginfo 0"
>> - Use "perf probe -vn --add inode_permission $params"
>>=20
>> v1 -> v2:
>> - First version used "perf probe -v -L getname_flags" for debuginfo
>> check. This will not catch fail string "Debuginfo-analysis is not
>> supported" which is used in cases when perf is built without dwarf.
>> So use "perf probe -vn add inode_permission" to capture cases when
>> tools built with NO_LIBDWARF=3D1. This will capture debuginfo missing =
as
>> well as tool built without dwarf case.
>>=20
>> .../tests/shell/base_probe/test_adding_kernel.sh  | 15 =
++++++++++++++-
>> tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>> tools/perf/tests/shell/probe_vfs_getname.sh       |  7 ++++++-
>> .../shell/record+script_probe_vfs_getname.sh      |  7 ++++++-
>> tools/perf/tests/shell/trace+probe_vfs_getname.sh |  7 ++++++-
>> 5 files changed, 44 insertions(+), 5 deletions(-)
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
>> index 88cd0e26d5f6..2c5252a38ea1 100644
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
>> + perf probe -vn --add 'inode_permission $params' 2>&1 | grep -E -q =
"$debug_str" && return 2
>> + else
>> + add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
>> + fi
>> +
>> return 1
>> }
>>=20
>> diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh =
b/tools/perf/tests/shell/probe_vfs_getname.sh
>> index 5fe5682c28ce..b0878f571449 100755
>> --- a/tools/perf/tests/shell/probe_vfs_getname.sh
>> +++ b/tools/perf/tests/shell/probe_vfs_getname.sh
>> @@ -16,8 +16,13 @@ skip_if_no_perf_probe || exit 2
>> add_probe_vfs_getname
>> err=3D$?
>>=20
>> +# Invoke skip_if_no_debuginfo with argument as 0,
>> +# since the test needs suitable line number for getname
>> +# along with debuginfo check.
>> +# Argument "1" is used when to convey that test only needs to
>> +# check for debuginfo, and not specifically line number.
>> if [ $err -eq 1 ] ; then
>> - skip_if_no_debuginfo
>> + skip_if_no_debuginfo 0
>> err=3D$?
>> fi
>>=20
>> diff --git =
a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh =
b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
>> index 002f7037f182..48063fc2b221 100755
>> --- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
>> +++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
>> @@ -38,8 +38,13 @@ perf_script_filenames() {
>> add_probe_vfs_getname
>> err=3D$?
>>=20
>> +# Invoke skip_if_no_debuginfo with argument as 0,
>> +# since the test needs suitable line number for getname
>> +# along with debuginfo check.
>> +# Argument "1" is used when to convey that test only needs to
>> +# check for debuginfo, and not specifically line number.
>> if [ $err -eq 1 ] ; then
>> -        skip_if_no_debuginfo
>> +        skip_if_no_debuginfo 0
>>        err=3D$?
>> fi
>>=20
>> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh =
b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
>> index 7a0b1145d0cd..6833fba12086 100755
>> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
>> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
>> @@ -28,8 +28,13 @@ trace_open_vfs_getname() {
>> add_probe_vfs_getname
>> err=3D$?
>>=20
>> +# Invoke skip_if_no_debuginfo with argument as 0,
>> +# since the test needs suitable line number for getname
>> +# along with debuginfo check.
>> +# Argument "1" is used when to convey that test only needs to
>> +# check for debuginfo, and not specifically line number.
>> if [ $err -eq 1 ] ; then
>> -        skip_if_no_debuginfo
>> +        skip_if_no_debuginfo 0
>>        err=3D$?
>> fi
>>=20
>> --=20
>> 2.47.3



