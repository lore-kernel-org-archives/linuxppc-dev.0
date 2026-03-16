Return-Path: <linuxppc-dev+bounces-18237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72CFF4644C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:19:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZCKS1XNcz2xpn;
	Mon, 16 Mar 2026 22:19:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773659964;
	cv=none; b=bA2J4tI0LhYHMV57DRHClENZ6WRSkr7FHDfMMYfZ59UVbMks1gZe5Ycu0ip7+vrD7RbS+Vw6SomVl75tcURIUM8oETor9dJVdXk6R0mJtR3uwDt+2tWGDSHYQO/qiKk0mbTAMpL8zCF8NUNagHind5vRCejgO+a8I9ImmzZrdjZK1xj/KpicjrtZfIYy5DVEY0BCOW1jhF7M0pXsyPCsI5spqG9iJCQ6cpdaArPQNMnS8yyvGKueM14LscKmOvFuPXpQbAGP/Y8g4oBzqfHd85b2nHAhrlf5hkFA+7Jupc5xclm6a8icFm6Zw5r5BdQLR1QEfNjFNEC9w/Km7+PE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773659964; c=relaxed/relaxed;
	bh=ab6REZYOs2wws+a7CF+gNJbrmRualE4Rr4jD6SAfdwQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=d/jyR57dxjhKyECpbkISirb7/E7x5LeJApymWj4EFWZ2dx6SOOFdeJyU6/TnTnF71br/AY/Lw90lNXmcvyA/iNg72mDpkQgUwrAQKedbPkWJb0eIY9gxR9cb6YUp9ZRHY/zFY7nqKMYi8Yg1ers/55OcJBvGSJg9SuMFNtluwxajPg4WVWjhESSVmKtVTBb/f4ZrVy96I0iLz1CDvQBCL203ig5V2QxKglNrhJLunIpX9EQOPduNTfKMsnA9Qwq3mbcwKd8KnEEjgOyML9SDt8nlhmJ3dyf0wFBuonGKaPM4P3g5IwIH500aMFDRmZK627vZSTHuumG64mggWbCRHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fW/EzTDV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fW/EzTDV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZCKQ6TfNz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 22:19:21 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FJob8F532599;
	Mon, 16 Mar 2026 11:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ab6REZYOs2wws+a7CF+gNJbrmRualE
	4Rr4jD6SAfdwQ=; b=fW/EzTDVujyfdArzwRDqQQwGZQI+2G6soyEByTKv+hobhW
	7NankHzD+2uf2IJinZgmw5kaHSgbFdXoD8B88IJvs6s8Z44V7Wmp5Qzv2LiFUy79
	++rJaISWasO0NnyNgb+ESvdYei+/UczfPScdpTDapjRJKGtuupkqFn95yqnK8RY3
	M9aRzMLP6W1Gn0iwtjxK4Mzfz7kSyNS+/bg2/hsrRIjH+sJeezo+238SRA/IJ/bW
	AWshWjQMXi4nFP11NzL2VJyfLbgSadA/gBrxFepShJqb47/TfOjO/sFlJ9WSqbMy
	tRBbbnjY6SRfhlIt9QY99NATzq5pty35TtEem98Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cq8ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:19:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G9gQsH014032;
	Mon, 16 Mar 2026 11:19:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxvn5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:19:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GBJCob31916568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 11:19:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0860E58052;
	Mon, 16 Mar 2026 11:19:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CDD358056;
	Mon, 16 Mar 2026 11:19:07 +0000 (GMT)
Received: from [9.124.218.47] (unknown [9.124.218.47])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 11:19:06 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------cXMT3ocLzm9Wtf1qp0C5mIk2"
Message-ID: <ee40b744-91fd-46b3-811a-8bc2154908dc@linux.ibm.com>
Date: Mon, 16 Mar 2026 16:49:04 +0530
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf/tests: Update debuginfo check in
 skip_if_no_debuginfo
To: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, jbrnak@redhat.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260314083722.76728-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Tejas Manhas <tejas05@linux.ibm.com>
In-Reply-To: <20260314083722.76728-1-atrajeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b7e732 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=8kIU8u4Iq8Bn2F0HEqoA:9 a=QEXdDO2ut3YA:10 a=djXmuU_IFq0narE4Ot4A:9
 a=PH5hUtFO67QFgGLg:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4NiBTYWx0ZWRfX5oVL0jYjMWBr
 JkoQBOlhtvrIZfbCm3yD6uBwpkV/djuqJxiqjdpKQxQUBvsUHmZdYQz3d8o3nVD84Apj34lAPKe
 GAMhSv4sElBis3BmE4xNunL/IybXXpax3RDvM7jlV6729LLAW3NDbR2Dcn4aU+O7qaZQujGX3KD
 T9o1gVjle+FTaVH1zI7dztex6qqYoCM+jj3VPKCvset78ouLkoewojwMVoXXIcXCmeDQtZaYXPq
 HPXCyZFlwlp7kf67QxJmo+9I82u0B4R+JssCmPLGZWbx0vF4CzfF4J950jU8iPK1lXQJ6ZOwB3b
 PknCVom6ItM/qyV7glEzxkwoGS0b61ehQ/y9csD/s3I1uKujBufjswKiOiqg9mvU/sKac3wU59X
 CivpIP5YdUZ+w3PvOAUgPxveka+MIyPwjDAJvvurw347I74m6TkKNvYbbWVIZ6djhmaCiG8o8Fw
 s0FMkZpf/V7+UsQASwA==
X-Proofpoint-GUID: ri1GKNpOEanTpQF7NdHISKnMHmPWBAya
X-Proofpoint-ORIG-GUID: QzdBt8HBPtEfr-7S4-sIFcMGgH8egseK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160086

This is a multi-part message in MIME format.
--------------cXMT3ocLzm9Wtf1qp0C5mIk2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/03/26 2:07 PM, Athira Rajeev wrote:
> Perf test perftool-testsuite_probe fails as below:
>
>   Regexp not found:"\s*probe:inode_permission(?:_\d+)?\s+\(on 
> inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>   -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
>   -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
>   Regexp not found: "probe:vfs_mknod"
>   Regexp not found: "probe:vfs_create"
>   Regexp not found: "probe:vfs_rmdir"
>   Regexp not found: "probe:vfs_link"
>   Regexp not found: "probe:vfs_write"
>   -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
>   Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
>   Regexp not found: "in this function|at this address"
>   -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
>   ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
>
> Further analysing, the failed testcase is for "test_adding_kernel".
> If the kernel debuginfo is missing, perf probe fails as below:
>
> perf probe -nf --max-probes=512 -a 'vfs_* $params'
> Failed to find the path for the kernel: No such file or directory
>    Error: Failed to add events.
>
> skip_if_no_debuginfo has check to handle whether debuginfo is present
> and the testcase checks for debuginfo since this :
> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
> testcases fail when kernel debuginfo is not present")
>
> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
> via this another fix:
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected")
> Since this commit, first add_probe_vfs_getname is used to prevent false
> failures. And based on return code of add_probe_vfs_getname, skip_if_no_debuginfo
> is used to skip testcase if debuginfo is present. And this modified other
> testcases to call add_probe_vfs_getname first and invoke
> skip_if_no_debuginfo based on return value.
>
> The tests in test_adding_kernel.sh which depends on presence of
> debuginfo are:
> 1. probe add for inode_permission
> 2. probe max-probes option using 'vfs_* $params'
> 3. non-existing variable probing
>
> For these tests, probe check for specific line is not required.
> So call skip_if_no_debuginfo with argument to say if line check is
> needed. This is to convey to skip_if_no_debuginfo() function
> that test only needs to check for debuginfo, and not specifically
> line number. Update skip_if_no_debuginfo to use simple "perf probe"
> check if test only needs to check for debuginfo. And for other
> tests which rely on line number, use add_probe_vfs_getname()
>
> With the change, verified that only three which required debuginfo only
> is skipped and others ran successfully. Also tested with debuginfo
> to make sure tests are not skipped.
>
> Reported-by: Tejas Manhas<Tejas.Manhas1@ibm.com>
> Signed-off-by: Athira Rajeev<atrajeev@linux.ibm.com>
> ---
>   .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
>   tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>   2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> index 555a825d55f2..f3db125c8669 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -23,10 +23,23 @@ TEST_RESULT=0
>   . "$DIR_PATH/../lib/probe_vfs_getname.sh"
>   
>   TEST_PROBE=${TEST_PROBE:-"inode_permission"}
> +PROBE_NO_LINE_CHECK=1
>   
>   # set NO_DEBUGINFO to skip testcase if debuginfo is not present
>   # skip_if_no_debuginfo returns 2 if debuginfo is not present
> -skip_if_no_debuginfo
> +#
> +# The perf probe checks which depends on presence of debuginfo and
> +# used in this testcase are:
> +# 1. probe add for inode_permission
> +# 2. probe max-probes option using 'vfs_* $params'
> +# 3. non-existing variable probing
> +#
> +# For these tests, probe check for specific line is not
> +# required ( add_probe_vfs_getname does that ). So call
> +# skip_if_no_debuginfo with argument as 1. This is to convey
> +# that test only needs to check for debuginfo, and not specifically
> +# line number
> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
>   if [ $? -eq 2 ]; then
>   	NO_DEBUGINFO=1
>   fi
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f6..8584ec76f041 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
>   }
>   
>   skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> +	no_line_check=$1
> +	debug_str="^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)"
> +
> +	# search for debug_str using simple perf probe if the
> +	# test only needs to check for debuginfo, and not specifically
> +	# line number.
> +	if [ $no_line_check -eq 1 ]; then
> +		perf probe -v -L getname_flags 2>&1 | grep -E -q "$debug_str" && return 2
> +	else
> +		add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" && return 2
> +	fi
> +
>   	return 1
>   }
>   

Hi Athira,

I have tested the patch on the kernel[ 7.0.0-rc4+ ] and it works as expected, i.e. skipping in case of no debuginfo.
Please add the tag below for the patch.

Tested-by: Tejas Manhas<tejas05@linux.ibm.com>
   
Thanks & Regards,
Tejas



--------------cXMT3ocLzm9Wtf1qp0C5mIk2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 14/03/26 2:07 PM, Athira Rajeev
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260314083722.76728-1-atrajeev@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Perf test perftool-testsuite_probe fails as below:

 Regexp not found: <a class="moz-txt-link-rfc2396E" href="mailto:\s*probe:inode_permission(?:_\d+)?\s+\(oninode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)">"\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"</a>
 -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
 -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
 Regexp not found: "probe:vfs_mknod"
 Regexp not found: "probe:vfs_create"
 Regexp not found: "probe:vfs_rmdir"
 Regexp not found: "probe:vfs_link"
 Regexp not found: "probe:vfs_write"
 -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
 Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
 Regexp not found: "in this function|at this address"
 -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
 ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found

Further analysing, the failed testcase is for "test_adding_kernel".
If the kernel debuginfo is missing, perf probe fails as below:

perf probe -nf --max-probes=512 -a 'vfs_* $params'
Failed to find the path for the kernel: No such file or directory
  Error: Failed to add events.

skip_if_no_debuginfo has check to handle whether debuginfo is present
and the testcase checks for debuginfo since this :
commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
testcases fail when kernel debuginfo is not present")

Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
via this another fix:
commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
line detected")
Since this commit, first add_probe_vfs_getname is used to prevent false
failures. And based on return code of add_probe_vfs_getname, skip_if_no_debuginfo
is used to skip testcase if debuginfo is present. And this modified other
testcases to call add_probe_vfs_getname first and invoke
skip_if_no_debuginfo based on return value.

The tests in test_adding_kernel.sh which depends on presence of
debuginfo are:
1. probe add for inode_permission
2. probe max-probes option using 'vfs_* $params'
3. non-existing variable probing

For these tests, probe check for specific line is not required.
So call skip_if_no_debuginfo with argument to say if line check is
needed. This is to convey to skip_if_no_debuginfo() function
that test only needs to check for debuginfo, and not specifically
line number. Update skip_if_no_debuginfo to use simple "perf probe"
check if test only needs to check for debuginfo. And for other
tests which rely on line number, use add_probe_vfs_getname()

With the change, verified that only three which required debuginfo only
is skipped and others ran successfully. Also tested with debuginfo
to make sure tests are not skipped.

Reported-by: Tejas Manhas <a class="moz-txt-link-rfc2396E" href="mailto:Tejas.Manhas1@ibm.com">&lt;Tejas.Manhas1@ibm.com&gt;</a>
Signed-off-by: Athira Rajeev <a class="moz-txt-link-rfc2396E" href="mailto:atrajeev@linux.ibm.com">&lt;atrajeev@linux.ibm.com&gt;</a>
---
 .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index 555a825d55f2..f3db125c8669 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -23,10 +23,23 @@ TEST_RESULT=0
 . "$DIR_PATH/../lib/probe_vfs_getname.sh"
 
 TEST_PROBE=${TEST_PROBE:-"inode_permission"}
+PROBE_NO_LINE_CHECK=1
 
 # set NO_DEBUGINFO to skip testcase if debuginfo is not present
 # skip_if_no_debuginfo returns 2 if debuginfo is not present
-skip_if_no_debuginfo
+#
+# The perf probe checks which depends on presence of debuginfo and
+# used in this testcase are:
+# 1. probe add for inode_permission
+# 2. probe max-probes option using 'vfs_* $params'
+# 3. non-existing variable probing
+#
+# For these tests, probe check for specific line is not
+# required ( add_probe_vfs_getname does that ). So call
+# skip_if_no_debuginfo with argument as 1. This is to convey
+# that test only needs to check for debuginfo, and not specifically
+# line number
+skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
 if [ $? -eq 2 ]; then
 	NO_DEBUGINFO=1
 fi
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 88cd0e26d5f6..8584ec76f041 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -39,7 +39,18 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2&gt;&amp;1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" &amp;&amp; return 2
+	no_line_check=$1
+	debug_str="^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)"
+
+	# search for debug_str using simple perf probe if the
+	# test only needs to check for debuginfo, and not specifically
+	# line number.
+	if [ $no_line_check -eq 1 ]; then
+		perf probe -v -L getname_flags 2&gt;&amp;1 | grep -E -q "$debug_str" &amp;&amp; return 2
+	else
+		add_probe_vfs_getname -v 2&gt;&amp;1 | grep -E -q "$debug_str" &amp;&amp; return 2
+	fi
+
 	return 1
 }
 
</pre>
    </blockquote>
    <pre>Hi Athira, 

I have tested the patch on the kernel[ 7.0.0-rc4+ ] and it works as expected, i.e. skipping in case of no debuginfo.
Please add the tag below for the patch.

Tested-by: Tejas Manhas <a class="moz-txt-link-rfc2396E"
    href="mailto:tejas05@linux.ibm.com">&lt;tejas05@linux.ibm.com&gt;</a>
  
Thanks &amp; Regards, 
Tejas



</pre>
  </body>
</html>

--------------cXMT3ocLzm9Wtf1qp0C5mIk2--


