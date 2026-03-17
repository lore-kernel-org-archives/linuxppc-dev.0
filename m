Return-Path: <linuxppc-dev+bounces-18290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A1EF506CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 05:32:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZgZw1HBwz2yVP;
	Tue, 17 Mar 2026 16:32:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773725560;
	cv=none; b=Ad3PZ+ktZkIz7JYH7eaJcoomn0nPJVUdPla4fRnzJEqK59IYzRLAYOpqOvkg9OWQPJ9Nk4lYgKFjEwA+Bc9HTgr3BPEfexVCsvT9tefkQIfNuyesoBOjcL5LK0uL56ptY006tAwZa5oPY58crCWhA5ehaiO+2v5NC8fKDYUuglCU3hQoLNUxDEh6ivtYPw4Msz4esLuWnyJeM7Ho9YGWM1G9J2kjOvucD/el17MRxSVpG/cSnx0+vL9JybADzdW5/rpHxYjqPR7ftAIU6s2r3vefKzqWf5Wtx9Usl68eFHgW4V0Uuk4S6EIIkKa0ZbIQCAjKTD2vk6uAh96MzJpG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773725560; c=relaxed/relaxed;
	bh=eRoyhzO275y5e/mZElsS9SjBnspQzrPgrFQq2UY9IJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU4r8uMUn4aBb7cpKYoTtdt66YKsYXdLmnxtza/pzJ85VRy9q8ru/8FSKGAiM17GbDdZnIWD9esEwdcfLBydc0cHBx796UU6FpyrVo7RYE887Vs8sQlJA0tMGMZinxgc39ZtKugUIuGCCGX1yzoNxfmEhzWDk9BIjXKavCKnVSyLAR+MAyF7r8aRYHdnWWeh9hBwQsx37aECWljHtInf15Se/I+op6vgNqZO0dpGp0dBLyK/yl2mduuG3KoCLiA7iPpPhR+8oodDLc5QcPZI6Pil6/7/2ZvA9LitzfxKtioowx36p1OKJSNHo+UcnKt7c73nnKDPNMtoWIZHvsT0Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UXOwwtgg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UXOwwtgg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZgZv0J2Zz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 16:32:38 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GNFfeT3795199;
	Tue, 17 Mar 2026 05:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eRoyhz
	O275y5e/mZElsS9SjBnspQzrPgrFQq2UY9IJI=; b=UXOwwtggDHUmikN8clyHi1
	EZpWXH6ac/1wzbmSUsIoXi7A+Bm8vGp4mcAx3KnfYIGtPcu4DiQA4XaM3PHhKP0k
	mqu1PAwcNp6PSJc0ZcDIkgY2pFyixPw0QDxOXuhAcRedhpOCM6zOOnCI9JNX8h1U
	K3EE6TTTwdEup8dKG1+0PneZcPjG9MpjlG/II5XP/0Dy9XNlnODfBguK9XrVRDTa
	mmEtf54kYT50Me5KNpxcBY+GCP70L1cepywOpug3+LCpb7p7MCki7C5wnVCbTNRe
	Lokn94YBUIrq5/K7cAhsJlH1rtItDgbynBNp8Z0u5xjDpYoFA9r427Ymtawl5c1Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3ctsnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 05:32:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H2twRx028496;
	Tue, 17 Mar 2026 05:32:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq17hu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 05:32:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H5WKq760162472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 05:32:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA8AF58052;
	Tue, 17 Mar 2026 05:32:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94A8A58045;
	Tue, 17 Mar 2026 05:32:15 +0000 (GMT)
Received: from [9.109.249.251] (unknown [9.109.249.251])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 05:32:15 +0000 (GMT)
Message-ID: <0fde738c-e5a2-464d-a647-dfb3ec88d4cb@linux.ibm.com>
Date: Tue, 17 Mar 2026 11:02:14 +0530
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
Content-Language: en-GB
To: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, jbrnak@redhat.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260314083722.76728-1-atrajeev@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260314083722.76728-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b8e768 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wHG9en04jCOooAFPCGAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA0MiBTYWx0ZWRfX00+yoKrwTBAg
 wxUO5qYL1WhmM3fP31c3t5UUJnbebqntHaiI1Z0MeMXTPCzTC/MkbpKaIL/UjBz/aZIX07MYUmw
 ECiQSV6+jNtpUf6ZJZPlZr0zlzl2QkSwYpeFFYbQa5Z4AYqrHE4Sqs2WSsfbyDznaerzvL/zxOK
 3MPFNzpvmgYLk3YkiGxTk1fhi6W8tCzeb0D5VJCP+MguvBTwLBjjNTi2CWay2RfUUvUt1EMz1m3
 Ao/2xvqtBMoQ2Gc6fe9vj09oyUO+o7BYMtomRwt/cOCmacJible+P3Ca3DcA7XASJ6fHP8urIML
 FKnU/fu2Islm3gDiOvyFBvCXUWyhoNC09DWmOpgNjsokQ4TZ1YMAUWKWzZ4SGs6j7fw686q/aRt
 IWHTEo+XoonV36v12jNL6q69vcfNEYqlpyr+pLVHs5doKygngYQ493HdeRdaBDHRTBLAXA67HF3
 ff/CPwPMYt6gLSTt9qw==
X-Proofpoint-GUID: dphSf5JZt0ZW5jUhRLHLf1hSwTc2wdvA
X-Proofpoint-ORIG-GUID: CZdQUOrlrwY1jid6JvwhELZSbqW0dzNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170042


On 14/03/26 2:07 pm, Athira Rajeev wrote:
> Perf test perftool-testsuite_probe fails as below:
>
>   Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
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
> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
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


Hello Athira,


I see, If perf is not built with elfuitls-devel package, then test still 
fails.

Failure Logs:

-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe 
inode_permission ::
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe 
inode_permission :: -a
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe 
inode_permission :: --add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe 
:: perf list
Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on 
inode_permission(?:[:\+][0-9A-Fa-f]+)?@.+\)"
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe 
:: perf probe -l (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe 
(should NOT be listed)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes 
:: first probe adding
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes 
:: second probe adding (without force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes 
:: second probe adding (with force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
Regexp not found: "probe:vfs_mknod"
Regexp not found: "probe:vfs_create"
Regexp not found: "probe:vfs_rmdir"
Regexp not found: "probe:vfs_link"
Regexp not found: "probe:vfs_write"
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding 
support (command exitcode + output regexp parsing)
Regexp not found: "Failed to find"
Regexp not found: 
"somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
Regexp not found: "in this function|at this address"
Line did not match any pattern: "Debuginfo-analysis is not supported."
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable 
(output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval 
:: add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval 
:: record
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument 
probing :: script
## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found


Regards,

Venkat.


