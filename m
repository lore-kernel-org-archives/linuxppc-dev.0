Return-Path: <linuxppc-dev+bounces-19163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E42110F6FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 14:53:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm7Jl1GLwz2yhY;
	Thu, 02 Apr 2026 01:53:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775055191;
	cv=none; b=m6eOsNRsCVFBkyoT69K5QCulyxVVBdx+ma20R/zERRe5Y6BNjKtkCWg3dnfyoWGrzBlysYsgc+Q8636mLMT4QSHHHb3/vfNbZtEwdjhvnQudwvbAa0hcQD1gCZ40kTrhq5+hlJJfWP8ons0mQNzU3aEYbGyLOEO+6uNrfGfuOjoCmwrhugyHPZ/0SR61f8E/Az1QoxFanY4A705qn7Pt0iVBeIGGBe6eu2EmoeGZdO5ycSembSTkn0YHN4OtiskMv03qF+OMmk0a2mRikrTgM10gONyt4d454xp0AnpQFVBLKZWvxH7aqqSsbmX9nH/EpXQ1/teJCgqIfSS+2AXrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775055191; c=relaxed/relaxed;
	bh=mU5QVu1EHsg2q/n977oobe+AMZflaJO1Rx59stgMgho=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=BzDRoxvqmZi7oUCXSNBrIJy/7M2H/l8oUALwk+zfvRz52ZIDDoGN/KTUeexcz6ZzI1HviCF3/yat+ShYbvNSiczAOA5/om3uctQ+WRU38EcyTN1XHYpvM0cw9MgO19biAG6XWA4lPRLYhUyH69pl0RimjUC26NqN6JMC7g7nCEs4MjUjVUVSbs/yqKTC2Kumpbp3n3b9w22/ox/Nkx6ZJMuUsAkKnet8YH7IHfsIv2XA//wSAXnq9mgnQHS2JrR2nLtbiSzfPjRczMXcYDNI/4twsz5pCn5cETol1ujGeFYRmhvlZdzhJkAChO8AK7pWC1DJO3kdJd6gredYagDifA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KPS1Zq/3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KPS1Zq/3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm7Jk2K3wz2yVM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 01:53:09 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631CK1CX213344;
	Wed, 1 Apr 2026 14:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mU5QVu1EHsg2q/n977oobe+AMZflaJ
	O1Rx59stgMgho=; b=KPS1Zq/39JS1771SONkjCp+fgGD4jrscKXjDteCbggCTic
	rep84bBkD5RWnR8vSsQc1gYKQjHwfOH9sNXtuuUTEbajjkzk63XiZ6eYd0166iDk
	oXWOVh08O6XjjLInGP0q+F/beeicXFC/rlR4eQYA6T42ux5clc0P9RnDpLeSX84i
	KeFMRSQFRefMcayMLC/j/Y6O/796fnZ5d2pjBjmAFOL929j+pbIuoBquTV9DuQ+x
	CWWUNpo+tKj3Yy0AlWFJ+4NnWvvijjiKb7WTyT1CWgA7Mo1hv1U9nIwiuKVSxsNE
	M5VmORsAgeG1TQC2lfInK4a78UvzvOwoRWWSiuYg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7x68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:52:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CVBtE030947;
	Wed, 1 Apr 2026 14:52:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjwwgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:52:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631EqulN64815386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 14:52:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD75D58061;
	Wed,  1 Apr 2026 14:52:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6FDE58057;
	Wed,  1 Apr 2026 14:52:51 +0000 (GMT)
Received: from [9.39.18.42] (unknown [9.39.18.42])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 14:52:51 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------dNjMfuJP0K3YtjyprlSlepNv"
Message-ID: <2f5da9dd-812e-4645-8340-de8c6beec584@linux.ibm.com>
Date: Wed, 1 Apr 2026 20:22:50 +0530
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
Subject: Re: [PATCH v3 01/13] selftests/mm: restore default nr_hugepages value
 during cleanup in charge_reserved_hugetlb.sh
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <2ba0f8d8a00fd049e8ed4b97e9ce8ee6b58a2892.1774591179.git.sayalip@linux.ibm.com>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <2ba0f8d8a00fd049e8ed4b97e9ce8ee6b58a2892.1774591179.git.sayalip@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd314a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=DsmMYOnS3WCRA5PgjzcA:9 a=QEXdDO2ut3YA:10
 a=Npm3-rHHuYopk5QS1gAA:9 a=hdD9j4zQEDQSeOzc:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfXw3Wze+pj89wa
 T0vOjsJyg+a5wyi5syyyJvELUlNMvt1J30RLpDZUPyO42mzI4svIBPiKfR6Et1aQzkEEyCCBGpk
 eC1B5jHfYtLwsAiStzzXD4WG0dAmRoA5gRKy/7EkqJtFEPKlvk694cTFJDBMTFbeW6azhYAuDVb
 hvZIcJ+Me9FRyqEgLCQWjuDNjcka5NFnmiIKoD0ZstKjoeAufUtbYtWoX4saKyD5f4wZ8/ht9rV
 PzZH1cR696lwYIMBjPDyd945x3Bzm1pn0Qt6dUfcSPlRug4DFvyB5uJgrHck1zT3C9iP+fqi5QA
 X2oW3/r9PE3O63bDW0qZCAe3v1HqOpHOK3sUiSSHeqm5qOUJznzlbxqtR4uK3W2UceWXB/JGiEh
 bZeqabj5xM8KS/vmzsn3hTS/qqfEl3DLDcZ0QkQOPmz9DsUOYit6cJAmmAq6/fJECXyZ5qpp+vx
 +GerPXxJ8gf/M/7czjw==
X-Proofpoint-GUID: GESm7jRs_ey03Sr-d5jD0fDZ7-G9noAK
X-Proofpoint-ORIG-GUID: aX4UaqkiSG9zzk_jQhxsXTTpMPpKoP5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010138

This is a multi-part message in MIME format.
--------------dNjMfuJP0K3YtjyprlSlepNv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/03/26 12:45, Sayali Patil wrote:
> During cleanup, the value of /proc/sys/vm/nr_hugepages is currently being
> set to 0.  At the end of the test, if all tests pass, the original
> nr_hugepages value is restored.  However, if any test fails, it remains
> set to 0.
> With this patch, we ensure that the original nr_hugepages value is
> restored during cleanup, regardless of whether the test passes or fails.
>
> Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
> Reviewed-by: Zi Yan<ziy@nvidia.com>
> Reviewed-by: David Hildenbrand (Arm)<david@kernel.org>
> Tested-by: Venkat Rao Bagalkote<venkat88@linux.ibm.com>
> Signed-off-by: Sayali Patil<sayalip@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> index 447769657634..c9fe68b6fcf9 100755
> --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> @@ -65,7 +65,7 @@ function cleanup() {
>     if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
>       rmdir $cgroup_path/hugetlb_cgroup_test2
>     fi
> -  echo 0 >/proc/sys/vm/nr_hugepages
> +  echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
>     echo CLEANUP DONE
>   }
>   
AI review question:

Does this cause excessive memory allocation churn during test execution?
Since cleanup() is invoked before and after every test iteration, restoring
the original nr_hugepages here (which could be thousands of pages) and then
immediately setting it back to 10 in the next test case forces the kernel
to repeatedly allocate and free many hugepages for every single test case.
Also, does this reliably restore nr_hugepages on test failures?
The test script runs with "set -e" active. If a test fails while the
background write_to_hugetlbfs process is still running, commands earlier
in cleanup() like "rmdir /mnt/huge" can fail with EBUSY because the
directory is still a mounted filesystem.
Due to "set -e", this failure causes the script to immediately exit,
completely bypassing this restore command at the end of cleanup().
Would it be better to restore the original value once at the very end
of the script using an EXIT trap instead?

Yes, it is better to use an EXIT trap here to avoid unnecessary allocation
churn and to ensure the original value is reliably restored on all exit
paths.

A similar change can also be applied to |hugetlb_reparenting_test.sh|. The
test modifies |nr_hugepages| during execution and restores it from
|cleanup()|, while also reconfiguring it again in |setup()|, which is
invoked multiple times across the test flow. This can lead to repeated
allocation and freeing of hugepages.

I will prepare a patch for both tests and include it in v4.

Thanks,
Sayali

--------------dNjMfuJP0K3YtjyprlSlepNv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27/03/26 12:45, Sayali Patil wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:2ba0f8d8a00fd049e8ed4b97e9ce8ee6b58a2892.1774591179.git.sayalip@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">During cleanup, the value of /proc/sys/vm/nr_hugepages is currently being
set to 0.  At the end of the test, if all tests pass, the original
nr_hugepages value is restored.  However, if any test fails, it remains
set to 0.
With this patch, we ensure that the original nr_hugepages value is
restored during cleanup, regardless of whether the test passes or fails.

Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
Reviewed-by: Zi Yan <a class="moz-txt-link-rfc2396E" href="mailto:ziy@nvidia.com">&lt;ziy@nvidia.com&gt;</a>
Reviewed-by: David Hildenbrand (Arm) <a class="moz-txt-link-rfc2396E" href="mailto:david@kernel.org">&lt;david@kernel.org&gt;</a>
Tested-by: Venkat Rao Bagalkote <a class="moz-txt-link-rfc2396E" href="mailto:venkat88@linux.ibm.com">&lt;venkat88@linux.ibm.com&gt;</a>
Signed-off-by: Sayali Patil <a class="moz-txt-link-rfc2396E" href="mailto:sayalip@linux.ibm.com">&lt;sayalip@linux.ibm.com&gt;</a>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 447769657634..c9fe68b6fcf9 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -65,7 +65,7 @@ function cleanup() {
   if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
     rmdir $cgroup_path/hugetlb_cgroup_test2
   fi
-  echo 0 &gt;/proc/sys/vm/nr_hugepages
+  echo "$nr_hugepgs" &gt; /proc/sys/vm/nr_hugepages
   echo CLEANUP DONE
 }
 </pre>
    </blockquote>
    <font face="monospace">AI review question:<br>
      <br>
    </font>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Does this cause excessive memory allocation churn during test execution?</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Since cleanup() is invoked before and after every test iteration, restoring</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">the original nr_hugepages here (which could be thousands of pages) and then</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">immediately setting it back to 10 in the next test case forces the kernel</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">to repeatedly allocate and free many hugepages for every single test case.</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Also, does this reliably restore nr_hugepages on test failures?</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">The test script runs with "set -e" active. If a test fails while the</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">background write_to_hugetlbfs process is still running, commands earlier</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">in cleanup() like "rmdir /mnt/huge" can fail with EBUSY because the</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">directory is still a mounted filesystem.</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Due to "set -e", this failure causes the script to immediately exit,</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">completely bypassing this restore command at the end of cleanup().</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Would it be better to restore the original value once at the very end</div>
    <div class="diff-line ai-comment"
style="box-sizing: border-box; display: block; padding: 0px 4px 0px 12px; min-height: 1.3em; background-color: rgb(255, 255, 255); border-left: 2.8px solid rgb(40, 53, 147); font-weight: 500; color: rgb(36, 41, 47); font-family: ui-monospace, SFMono-Regular, &quot;SF Mono&quot;, Menlo, Consolas, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">of the script using an EXIT trap instead?</div>
    <br>
    <p data-start="0" data-end="153"><font face="monospace">Yes, it is
        better to use an EXIT trap here to avoid unnecessary allocation<br>
        churn and to ensure the original value is reliably restored on
        all exit<br>
        paths.</font></p>
    <p data-start="155" data-end="474"><font face="monospace">A similar
        change can also be applied to <code data-start="195"
          data-end="224">hugetlb_reparenting_test.sh</code>. The<br>
        test modifies <code data-start="244" data-end="258"
          data-is-only-node="">nr_hugepages</code> during execution and
        restores it from<br>
      </font>
      <code data-start="297" data-end="308">cleanup()</code><font
        face="monospace">, while also reconfiguring it again in <code
          data-start="347" data-end="356">setup()</code>, which is<br>
        invoked multiple times across the test flow. This can lead to
        repeated<br>
        allocation and freeing of hugepages.</font></p>
    <p data-start="476" data-end="535"><font face="monospace">I will
        prepare a patch for both tests and include it in v4.</font></p>
    <p data-start="537" data-end="553" data-is-last-node=""
      data-is-only-node=""><font face="monospace">Thanks,<br
          data-start="544" data-end="547">
        Sayali</font></p>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------dNjMfuJP0K3YtjyprlSlepNv--


