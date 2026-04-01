Return-Path: <linuxppc-dev+bounces-19171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8951B10F6FBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:05:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8wb20WXz2yhY;
	Thu, 02 Apr 2026 03:05:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059551;
	cv=none; b=ASUyW3QlJxtZic8FIZzuPk579vHH8PxP0Prx8jO2I8SpwDGT0Seqzo3nW6ls0nFIKebC+dfl3HqU2k+yUPyU0RAp5fbHDv9d1EGWIkGCWR6xHchWEMGUmXrGhpY6GBc2EipMmWF+q7zoObiPFLJdQ4RbwybqzFv13r8oMILpBSWn2CivPU+5I0+ddeEYIjJSjvSqm0uzSGYxNGUhPHyMpeVsFCe1trRwzhwCHIFBz053DUFJTbFs9qKNUwKKHsQKRVN6isT8w+MtZh+8OW6s3axIq3Wdnx9v1l7g0bSg+1X253kXxUaVIDC38UmXWmug5FRYxhl3b6bbQ1pPRe7iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059551; c=relaxed/relaxed;
	bh=DS41ytpRnWbYo6AReClMhBSZ/2PMMtxIe4+jyO36Jy8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=kmq69/QPoihm1B082QJYT51MFl41ruP9Hh18fD/h4E0COsopdRgW/ARExCnfBWvenQiiCQxQ0ywWt8eaN3DY5sWU9l3vb1zoP3kGeoQMJWKRszRIIqp4vp8bNNMEy4YjveCHU4nUk+vd0YzLX8RxFS8C3ayPTMJmy4RFwEVm9RolpHgKNB6qiHoCh0GBDdnktL6q26F0MzZJrsVwF1A9FCjkehN8nE5cjsDhP6XCuzSzdP/VznwM1WQMGYZawi84H/VamRDwtYI2A4e/v/eZ/k6TtckaXuTmerXvbm462M5hP+85l7Kf4K9h4pjoMm4FWOa1XtZeYgYCJFXS5FGLOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m8bvimfo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m8bvimfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8wY40NPz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:05:49 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631DhxMi361878;
	Wed, 1 Apr 2026 16:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DS41ytpRnWbYo6AReClMhBSZ/2PMMt
	xIe4+jyO36Jy8=; b=m8bvimfo7sQ7K+OFSaJF+fwyFLGJFa3QPjPgbq2rC6ADa5
	E3zitbZ9xaIydBNiDNYbW0INvHaSckqQhTIfcoLFtvTcRUFCv5Avx5cCeV1LIB0l
	Nq5jcYWgZQ04m5DJ55lWJgOo5JUbmUypq8/wBexPkuRdBKiLqIFqfMtAYH4NE4UV
	FlTP8ujgRDSQRib+7glYBE4xeVOmjLQl+sUsZkincDF3MPr7SxTeTLIqNpNq3rkK
	NeT/DGU9+91/BklpL1tQNVHQiEH2rj8853hlh3PZZCzVF/T6HzQ2vZQ4pxvW7Mob
	yi3xJQyEjmIS0n5EyhModM55fB+55D602kLSvtSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgreas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:05:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631FdtHT013936;
	Wed, 1 Apr 2026 16:05:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkp8b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 16:05:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631G5ai933423888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 16:05:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3662258061;
	Wed,  1 Apr 2026 16:05:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22EBE58056;
	Wed,  1 Apr 2026 16:05:31 +0000 (GMT)
Received: from [9.39.18.42] (unknown [9.39.18.42])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 16:05:30 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------Z1mtNmbpFyIZY1A5sUbCG03n"
Message-ID: <df407504-0e24-4c0d-85f5-3ef2deb86a50@linux.ibm.com>
Date: Wed, 1 Apr 2026 21:35:29 +0530
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
From: Sayali Patil <sayalip@linux.ibm.com>
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
 <2f5da9dd-812e-4645-8340-de8c6beec584@linux.ibm.com>
Content-Language: en-IN
In-Reply-To: <2f5da9dd-812e-4645-8340-de8c6beec584@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0OCBTYWx0ZWRfX1E+RdoVFV/MG
 MGtpgYTdtAoWaxRvQzG69ZMhwUvom3yvWDAGhabg2aJVhjFWxLA6T3NQx7NQvCWE5EyonevaoOx
 l57i9I5vAIjRHQj6V6wFIkab70BpwHqttIH71h2+YnK/0gUcA05rpeEl/QCJPeJGe0ees/6+ElX
 BJhtZ1Y7psneX6tZXG/KaQmQdbsvZvvjhc85vyvN35ZZKLrK6zd6R6SdnlfDM6mpzgxjUWNTxxi
 IF6Ch75QqhItgkulhJCTzVDcX5FGwu2NNTOjqPv5IEwp+75ndwHPc/G1oCN8NGTM8zj+gEJ2d68
 ftktOEGsmQUtQIu/Bb7cYvlMiLbP2Id2HJ6MgFaAydnoWtcPwq7xRJIDkJS8TEBQkUEqQCMbUVg
 AYZT7Ui2TADS6k7USyqewzDiblCGeRsZT/SjQWsvicEaQOC1xP0fXW6xXZSwTq2/g6RUkTZAdPl
 MEQVfxxFBI+JtTmKSeQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cd4252 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=r77TgQKjGQsHNAKrUKIA:9 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=oXnG4xuSCdGAOdH6UXUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Npm3-rHHuYopk5QS1gAA:9 a=sTxRpBpiy98KL1WkT8X2XIWo+SM=:19
 a=OnTCA0UXLqtbvC45:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: QbFgDZ6yCipgXBCMc5U6gz-Wzy_ElmVQ
X-Proofpoint-ORIG-GUID: QXtvmoxprzUNYoGnGF5H3qs55tu-XvjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010148

This is a multi-part message in MIME format.
--------------Z1mtNmbpFyIZY1A5sUbCG03n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/04/26 20:22, Sayali Patil wrote:
> On 27/03/26 12: 45, Sayali Patil wrote: During cleanup, the value of 
> /proc/sys/vm/nr_hugepages is currently being set to 0. At the end of 
> the test, if all tests pass, the original nr_hugepages value is 
> restored. However, if any test fails, it
> ZjQcmQR
> ZjQcmQRYFpfptBannerEnd
> On 27/03/26 12:45, Sayali Patil wrote:
>> During cleanup, the value of /proc/sys/vm/nr_hugepages is currently being
>> set to 0.  At the end of the test, if all tests pass, the original
>> nr_hugepages value is restored.  However, if any test fails, it remains
>> set to 0.
>> With this patch, we ensure that the original nr_hugepages value is
>> restored during cleanup, regardless of whether the test passes or fails.
>>
>> Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
>> Reviewed-by: Zi Yan<ziy@nvidia.com>
>> Reviewed-by: David Hildenbrand (Arm)<david@kernel.org>
>> Tested-by: Venkat Rao Bagalkote<venkat88@linux.ibm.com>
>> Signed-off-by: Sayali Patil<sayalip@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
>> index 447769657634..c9fe68b6fcf9 100755
>> --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
>> +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
>> @@ -65,7 +65,7 @@ function cleanup() {
>>     if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
>>       rmdir $cgroup_path/hugetlb_cgroup_test2
>>     fi
>> -  echo 0 >/proc/sys/vm/nr_hugepages
>> +  echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
>>     echo CLEANUP DONE
>>   }
>>   
Previous reply was not formatted properly so sending it again.

AI review question
> Does this cause excessive memory allocation churn during test execution?
> Since cleanup() is invoked before and after every test iteration, restoring
> the original nr_hugepages here (which could be thousands of pages) and then
> immediately setting it back to 10 in the next test case forces the kernel
> to repeatedly allocate and free many hugepages for every single test case.
> Also, does this reliably restore nr_hugepages on test failures?
> The test script runs with "set -e" active. If a test fails while the
> background write_to_hugetlbfs process is still running, commands earlier
> in cleanup() like "rmdir /mnt/huge" can fail with EBUSY because the
> directory is still a mounted filesystem.
> Due to "set -e", this failure causes the script to immediately exit,
> completely bypassing this restore command at the end of cleanup().
> Would it be better to restore the original value once at the very end.
>   

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



--------------Z1mtNmbpFyIZY1A5sUbCG03n
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
    <div class="moz-cite-prefix">On 01/04/26 20:22, Sayali Patil wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2f5da9dd-812e-4645-8340-de8c6beec584@linux.ibm.com">
      <!-- BaNnErBlUrFlE-BoDy-start -->
      <!-- Preheader Text : BEGIN -->
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div
style="display:none !important;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;overflow:hidden;">
        On 27/03/26 12: 45, Sayali Patil wrote: During cleanup, the
        value of /proc/sys/vm/nr_hugepages is currently being set to 0.
        At the end of the test, if all tests pass, the original
        nr_hugepages value is restored. However, if any test fails, it</div>
      <!-- Preheader Text : END -->
      <!-- Email Banner : BEGIN -->
      <div
style="display:none !important;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;overflow:hidden;">ZjQcmQR</div>
      <div
style="display:none !important;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;overflow:hidden;">ZjQcmQRYFpfptBannerEnd</div>
      <!-- Email Banner : END -->
      <!-- BaNnErBlUrFlE-BoDy-end -->
      <!-- BaNnErBlUrFlE-HeAdEr-start -->
      <style>#pfptBanner6bb4zwh { all: revert !important; display: block !important;
    visibility: visible !important; opacity: 1 !important;
    background-color: #d0d8dc !important;
    max-width: none !important; max-height: none !important }.pfptPrimaryButton6bb4zwh:hover, .pfptPrimaryButton6bb4zwh:focus {
    background-color: #b4c1c7 !important; }.pfptPrimaryButton6bb4zwh:active {
    background-color: #90a4ae !important; }html:root, html:root>body { all: revert !important; display: block !important;
    visibility: visible !important; opacity: 1 !important; }</style>
      <div class="moz-cite-prefix">On 27/03/26 12:45, Sayali Patil
        wrote:<br>
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
Reviewed-by: Zi Yan <a class="moz-txt-link-rfc2396E"
        href="mailto:ziy@nvidia.com" moz-do-not-send="true">&lt;ziy@nvidia.com&gt;</a>
Reviewed-by: David Hildenbrand (Arm) <a class="moz-txt-link-rfc2396E"
        href="mailto:david@kernel.org" moz-do-not-send="true">&lt;david@kernel.org&gt;</a>
Tested-by: Venkat Rao Bagalkote <a class="moz-txt-link-rfc2396E"
        href="mailto:venkat88@linux.ibm.com" moz-do-not-send="true">&lt;venkat88@linux.ibm.com&gt;</a>
Signed-off-by: Sayali Patil <a class="moz-txt-link-rfc2396E"
        href="mailto:sayalip@linux.ibm.com" moz-do-not-send="true">&lt;sayalip@linux.ibm.com&gt;</a>
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
    </blockquote>
    <font face="monospace">Previous reply was not formatted properly so
      sending it again.<br>
      <br>
      AI review question
    </font>
    <blockquote type="cite"
cite="mid:2ba0f8d8a00fd049e8ed4b97e9ce8ee6b58a2892.1774591179.git.sayalip@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Does this cause excessive memory allocation churn during test execution?
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
Would it be better to restore the original value once at the very end.
 
</pre>
    </blockquote>
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
      </font> <code data-start="297" data-end="308">cleanup()</code><font
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
    <br>
    <br>
  </body>
</html>

--------------Z1mtNmbpFyIZY1A5sUbCG03n--


