Return-Path: <linuxppc-dev+bounces-18236-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEDF46426
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:49:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ9KC1XNCz2yFl;
	Mon, 16 Mar 2026 20:49:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654543;
	cv=none; b=KbQ7mCyzqhScnMUCO4yWGwl+MPPQpYL7ktYoRlFJ3D8uAesTodyqCtmTLXFNDlBcGcKr3pczDajyE8LFQwv6FTZbaWXh0twbNYC8jizcRKDZKDyH/0a4UUibp6OZzjnWMOS+xZVGBat14+JRUWykLQi7jLc/B86bkvz4P66PmnlUuidNZFys8feZ+aiBbKLP9K5v1iah48g5FXW6pJMAojtCASy8JI87Vq8h2gvLjlfOCsXM0U6Q4kyNVu7KO/HzSWL+IwZmZpI1yxQBVqpIo2ebctm5IluNm50FmtZuf7VHd7CgKdBWmdKT4xBsB86bDfSJ+WymdM3yqXrApiVWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654543; c=relaxed/relaxed;
	bh=UoMtsZuwOsAX2SqQE1TRmRqWsmRwynCjL8cY978eafM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ObbBhb9frSVJR3JsdpzXvoBT05CF4YVDHo6f1rebg8evGjSZvmoOl4cNpo0n5JvHIZTQCpNHZcDC5WUN1YqwLWrR3YlH3xSE2E38hE0/hXgSREyF4G1loghUedyit96pvVak1Eif/qHbE1Jve4MPZm70Y9LufUG8/4ioIZl3ByLgXqdbcYW6mfcdB3jE3JnAP4DibF2MA45Pn/NDTMkOmKwDLr7Vbcgj2G98bOqeF1H2XNzrRbPIfzfGGG4K4s2pErhq7o7uLYyOUz2KPyMsYe2bcKnzCKPOKRUWa1SIMz5BqTFwKCXf+0qw9XJxTzuIBdR7vK568QholywLnA4tMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eHdMfEzp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eHdMfEzp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ9KB0hjqz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:49:01 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FIFgvQ442363;
	Mon, 16 Mar 2026 09:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UoMtsZ
	uwOsAX2SqQE1TRmRqWsmRwynCjL8cY978eafM=; b=eHdMfEzpqlBt9fBlqslaAU
	L8vZNLKHDCmnMyY1jn2KmVFs0rnUEgPhN6gpD13vF+jW8uegNu+IUMeNmzUktzpS
	0JG0ig7gc6PyUkfsW3ThcyxYxPhdGzYPub7eH2JEUjQCCI53XuUiwN0VKxNhAoHL
	f7nK6B79eSSqIJXiXKXmoAwHh6tynrTZ34WJ4Q84M4weTluf7AFz8dmUEXncWjJf
	w8LV+IayPxmw7H2+oeegSqZuidWVqCGXTnFjpXUahcS2NXtHZml+0iasfWfm3kXH
	KywXC5MjBzG7JlH6DaBnVjQv4dGpqDgYzmhhpgJxl9knJ4dKMfbExmcm8Nm2rVXA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybry6hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:48:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G5UEqR015676;
	Mon, 16 Mar 2026 09:48:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n49hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:48:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G9mtc133555046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 09:48:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58A0358057;
	Mon, 16 Mar 2026 09:48:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268FD58058;
	Mon, 16 Mar 2026 09:48:52 +0000 (GMT)
Received: from [9.61.247.98] (unknown [9.61.247.98])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 09:48:51 +0000 (GMT)
Message-ID: <de14e6d6-fad4-4e9a-8004-66a28db31faa@linux.ibm.com>
Date: Mon, 16 Mar 2026 15:18:50 +0530
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
Subject: =?UTF-8?Q?Re=3A_=5Bnext-20260313=5D_kernel_build_fails_with_?=
 =?UTF-8?B?4oCcYXI6IHVucmVjb2duaXplZCBvcHRpb24gJy0tdGhpbifigJ0=?=
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        broonie@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>, xur@google.com,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Kees Cook <kees@kernel.org>
References: <476507c9-a371-4864-9e87-572c1ecae82d@linux.ibm.com>
In-Reply-To: <476507c9-a371-4864-9e87-572c1ecae82d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b7d209 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=5KLPUuaC_9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=6gyJ9jAq2XY_wWfpFN0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 5rBuZtvQWa3EMAAGKQCt6RwVAWrjaU8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NCBTYWx0ZWRfX1lDmpwy3O6Ur
 rthc3XWUvm/h8q6pcQqWNIKf61/bjr+JwfhvWidW+XzZBdxFkWjvX+cFlvFarRAHuR90jJjTpSa
 IjfIfnK45GA+zNyy0NoMbZH+2urhojaxA+uuysfn9sKuhkx2ScXPXaWKbGz9P/Ro8IIgwCLoy5v
 RhzXBZshlXvcbpYgapXgTZ+ky4794C1DNPGNMHbD5LPymcCd+t7xILkZ8v2RxtQ5gzYTo3/Md8Z
 5EWgaXPu/rFGfemgTXyaXYWrCQFWxrAxorDKXp/cIhyUdRekA0PB0UW84I1LJ9Zveb+DOOoYuSV
 SGX8N9PUPuxh8xXBbPYWBDtHZPxtGRHTx0Xd+xUnzKydJJTNYoc55TqOdOMAq7JnCMnDA7SJhBR
 x+tNuha5PnQEZ3u63qaBUgLNbL54PSD9Tny+/Ad7D3xK0+UwLIHAeFcExzliq9Y840hbNOTx8GZ
 J7bjCxvB3iaihVTV9Mg==
X-Proofpoint-GUID: rrAFbrdkiKYnAvjgQCd3bItWN4fqUfn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160074


On 16/03/26 11:41 am, Venkat Rao Bagalkote wrote:
> Greetings!!
>
>
> I am seeing a repeatable build failure in current mainline when 
> generating vmlinux.a.
>
> The build stops with an error from ar regarding the --thin option.
>
> This issue is seen on IBM Power11 System.
>
> Attached is the .config file.
>
> Also, I see couple of build warnings, before the build fails.
> Note: These warnings and build failure are not see on 20260312 build.
>
>
> Warnings:
>
> In file included from ./include/linux/seqlock.h:20,
>                  from ./include/linux/mmzone.h:17,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/umh.h:4,
>                  from ./include/linux/kmod.h:9,
>                  from ./include/linux/module.h:18,
>                  from drivers/char/nvram.c:34:
> drivers/char/nvram.c:56:21: warning: ‘nvram_mutex’ defined but not 
> used [-Wunused-variable]
>    56 | static DEFINE_MUTEX(nvram_mutex);
>       |                     ^~~~~~~~~~~
> ./include/linux/mutex.h:87:22: note: in definition of macro 
> ‘DEFINE_MUTEX’
>    87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
>
>
> Below are the failure logs.
>
>
> ar: unrecognized option '--thin'
> Usage: ar [emulation options] [-]{dmpqrstx}[abcDfilMNoOPsSTuvV] 
> [--plugin <name>] [member-name] [count] archive-file file...
>        ar -M [<mri-script]
>  commands:
>   d            - delete file(s) from the archive
>   m[ab]        - move file(s) in the archive
>   p            - print file(s) found in the archive
>   q[f]         - quick append file(s) to the archive
>   r[ab][f][u]  - replace existing or insert new file(s) into the archive
>   s            - act as ranlib
>   t[O][v]      - display contents of the archive
>   x[o]         - extract file(s) from the archive
>  command specific modifiers:
>   [a]          - put file(s) after [member-name]
>   [b]          - put file(s) before [member-name] (same as [i])
>   [D]          - use zero for timestamps and uids/gids
>   [U]          - use actual timestamps and uids/gids (default)
>   [N]          - use instance [count] of name
>   [f]          - truncate inserted file names
>   [P]          - use full path names when matching
>   [o]          - preserve original dates
>   [O]          - display offsets of files in the archive
>   [u]          - only replace files that are newer than current 
> archive contents
>  generic modifiers:
>   [c]          - do not warn if the library had to be created
>   [s]          - create an archive index (cf. ranlib)
>   [S]          - do not build a symbol table
>   [T]          - make a thin archive
>   [v]          - be verbose
>   [V]          - display the version number
>   @<file>      - read options from <file>
>   --target=BFDNAME - specify the target object format as BFDNAME
>   --output=DIRNAME - specify the output directory for extraction 
> operations
>  optional:
>   --plugin <p> - load the specified plugin
>  emulation options:
>   No emulation specific options
> ar: supported targets: elf64-powerpcle elf64-powerpc elf32-powerpcle 
> elf32-powerpc aixcoff-rs6000 aixcoff64-rs6000 aix5coff64-rs6000 
> elf64-little elf64-big elf32-little elf32-big ppcboot elf32-spu 
> pe-x86-64 pei-x86-64 pe-bigobj-x86-64 elf64-x86-64 elf64-l1om 
> elf64-k1om pe-i386 pei-i386 elf32-i386 elf32-iamcu elf64-bpfle 
> elf64-bpfbe srec symbolsrec verilog tekhex binary ihex plugin
> make[2]: *** [scripts/Makefile.vmlinux_a:22: built-in-fixup.a] Error 1
> make[1]: *** [/root/linux-next/Makefile:1278: vmlinux_a] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
>

Git bisect is pointing to below commit as first bad commit.


4519221849f26a3b0c0dc45b9914a0f9cdc00740 is the first bad commit
commit 4519221849f26a3b0c0dc45b9914a0f9cdc00740 (HEAD)
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue Oct 28 18:28:21 2025 +0000

     kbuild: move vmlinux.a build rule to scripts/Makefile.vmlinux_a

     Move the build rule for vmlinux.a to a separate file in preparation
     for supporting distributed builds with Clang ThinLTO.

     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
     Tested-by: Rong Xu <xur@google.com>
     Reviewed-by: Nathan Chancellor <nathan@kernel.org>
     Tested-by: Nathan Chancellor <nathan@kernel.org>
     Link: https://patch.msgid.link/20251028182822.3210436-2-xur@google.com
     Signed-off-by: Nicolas Schier <nsc@kernel.org>

  Makefile                   | 16 ++++++----------
  scripts/Makefile.vmlinux_a | 46 
++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 52 insertions(+), 10 deletions(-)
  create mode 100644 scripts/Makefile.vmlinux_a


Git bisect log:

git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [b84a0ebe421ca56995ff78b66307667b62b3a900] Add linux-next 
specific files for 20260313
git bisect bad b84a0ebe421ca56995ff78b66307667b62b3a900
# status: waiting for good commit(s), bad commit known
# good: [1f318b96cc84d7c2ab792fcc0bfd42a7ca890681] Linux 7.0-rc3
git bisect good 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
# bad: [ddc6cc7f66af99528c8a827d4ba835fb650b6446] Merge branch 'main' of 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad ddc6cc7f66af99528c8a827d4ba835fb650b6446
# bad: [06da2b04b5f2f11952969e813d8dd8f0c7617b79] Merge branch 
'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
git bisect bad 06da2b04b5f2f11952969e813d8dd8f0c7617b79
# good: [85689b69dad24170252dc5be8238de2388e68871] Merge branch 
'rust-analyzer-next' of https://github.com/Rust-for-Linux/linux.git
git bisect good 85689b69dad24170252dc5be8238de2388e68871
# bad: [5457bcbc73733c7268108a2acfc35c6505f3cbf3] Merge branch 
'for-next/core' of 
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 5457bcbc73733c7268108a2acfc35c6505f3cbf3
# good: [5473c1ee6462a5d3543c2b4c7dc6f1aac71eb082] userfaultfd: 
introduce mfill_copy_folio_locked() helper
git bisect good 5473c1ee6462a5d3543c2b4c7dc6f1aac71eb082
# good: [d1b4433308592363d133a788f0443d5d63872bdd] CREDITS: simplify the 
end-of-file alphabetical order comment
git bisect good d1b4433308592363d133a788f0443d5d63872bdd
# good: [ff28b3bb65c3eafeece9334b908e62c492f341e5] mm/damon/core: allow 
quota goals set zero effective size quota
git bisect good ff28b3bb65c3eafeece9334b908e62c492f341e5
# bad: [4f6ad15007039f296611ee76dad9f6ed071e63fb] Merge branch 
'kbuild-for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
git bisect bad 4f6ad15007039f296611ee76dad9f6ed071e63fb
# good: [07bc816c63b94e83dbe311d84b0278e54f6b83db] Merge branch 
'mm-unstable' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 07bc816c63b94e83dbe311d84b0278e54f6b83db
# good: [aad94ba683adc6ff7ff4e29ae48184b42782dd97] kbuild: uapi: provide 
stub includes for some libc headers
git bisect good aad94ba683adc6ff7ff4e29ae48184b42782dd97
# good: [0d3fccf68d9873a3c824fb70be0dbb2c4642aa90] kbuild: Use 
'-fms-anonymous-structs' if it is available
git bisect good 0d3fccf68d9873a3c824fb70be0dbb2c4642aa90
# bad: [8e786d89efce381609bd7fb9e8d6c52429e8b753] kbuild: distributed 
build support for Clang ThinLTO
git bisect bad 8e786d89efce381609bd7fb9e8d6c52429e8b753
# bad: [4519221849f26a3b0c0dc45b9914a0f9cdc00740] kbuild: move vmlinux.a 
build rule to scripts/Makefile.vmlinux_a
git bisect bad 4519221849f26a3b0c0dc45b9914a0f9cdc00740
# first bad commit: [4519221849f26a3b0c0dc45b9914a0f9cdc00740] kbuild: 
move vmlinux.a build rule to scripts/Makefile.vmlinux_a


Regards,

Venkat.

>
> If you happen to fix this issue, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.

