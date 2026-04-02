Return-Path: <linuxppc-dev+bounces-19190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E134ACC6B03
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmYDt4FClz2ySk;
	Thu, 02 Apr 2026 18:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775114478;
	cv=none; b=laIWh1Wsc6bDfK/4alCKILGnw2GRoe83hJ8zmCOAzCPiktHA/6DunVgRtusyxKUGh1fjZ/14zTpGzAcYpqmUTx82XKqc54mcFQ3rdIjOZaL6ksPQNyPGrQKhEsrmHUF8DZmOykNdV2jk/VFmRa5Tm7UWWyc+hEqhtmMG2bngLObg1/N/gynBp0rSM6hgTkQGGs7o+u7xMzCGICB+WWyWG7Vq2TZhrZIt0Mw+rOmuv3pJQiFWPwHEFU+vQ6WQmztF8F/egoib2SI4WwF4h6qtlSzwUNiw/1fkFrnF96QGMqWRvWDT9mpw9287SpRV9VwwFlvAsw2SITJshpY/sMkRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775114478; c=relaxed/relaxed;
	bh=SM62b691tWzqzlWo+QGAPYJFbUmDMiobgucC8KUf2RI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aG+uWBC4sC/SiOG/wLhBwDQPOuoesnayKCeWUrGDMTqmXjlOeEjkzB+nJ0NQTv8x7jtTnREJ0x4SIn6nxmK51PZQR97wq1Ide5/IiYmpfuz5nBQBwWIdKYskslWgP+fdHbmUK9gM8ZX9ftgX38NGz0d/q+GNdATaugDvHJV8lvC9OOyx80JDg2jorqIjE8dlHVMYako1hzOQjMdUXj6GoMEfkhfnMwosFJT9+fFGB0An6v28C1oSoclcUU7jh2S923GsO6vVlSODmR1J1HnJelly2XmvL5X+nhs9Qk6otDcJtHFIMSLESw1oig+QgV55190HgNqXq9Z9/2qSF3BY3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gC4Gh9S4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gC4Gh9S4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmYDs4x05z2xln
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 18:21:17 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631KZK7f3948870;
	Thu, 2 Apr 2026 07:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SM62b6
	91tWzqzlWo+QGAPYJFbUmDMiobgucC8KUf2RI=; b=gC4Gh9S4hwLGa0PWizvlfC
	aZiH1NCsW2nMiXhNDr4TYiosBDHxybbwo4QSHIdPZ6RAV9/yv4qNgRAub2OuQqdP
	fQAxz8mX5pQ2olu7zRmbkffB0sdvnwlvITDYzbGZMJetUBzBCvEshWyfN/jMHXoc
	suMm9R47auB3ZI94OjM6okke3Q3PxyE21zZdJebHBXcT+8YCLQft367cz5z+iM4B
	aSm7vWhkIHp3AA2z0myZ6K6ooKedm/Xr8KB9pg1p35Toa7Nu9C7gEHU/ifZfGbn4
	wFKb9XBDHLcKN+KMRO4dH2p+6HwPjp9VslviaS0chYks8uGbLDOg+qtbO8x38u0w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcjvpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 07:16:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6326xB6A030995;
	Thu, 2 Apr 2026 07:16:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk0w42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 07:16:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6327G0gZ32637458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 07:16:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE63E58060;
	Thu,  2 Apr 2026 07:16:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E930858056;
	Thu,  2 Apr 2026 07:15:55 +0000 (GMT)
Received: from [9.124.211.187] (unknown [9.124.211.187])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 07:15:55 +0000 (GMT)
Message-ID: <71424f5e-2d42-4b82-b5d6-4b507c73af9c@linux.ibm.com>
Date: Thu, 2 Apr 2026 12:45:54 +0530
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
From: Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v3 12/13] selftests/mm: move hwpoison setup into
 run_test() and silence modprobe output for memory-failure category
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <a157c2f91d8fa94b14dff44ce5c0dfcce1f8328e.1774591179.git.sayalip@linux.ibm.com>
Content-Language: en-IN
In-Reply-To: <a157c2f91d8fa94b14dff44ce5c0dfcce1f8328e.1774591179.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce17b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=BLP2e4f4YfAStYiMnDwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SpgGA6LxnPZonV-h0J_pZMbTi0owmqRN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1OSBTYWx0ZWRfXzYZLu5HkxuzA
 9qO2Q9Yn3X8cossavIunDmLaqJpvESeOc5J4QC3TeRcj5hdMaPhFSJifafL+VysGT44/2ZWpWJV
 so5esM+oJcnkGwBCi7zvqzDW4kR/QR9UWB6YgcnoMyhSbJoFf0avIvaM438f+mPUtzPrTbE08CD
 ApMZmfbQb0u8B49qIgHlk3seK0aYJo1ZWjtsSlxJOR94+d9ifbs4yPk2fL1UwU02ceI6n94bV+S
 3rdM3kKSzdVFI3Yy+CjWmyx9db4bFPHFE3ROmo6trtmclWpNTk/RkQLbb8QzRDPCALjM3S4ldSh
 k24jfpc5NKU359vWZmuQ7ndUe9a4wrpr3IgPQ+pU0R0z8/6cZoNn5aH3suE5Yu5jdKYRvCI4oEK
 bdZU4CptyoUpaHYYH6PoGyMnjNw1eSfD+m+w15sB5V0Hp60BoIqDT28AOHkNwTimrS72VggnyOt
 w23kRxTQ3vAg45KCiJQ==
X-Proofpoint-ORIG-GUID: EU480Jai16Dy4ctV4rvv5ArdL-8ArJHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020059



On 27/03/26 12:46, Sayali Patil wrote:
> run_vmtests.sh contains special handling to ensure the hwpoison_inject
> module is available for the memory-failure tests. This logic was
> implemented outside of run_test(), making the setup category-specific
> but managed globally.
> 
> Move the hwpoison_inject handling into run_test() and restrict it
> to the memory-failure category so that:
> 1. the module is checked and loaded only when memory-failure tests run,
> 2. the test is skipped if the module or the debugfs interface
> (/sys/kernel/debug/hwpoison/) is not available.
> 3. the module is unloaded after the test if it was loaded by the script.
> 
> This localizes category-specific setup and makes the test flow
> consistent with other per-category preparations.
> 
> While updating this logic, fix the module availability check.
> The script previously used:
> 
> 	modprobe -R hwpoison_inject
> 
> The -R option prints the resolved module name to stdout, causing every
> run to print:
> 
> 	hwpoison_inject
> 
> in the test output, even when no action is required, introducing
> unnecessary noise.
> 
> Replace this with:
> 
> 	modprobe -n hwpoison_inject
> 
> which verifies that the module is loadable without producing output,
> keeping the selftest logs clean and consistent.
> 
> Fixes: ff4ef2fbd101 ("selftests/mm: add memory failure anonymous page test")
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 46 ++++++++++++++---------
>   1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index eecec0b6eb13..606558cc3b09 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -250,6 +250,27 @@ run_test() {
>   			fi
>   		fi
>   
> +		# Ensure hwpoison_inject is available for memory-failure tests
> +		if [ "${CATEGORY}" = "memory-failure" ]; then
> +			# Try to load hwpoison_inject if not present.
> +			HWPOISON_DIR=/sys/kernel/debug/hwpoison/
> +			if [ ! -d "$HWPOISON_DIR" ]; then
> +				if ! modprobe -n hwpoison_inject > /dev/null 2>&1; then
> +					echo "Module hwpoison_inject not found, skipping..." \
> +						| tap_prefix
> +					skip=1
> +				else
> +					modprobe hwpoison_inject > /dev/null 2>&1
> +					LOADED_MOD=1
> +				fi
> +			fi
> +
> +			if [ ! -d "$HWPOISON_DIR" ]; then
> +				echo "hwpoison debugfs interface not present" | tap_prefix
> +				skip=1
> +			fi
> +		fi
> +
>   		local test=$(pretty_name "$*")
>   		local title="running $*"
>   		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
> @@ -261,6 +282,12 @@ run_test() {
>   		else
>   			local ret=$ksft_skip
>   		fi
> +
> +		# Unload hwpoison_inject if we loaded it
> +		if [ -n "${LOADED_MOD}" ]; then
> +			modprobe -r hwpoison_inject > /dev/null 2>&1
> +		fi
> +
>   		count_total=$(( count_total + 1 ))
>   		if [ $ret -eq 0 ]; then
>   			count_pass=$(( count_pass + 1 ))
> @@ -540,24 +567,7 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
>   
>   CATEGORY="rmap" run_test ./rmap
>   
> -# Try to load hwpoison_inject if not present.
> -HWPOISON_DIR=/sys/kernel/debug/hwpoison/
> -if [ ! -d "$HWPOISON_DIR" ]; then
> -	if ! modprobe -q -R hwpoison_inject; then
> -		echo "Module hwpoison_inject not found, skipping..."
> -	else
> -		modprobe hwpoison_inject > /dev/null 2>&1
> -		LOADED_MOD=1
> -	fi
> -fi
> -
> -if [ -d "$HWPOISON_DIR" ]; then
> -	CATEGORY="memory-failure" run_test ./memory-failure
> -fi
> -
> -if [ -n "${LOADED_MOD}" ]; then
> -	modprobe -r hwpoison_inject > /dev/null 2>&1
> -fi
> +CATEGORY="memory-failure" run_test ./memory-failure
>   
>   if [ "${HAVE_HUGEPAGES}" = 1 ]; then
>   	echo "$orig_nr_hugepgs" > /proc/sys/vm/nr_hugepages

AI review question:
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh
> > b/tools/testing/selftests/mm/run_vmtests.sh
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -250,6 +250,27 @@ run_test() {
> >  			fi
> >  		fi
> >
> > +		# Ensure hwpoison_inject is available for memory-failure tests
> > +		if [ "${CATEGORY}" = "memory-failure" ]; then
> > +			# Try to load hwpoison_inject if not present.
> > +			HWPOISON_DIR=/sys/kernel/debug/hwpoison/
> > +			if [ ! -d "$HWPOISON_DIR" ]; then
> > +				if ! modprobe -n hwpoison_inject > /dev/null 2>&1; then
> > +					echo "Module hwpoison_inject not found, skipping..." \
> > +						| tap_prefix
> > +					skip=1
> Does moving this skip logic inside run_test() mask previous test failures?
> The run_vmtests.sh script sets exitcode=$ksft_skip when a test skips.
> Previously, if the module was missing, the script bypassed calling run_test()
> for memory-failure entirely, which preserved any previous 
> failure exit code.
> With this patch, run_test() executes, skips internally, and sets the
> exitcode to 4. Since memory-failure is the final test, could this
> change the test
> suite's final exit code from 1 to 4 on systems without the module?


This was pre-existing behavior, however, the concern is valid. Failures 
should take precedence over skips. Let me address this in v4.


> > +				else
> > +					modprobe hwpoison_inject > /dev/null 2>&1
> > +					LOADED_MOD=1
> Should LOADED_MOD be declared as a local variable here?
> Since it lacks a local declaration, it persists in the script's global
> environment. If any tests are appended after memory-failure in the future,
> or if LOADED_MOD is already set in the user's environment, this could cause
> modprobe -r hwpoison_inject to execute redundantly after those tests.


Yes, good point. Let me address this in v4 by making it a local variable.


> > +				fi
> > +			fi
> > +
> > +			if [ ! -d "$HWPOISON_DIR" ]; then
> > +				echo "hwpoison debugfs interface not present" | tap_prefix
> > +				skip=1
> > +			fi
> Will this print a redundant skip message when the module is not found?
> If modprobe -n fails earlier, the directory will still be absent, causing
> this second block to evaluate to true. This prints hwpoison debugfs 
> interface
> not present right after Module hwpoison_inject not found, skipping...,
> which might contradict the goal of keeping the selftest logs clean.


Agreed, this can lead to redundant output. I’ll update it in v4 to avoid 
the duplicate skip message.



