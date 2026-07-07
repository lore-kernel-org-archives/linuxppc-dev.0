Return-Path: <linuxppc-dev+bounces-23706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA23C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:03:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvjcl5f94z3brt;
	Wed, 08 Jul 2026 00:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783433015;
	cv=none; b=IwNtyqCLwKFuCNOFd30P52q5lZqkdXIQ0yFWBhePOueOSLPtFQLO9TjbetgGa6h8oR66Yxi4H8IkgYdbLWNijy+cZpTsq89RYmK1OqE4AYf20yOsDsZ3bzeBLBLBX4SH2JKcZyYIOdqDDhifa7g5QNG+/KSaUTDp6hb9WgSaWS3ICWA5dzMo7jtvkW+xoVLJ4d5TVcAAKxaQre6lj8HW/bKAwlWYdOSQWxuLJZwBS+UxmppOAWkWwPktFkwYJeoqyXXeoXoVN+QQOWqG53N1TMmxMGE6EhByz6XAqMhwfL4ZGpg+18to5f3JEAPacsqLrsedfjR93qYfxIuSYKuvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783433015; c=relaxed/relaxed;
	bh=Xtf2ue7sY7pKFZh11Wx+E6Pd2DiCCFQsMld4+4lDZO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmO3U4hJ0NbTDYgWdH6+Qtt1X9I/Srp9oSb3yDRXQbCssOYFG3bBql7chjxXdUCNE4BtgcwCMF88HDiiV84zK4RZB8flgc/ZVqE4kz0oCDRKfB4TTAky0vs9Ps6UsoU79mmrPlqI8kHdIejI8FmwmpTlQoaN4px7FxMt7lLgqW1HhMpz3XZZmeMEnizQekN9xY9EzKqxnj4hv+XVCF30ocTXUJsxBkMaYtmurtL2obyZuC5CHK2n4QFhodxzZBnl/Ypa1oRTrVFSYsDIr6Cel0zPUAE3jIsPKiDSVdVTwqJzSvOfrhFEJqiRNfSC2MQwpt0gDU4xmBPq5xYbbgFz7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pKEzzdQM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pKEzzdQM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvjck3hCWz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 00:03:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667CIbjg2898965;
	Tue, 7 Jul 2026 14:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xtf2ue
	7sY7pKFZh11Wx+E6Pd2DiCCFQsMld4+4lDZO0=; b=pKEzzdQMFUP581iZ9F3LhY
	ZS5xfP4Lb+AqIGe+dt2a8xCmWTWEcQGftyl2/zIBfOG3wyNF5SsxcNfBx50+eA3j
	B6Gfmqvitu64E/dpSMFy6P51kVbfdoGGFKqyUCrPiAhxlfROyB/mXI9NGKUoZgJJ
	7jo9oKoujyXmS9IjSDWTL8jbImkpO+W7vqanUsjfip1Z7vBZd1zrOlodSgL9wHr9
	T39//mxQq/ybeyELsUHLex1EDCc7evzCkF5SDkvSzV6rTsvry2axpnKw0KTjhbDA
	gF2jLhaOyV3P5u+RO2duCY8K9QzG6nlF/za80k577SGpaXMgW/M8EgKq9wxOMXuQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdr3jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:03:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Dnlqo006734;
	Tue, 7 Jul 2026 14:03:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk34rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:03:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667E3MPp37486926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 14:03:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 809A45805A;
	Tue,  7 Jul 2026 14:03:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1723E5805C;
	Tue,  7 Jul 2026 14:03:16 +0000 (GMT)
Received: from [9.124.215.22] (unknown [9.124.215.22])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 14:03:15 +0000 (GMT)
Message-ID: <92d309a7-3ae6-4f3c-8fed-6516b0fcfc07@linux.ibm.com>
Date: Tue, 7 Jul 2026 19:33:14 +0530
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
Subject: Re: [PATCH v3] perf dso: Fix kallsyms DSO detection with fallback
 logic
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260626161052.1024439-2-tshah@linux.ibm.com>
 <akRWfQB9lLwq2HsR@google.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <akRWfQB9lLwq2HsR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4d072e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5uYLPgFzFGA3NYaybQcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX58Y4pr9+kU8b
 knBQAP7WfT9qzWYperTUNMLirW0o4tAfw2n6pxKvhos+vVMZ1r0Vi99GfrjdfE2VPetDJL6+Cvu
 Gao0LGRRRIqZEm3d0LQmBrjM2m33syEEmiHw9Mc555b87kyDtG+iEUGBmkTsNwCAk2fuXIwMNSq
 wTrzc1LSxBd6p9HUJ9JusNhXlMfrjhfWOk9rWFsK0MaLDuF1PFjnnfL11PE8v4YmCo2cFgovClI
 Ob+duUY/+O92FgtRxP9uVQHiizCI9xR/2utAeNX3k7PRzpZF4vDG5a0tw5EYbp91aTS3xtESHir
 hhsC23r2GUrb+rKguB9Bp+XFZOpNkqghoyffi1kUTOVwAT8gLhc/dEQaLXS69l+ETJmNUczDQvZ
 wzmrZ1TPfiuc6nqR0SIJVRfMjkCbS0hBYHTWNLQcXbPksOpUpYz91oRATce6p94fCedAJvHfGTR
 3amvV5yzn95rDDkvd4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX7v4rd5M+J4ZN
 ZupCd6givk0h2aBXL8mweoelIqTzdxgknrNf+PQA5RKZ03PueHpYBFjMtNtRd5WYGAf1SLhY6TN
 lVamAVnfLRHTw3bSBmigrLDW2giN+FA=
X-Proofpoint-GUID: 7SSnthEi3pghzM5tOZgtuX2OlY9K8bJg
X-Proofpoint-ORIG-GUID: Z4UtmJBvuoz4EyWzPjjRkTgm3EROTyjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070135


Hello, Thanks for the review.
On 01/07/26 05:21, Namhyung Kim wrote:
> On Fri, Jun 26, 2026 at 09:40:53PM +0530, Tanushree Shah wrote:
>> The current kallsyms detection in dso__is_kallsyms() uses the
>> dso_binary_type enum which fixes the issue of kallsyms being cached in
>> the build-id cache for out-of-tree modules.
>>
>> However, during build-id injection in perf record/inject, dso_binary_type
>> has not been explicitly set yet,so dso__binary_type() returns
>> DSO_BINARY_TYPE__NOT_FOUND instead of DSO_BINARY_TYPE__KALLSYMS for the
>> kernel DSO. The current check then fails to identify it as kallsyms,
>> causing build-id symlinks to not be created in ~/.debug/.build-id/ and
>> perf archive to fail with "Cannot stat" errors.
>>
>> Steps to reproduce the issue:
>> 1. rm -rf ~/.debug/.build-id
>> 2. perf record sleep 1
>> 3. perf archive
>>
>> Fix by falling back to matching long_name against the known kallsyms
>> strings explicitly when binary_type is not yet set
>> (== DSO_BINARY_TYPE__NOT_FOUND). Use strcmp() for exact matching of
>> fixed names and strict validation for guest kallsyms with embedded PID
>> to prevent path traversal attacks.
>>
>> Fixes: ebf0b332732d ("perf dso: fix dso__is_kallsyms() check")
>> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
>> ---
>> v2 -> v3: Replace strncmp() prefix matching with strcmp() for fixed
>>            kallsyms names and add is_guest_kallsyms_pid_name() to
>>            strictly validate guest kallsyms with PID format, preventing
>>            path traversal attacks.
>>
>> v1 -> v2: Rename DSO__NAME_GUEST_KALLSYMS to DSO__PREFIX_GUEST_KALLSYMS
>>            to reflect that it is a prefix, not a full name.
>>
>> v1: https://lore.kernel.org/all/20260410071225.708005-2-tshah@linux.ibm.com/
>>
>>   tools/perf/util/dso.h | 57 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index ede691e9a249..8763e6f65316 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
>> @@ -9,6 +9,7 @@
>>   #include <stdbool.h>
>>   #include <stdio.h>
>>   #include <linux/bitops.h>
>> +#include <string.h>
>>   #include "build-id.h"
>>   #include "debuginfo.h"
>>   #include "mutex.h"
>> @@ -20,6 +21,40 @@ struct perf_env;
>>   
>>   #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
>>   #define DSO__NAME_KCORE		"[kernel.kcore]"
>> +#define DSO__NAME_GUEST_KALLSYMS		"[guest.kernel.kallsyms]"
>> +#define DSO__NAME_GUEST_KALLSYMS_PID_PREFIX	"[guest.kernel.kallsyms."
>> +
>> +/*
>> + * Validate names of the form "[guest.kernel.kallsyms.<pid>]", where
>> + * <pid> is the PID of the guest VM and varies per guest, so it
>> + * cannot be matched with strcmp() against a fixed string.
>> + *
>> + * Every character after the fixed prefix must be a decimal digit,
>> + * with ']' immediately terminating the digit run and nothing
>> + * following it. This rules out '/', "..", or any other character
>> + * being smuggled into the name.
>> + */
>> +static inline bool is_guest_kallsyms_pid_name(const char *name)
>> +{
>> +	const size_t prefix_len = sizeof(DSO__NAME_GUEST_KALLSYMS_PID_PREFIX) - 1;
>> +	size_t digits;
>> +
>> +	if (strncmp(name, DSO__NAME_GUEST_KALLSYMS_PID_PREFIX, prefix_len) != 0)
>> +		return false;
>> +
>> +	digits = strspn(name + prefix_len, "0123456789");
>> +	if (digits == 0)
>> +		return false;
>> +
>> +	/* ']' must terminate the digit run, with nothing trailing it */
>> +	if (name[prefix_len + digits] != ']')
>> +		return false;
>> +
>> +	if (name[prefix_len + digits + 1] != '\0')
>> +		return false;
>> +
>> +	return true;
>> +}
>>   
>>   /**
>>    * enum dso_binary_type - The kind of DSO generally associated with a memory
>> @@ -914,8 +949,28 @@ static inline bool dso__is_kcore(const struct dso *dso)
>>   static inline bool dso__is_kallsyms(const struct dso *dso)
>>   {
>>   	enum dso_binary_type bt = dso__binary_type(dso);
> 
> I have to check its usage carefully but any chance dso__symtab_type(dso)
> instead produces better results?
> 
I did some additional logging and found that symtab_type is not getting 
set while running perf record, so it seems dso__symtab_type(dso) would 
likely have the same issue here.
> 
>> +	const char *name;
>> +
>> +	if (bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS)
>> +		return true;
>> +
>> +	if (bt != DSO_BINARY_TYPE__NOT_FOUND)
>> +		return false;
>> +
>> +	if (!RC_CHK_ACCESS(dso)->kernel)
> 
> I think the proper wrapper is dso__kernel().
> 
Thanks for the pointer. Will use this and send v4.
> 
>> +		return false;
>> +
>> +	name = RC_CHK_ACCESS(dso)->long_name;
> 
> And dso__long_name().

Sure, will use this and send v4.
> 
> Thanks,
> Namhyung
> 
> 
>> +	if (!name)
>> +		return false;
>> +
>> +	if (!strcmp(name, DSO__NAME_KALLSYMS))
>> +		return true;
>> +
>> +	if (!strcmp(name, DSO__NAME_GUEST_KALLSYMS))
>> +		return true;
>>   
>> -	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
>> +	return is_guest_kallsyms_pid_name(name);
>>   }
>>   
>>   bool dso__is_object_file(const struct dso *dso);
>> -- 
>> 2.47.3
>>
> 
Thanks
Tanushree Shah


