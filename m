Return-Path: <linuxppc-dev+bounces-25780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896D0C5B56A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 15:41:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKt5D5DnGz303K;
	Thu, 13 Aug 2026 01:41:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786549296;
	cv=none; b=MMzADO/jGz9mPKjdTVl8xWfyeDDiG7vh+8ZWgmL6ggO0n+biCSP+Hs7gktPewNldyFsg3fM2/VsAT657uzfOPNRw9VKManJuU2wpctiBLRDoR9P4AJM4LiodYL2djaPuvicOyklaNEYswvTesvNFD9vovSSNLJSbLCBuXSlC5WX6n2HVq9uoDkBg2iKqEDamn3fhgfe6pAp+Qi9q/oSc3TbcwCDUWn8w+n1F70sC1hgzfUH/pnrxR38PdmxptFQsztwDe0TRogCAPvoJZqI29iQGzBv8J4BhT6wH+nhi0ZTr4JYKNa2y2PbLigzAQpQ0I8y/pGGBaxMpCsVV0ZZiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786549296; c=relaxed/relaxed;
	bh=73Dl7m1PzClFoGxHfQ5sqhL21Q1t+CRne+viE4IY1/c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X4pOHBaMMhJaZJx3ksYip9E76uM+jtNVHmUNsRGJZmKQ16xOPIVb/RtTunryH7pyhpHFlnye5ssbg17Yl1cOKPzHjmUXM7agao+ACXAMKhfL+iZm9RpEII94P3FUopNShYRLX+a8/RRJ2ldjrRQjsKQ57EHSnfZW4n5lC3EfZbIjNQFiTs43CAGT1/HzotpjCW4stk6HTqlStg0UrgNKqgcROcGjpw8/A9HkPtKqy3XIt+oYP3oJ6Y7iKu+vkiJFgJ9cSjk4NT5rgAA2OWikz+/oPgOmS7/ue8isJNbPg8z0VvBiKOe4vjumq2Uxy45BpH0Dm87YZwagJdNIUp8hPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OSbsse+7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OSbsse+7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKt5C3N7Yz302l
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 01:41:35 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1d7B3717255;
	Wed, 12 Aug 2026 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=73Dl7m
	1PzClFoGxHfQ5sqhL21Q1t+CRne+viE4IY1/c=; b=OSbsse+70AkVwu7S7J1TOf
	IiOMV85aaKGDx50r7MKzbXkUCR+19MWmt+C0UcX/+hZZLBblbISSHxMrja0AjXcw
	HPgqtnW9DFn+2r4GO17P+ORjn76Got0x0b+Y4hjX/v4qK2vvb090bzXVplUlXc+w
	IvlXHlXypP+Xk3TF3L1hr+N350X/Iqa+OM3VhItaRre/aBGoIOk6zClOUTWZxvKH
	ctBwGXHIT6F+F0FtIk1ulz1OHRct4h1iGJOZgwlxm3x9DV4GNT2oKOQ4+uNvdVVu
	8Bt4aBe+2RbEkJU51fNbU8K9pH04sJsl1KqNVHlGMuS0Iv1+WTympA4q3O9gsLMw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwaem3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:41:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFfFQ2010357;
	Wed, 12 Aug 2026 15:41:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gek75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:41:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFfOea49938780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:41:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 223472004B;
	Wed, 12 Aug 2026 15:41:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465D220043;
	Wed, 12 Aug 2026 15:41:21 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Aug 2026 15:41:21 +0000 (GMT)
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
Subject: Re: [PATCH V5 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init
 into a separate file
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <9d5f7724-3b23-48b6-9441-961614294562@intel.com>
Date: Wed, 12 Aug 2026 21:11:09 +0530
Cc: acme@kernel.org, jolsa@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA14195C-0C72-4FA3-9236-BE6A45E6D3A5@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-2-atrajeev@linux.ibm.com>
 <9d5f7724-3b23-48b6-9441-961614294562@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c9429 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=QyXUC8HyAAAA:8
 a=VnNF1IyMAAAA:8 a=0bHTlfCrMkzSXunxx7MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xLVZhJh5vY66oW2ut9oF5CKYZkIHzCnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX6wRVirT5M3Lw
 mOu+qYMp25fJ+iHiFjVbochF7hi6f4y9ATxi2Fu6bxgkJdxX8julYH8jOBZPD9OO1GJBQZu5cYh
 8YVoZvUAfLM+R84VlkOkCJtugPGl/29siFgtp90KzetJAteSaQ7mbin5X86I0E2zseXHSgj+8EC
 pCr+aN5N+RQrs1YZkHT/aBhs9oSnKilq17cSVII308DppskF/qZgEppgBLzhGHywIVLDQ3HuAhA
 jKK7QcLLaCN1lk0gbjNFAA7F2pShGB96e54i6sEoAjw7Es8RiXaDXw3rX/xJUaCmP0n9DqPdHdy
 5bOKrqErecUmfJTd25r7CWETaayuZlyggABKJkKL13osM0ahxR5eiQAx6HLpabB4NPbhgnod12F
 o5nsEIS8Z1PGSHAayWM4+jYBtI/kKyuWaAYWzBLfntJQmebMVzJoFjSbIqBbEaiA4fraps6Do6x
 LlNionGupZmRs/cAwtQ==
X-Proofpoint-ORIG-GUID: B3lxL_-kqgIH6KLRWtZ9CvBH5uReUMZC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1zWmUj2WJJ7j
 KGyWaTwOwl24lCLz1pO/9xZrZAvwbRzYLDR+i2s4vxaWoRLmfLx/XVXTAnrQVqUjS+HxGJSDbIt
 3n8e/pKpIP5l8WsDICUqsauuUA5IfMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126



> On 12 Aug 2026, at 3:00=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>=20
> On 07/08/2026 17:41, Athira Rajeev wrote:
>> The powerpc auxtrace dispatch lives entirely in
>> arch/powerpc/util/auxtrace.c.  As new PMUs such as HTM are added, =
this
>> file would grow to contain the recording logic for all of them.
>>=20
>> Factor out the VPA-DTL recording initializer into its own file,
>> arch/powerpc/util/vpa-dtl.c, and reduce auxtrace.c to a thin dispatch
>> layer.  auxtrace_record__init() now detects the PMU by name and calls
>> the appropriate per-PMU init function:
>>=20
>>  - vpa_dtl_recording_init() for VPA-DTL events (unchanged behaviour)
>>  - Further PMU entries will follow in subsequent patches
>>=20
>> This makes room in auxtrace_record__init() for the HTM recording path
>> added in the next patch without growing a single monolithic file.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> A couple of cosmetic / very minor comments.
>=20
> Nevertheless:
>=20
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>=20
>> ---
>> Changes in V5:
>> - Add forward declarations for struct evsel and struct =
auxtrace_record
>>  in powerpc-vpadtl.h before the vpa_dtl_recording_init() prototype.
>>  Without them, a translation unit that includes the header before the
>>  full definitions are visible may produce implicit-declaration =
warnings
>>  on strict compilers.
>>=20
>> Changes in V4:
>> - No changes from V3.
>>=20
>> Changes in V3:
>> Add #include <linux/zalloc.h> to vpa-dtl.c; without it the compiler
>> treats zalloc() as implicitly returning int, truncating the upper
>> 32 bits of the returned pointer on 64-bit PowerPC.
>>=20
>> Changes in V2:
>> - Renamed the destination file from arch/powerpc/util/vpa-dtl.c (same
>>  name, unchanged) but the subject and commit message are reworded to
>>  clearly state that the goal is to make auxtrace_record__init() a =
thin
>>  per-PMU dispatcher, not merely to "allow multiple PMUs to use =
auxtrace".
>> - Handle failure from memory allocation
>> - Included stdlib and limits.h
>> - No functional change to the VPA-DTL path itself.
>> - Patch is now 1/6 instead of 1/9.
>>=20
>> tools/perf/arch/powerpc/util/Build      |  1 +
>> tools/perf/arch/powerpc/util/auxtrace.c | 84 +++-------------------
>> tools/perf/arch/powerpc/util/vpa-dtl.c  | 96 =
+++++++++++++++++++++++++
>> tools/perf/util/powerpc-vpadtl.h        |  3 +
>> 4 files changed, 108 insertions(+), 76 deletions(-)
>> create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/Build =
b/tools/perf/arch/powerpc/util/Build
>> index ae928050e07a..7819c8f5af2d 100644
>> --- a/tools/perf/arch/powerpc/util/Build
>> +++ b/tools/perf/arch/powerpc/util/Build
>> @@ -7,3 +7,4 @@ perf-util-y +=3D evsel.o
>> perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
>>=20
>> perf-util-y +=3D auxtrace.o
>> +perf-util-y +=3D vpa-dtl.o
>> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c =
b/tools/perf/arch/powerpc/util/auxtrace.c
>> index 4600a1661b4f..e04a0bd61755 100644
>> --- a/tools/perf/arch/powerpc/util/auxtrace.c
>> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
>> @@ -13,63 +13,12 @@
>> #include "../../util/auxtrace.h"
>> #include "../../util/powerpc-vpadtl.h"
>> #include "../../util/record.h"
>> -#include <internal/lib.h> // page_size
>> -
>> -#define KiB(x) ((x) * 1024)
>> -
>> -static int
>> -powerpc_vpadtl_recording_options(struct auxtrace_record *ar =
__maybe_unused,
>> - struct evlist *evlist __maybe_unused,
>> - struct record_opts *opts)
>> -{
>> - opts->full_auxtrace =3D true;
>> -
>> - /*
>> -  * Set auxtrace_mmap_pages to minimum
>> -  * two pages
>> -  */
>> - if (!opts->auxtrace_mmap_pages) {
>> - opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
>> - if (opts->mmap_pages =3D=3D UINT_MAX)
>> - opts->mmap_pages =3D KiB(256) / page_size;
>> - }
>> -
>> - return 0;
>> -}
>> -
>> -static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record =
*itr __maybe_unused,
>> - struct evlist *evlist __maybe_unused)
>> -{
>> - return VPADTL_AUXTRACE_PRIV_SIZE;
>> -}
>> -
>> -static int
>> -powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
>> - struct perf_session *session __maybe_unused,
>> - struct perf_record_auxtrace_info *auxtrace_info,
>> - size_t priv_size __maybe_unused)
>> -{
>> - auxtrace_info->type =3D PERF_AUXTRACE_VPA_DTL;
>> -
>> - return 0;
>> -}
>> -
>> -static void powerpc_vpadtl_free(struct auxtrace_record *itr)
>> -{
>> - free(itr);
>> -}
>> -
>> -static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr =
__maybe_unused)
>> -{
>> - return 0;
>> -}
>>=20
>> struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>> int *err)
>> {
>> - struct auxtrace_record *aux;
>> struct evsel *pos;
>> - int found =3D 0;
>> + struct evsel *vpa_dtl_evsel =3D NULL;
>=20
> Ordering local definitions by descending line length is nicer e.g.
>=20
> struct evsel *vpa_dtl_evsel =3D NULL;
>   struct evsel *pos;

Sure, I will address this in next version

Thanks for review Adrian.
I will wait for feedback on the remaining patches and post a v6 =
incorporating all the changes together.

Athira

>=20
>>=20
>> /*
>>  * Set err value to zero here. Any fail later
>> @@ -78,33 +27,16 @@ struct auxtrace_record =
*auxtrace_record__init(struct evlist *evlist,
>> *err =3D 0;
>>=20
>> evlist__for_each_entry(evlist, pos) {
>> - if (strstarts(pos->name, "vpa_dtl")) {
>> - found =3D 1;
>> + if (pos->name && strstarts(pos->name, "vpa_dtl")) {
>> pos->needs_auxtrace_mmap =3D true;
>> - break;
>> + /* Remember the first matching VPA DTL event */
>> + if (!vpa_dtl_evsel)
>> + vpa_dtl_evsel =3D pos;
>> }
>> }
>>=20
>> - if (!found)
>> - return NULL;
>> -
>> - /*
>> -  * To obtain the auxtrace buffer file descriptor, the auxtrace =
event
>> -  * must come first.
>> -  */
>> - evlist__to_front(pos->evlist, pos);
>> -
>> - aux =3D zalloc(sizeof(*aux));
>> - if (aux =3D=3D NULL) {
>> - pr_debug("aux record is NULL\n");
>> - *err =3D -ENOMEM;
>> - return NULL;
>> - }
>> + if (vpa_dtl_evsel)
>> + return vpa_dtl_recording_init(vpa_dtl_evsel, err);
>>=20
>> - aux->recording_options =3D powerpc_vpadtl_recording_options;
>> - aux->info_priv_size =3D powerpc_vpadtl_info_priv_size;
>> - aux->info_fill =3D powerpc_vpadtl_info_fill;
>> - aux->free =3D powerpc_vpadtl_free;
>> - aux->reference =3D powerpc_vpadtl_reference;
>> - return aux;
>> + return NULL;
>> }
>> diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c =
b/tools/perf/arch/powerpc/util/vpa-dtl.c
>> new file mode 100644
>> index 000000000000..2609b88f61d8
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * VPA DTL AUX tracing support
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/string.h>
>> +#include <linux/zalloc.h>
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <limits.h>
>> +#include "../../util/cpumap.h"
>=20
> Is cpumap.h needed?
Ok, I will check this
>=20
>> +#include "../../util/evsel.h"
>> +#include "../../util/evlist.h"
>> +#include "../../util/session.h"
>> +#include "../../util/util.h"
>> +#include "../../util/debug.h"
>> +#include "../../util/auxtrace.h"
>> +#include "../../util/powerpc-vpadtl.h"
>> +#include "../../util/record.h"
>> +#include <internal/lib.h> // page_size
>> +
>> +#define KiB(x) ((x) * 1024)
>> +
>> +static int
>> +powerpc_vpadtl_recording_options(struct auxtrace_record *ar =
__maybe_unused,
>> + struct evlist *evlist __maybe_unused,
>> + struct record_opts *opts)
>> +{
>> + opts->full_auxtrace =3D true;
>> +
>> + /*
>> +  * Set auxtrace_mmap_pages to minimum
>> +  * two pages
>> +  */
>> + if (!opts->auxtrace_mmap_pages) {
>> + opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
>> + if (opts->mmap_pages =3D=3D UINT_MAX)
>> + opts->mmap_pages =3D KiB(256) / page_size;
>> + }
>> +
>> + return 0;
>> +}
>> +
>> +static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record =
*itr __maybe_unused,
>> + struct evlist *evlist __maybe_unused)
>> +{
>> + return VPADTL_AUXTRACE_PRIV_SIZE;
>> +}
>> +
>> +static int
>> +powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
>> + struct perf_session *session __maybe_unused,
>> + struct perf_record_auxtrace_info *auxtrace_info,
>> + size_t priv_size __maybe_unused)
>> +{
>> + auxtrace_info->type =3D PERF_AUXTRACE_VPA_DTL;
>> +
>> + return 0;
>> +}
>> +
>> +static void powerpc_vpadtl_free(struct auxtrace_record *itr)
>> +{
>> + free(itr);
>> +}
>> +
>> +static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr =
__maybe_unused)
>> +{
>> + return 0;
>> +}
>> +
>> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, =
int *err)
>> +{
>> + struct auxtrace_record *aux;
>> +
>> + /*
>> +  * To obtain the auxtrace buffer file descriptor, the auxtrace =
event
>> +  * must come first.
>> +  */
>> + evlist__to_front(pos->evlist, pos);
>> +
>> + aux =3D zalloc(sizeof(*aux));
>> + if (aux =3D=3D NULL) {
>> + pr_debug("aux record allocation failed (-ENOMEM)\n");
>> + *err =3D -ENOMEM;
>> + return NULL;
>> + }
>> +
>> + aux->recording_options =3D powerpc_vpadtl_recording_options;
>> + aux->info_priv_size =3D powerpc_vpadtl_info_priv_size;
>> + aux->info_fill =3D powerpc_vpadtl_info_fill;
>> + aux->free =3D powerpc_vpadtl_free;
>> + aux->reference =3D powerpc_vpadtl_reference;
>> + return aux;
>> +}
>> diff --git a/tools/perf/util/powerpc-vpadtl.h =
b/tools/perf/util/powerpc-vpadtl.h
>> index ca809660b9bb..68a780c63204 100644
>> --- a/tools/perf/util/powerpc-vpadtl.h
>> +++ b/tools/perf/util/powerpc-vpadtl.h
>> @@ -20,4 +20,7 @@ struct perf_pmu;
>> int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
>>   struct perf_session *session);
>>=20
>> +struct evsel;
>> +struct auxtrace_record;
>> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, =
int *err);
>> #endif



