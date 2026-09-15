Return-Path: <linuxppc-dev+bounces-27270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AE8C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 02:15:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkQbq574Xz2yFW;
	Tue, 15 Sep 2026 12:15:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789438551;
	cv=none; b=gnc72J39KY0IiijgnmNtdttGMDyXE1iYo6uW9NNJF3yuXOZmF7Der9+vyBi/C4ctTY/hFqV2Jw+iw/7VG/evv/L7AHuNvty8WCCQVkPLWQg8tQ5Tg397RslzlCseXDjQoIBMehs6cb1DWGVoNTDzuzXq3EzMxOswoVTdBZRPzWxfxxCW+qEepkK9G015aD35V7g4O4ja2FIfvwk9CHeRQ2Iqtg3G1Nso/JikmwBGlHGhTdVDpLAaPV/bLyAl3OZ4IE0gGlnmmYKEG+ecccXBm6EwdnkE5RuVZ9ce6KqLiJ9peRlAdpiir1VrXPvVW0Yo4vHccv1NITK0IbRQmdTapg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789438551; c=relaxed/relaxed;
	bh=cfcDxhma79EtDq1LwjK3+ZHTEMMiZxPjibbdfBrqejk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoj2OqZvbGn2z79RANxPy+P+SnQOKWyNjEcklaoWkyqDgIq76/BEg0SbtF5nFnRG09qilqIJEFAMcGKBIzHVVZZVfqj8g+UW7VQbyvgcP+MN3Dj3Xxv9zPDmahjsLmIr1Cb08tVFU/vH3GIdQPpqkwxmFMvLlFq6afVnkmhWPi9CzXAXslwkVzuG4GZaDbtKbzG8j9Ftbh/HIkWc7KAZJBakCKCeMnLNSvruWBQjV8D8ccTHXXvFQhMLzk4MKpbqDpz4HqYLUJ+l0jOk3pu2/8DS8P3L0HyQOaRSu//XlCKDFcl30szrG5YZXRjsxWyOHCdLhSYpBNPYq+B+naGSgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MF1Mwmxw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MF1Mwmxw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkQbp5gr1z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 12:15:50 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EN1cF13377659;
	Tue, 15 Sep 2026 02:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=cfcDxhma79EtDq1LwjK3+
	ZHTEMMiZxPjibbdfBrqejk=; b=MF1MwmxwLEkSVcFzjcZpTIgLcgABo+AwX1i5N
	H6ngvphUySaC2d9W+W939OOZW42X0ff8xZNWnYXLaxAzJfIsejHA/b2Bab/rXT/B
	2KTGTxnvC0wwgbdpHyugOmulskgAAbccgrOirOuPFlczVmhnyxZoO4ke1q/UATFr
	TQOjmVmXDNhdnpv+/t9NUGe3/xAK+bvG8TWyi6/+KpFcxq60DqIkmGDhsGD+SSCU
	Pu+yzLWw0XdiYaXI0Ppa+JDzt3V0kHd7GB0JfE7iaN+C2gT9XVe+hzR3h4fzQR1A
	bxHP13rgjq8N0wFpwXvKte0H+EeD+5M0/XbgDPA8CupTpIyOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4vuav-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 02:15:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EN55Sr3051315;
	Tue, 15 Sep 2026 02:15:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhew167f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 02:15:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68F2Fef749807836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 02:15:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDCC62004D;
	Tue, 15 Sep 2026 02:15:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55B782004B;
	Tue, 15 Sep 2026 02:15:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 15 Sep 2026 02:15:39 +0000 (GMT)
Date: Tue, 15 Sep 2026 07:45:37 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/faddr2line: Combine three readelf calls
 into one"
Message-ID: <aqiqScJg8Ey5QnKl@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260905012449.3872882-2-srikar@linux.ibm.com>
 <aqhDm60zSZIazrnC@jpoimboe>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aqhDm60zSZIazrnC@jpoimboe>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vuUZHcTlQZhNBJ3LpADX3UBhaEL2Dz47
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAyNiBTYWx0ZWRfX1F/kC7hX1XIT
 ACPOYSLbAzEzZAILAresZiQ2X/m/GCaDS0VfQH6T/JHRDmSpvvOKlSUvWmekD3X04zLC6nAAQ3Q
 UXeOe2EUBnXOvGfwiLyiBUka9ECaGpo=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa8aa52 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=31Ant1ppW7QaW2tZWSQA:9 a=wPNLvfGTeEIA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: ux1E2G36BHvCq5ShLZ5gKmX9tQ36mW7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAyNiBTYWx0ZWRfX3z9n8RiFTCBg
 hsDuX0bCmTXYKlQcezqQgsPRtr1Z6e4p+m3nN/7pdlXdYggG6cDuCcVjzsq0mwWfvO/JX64mSys
 s1jOy9JjY6VFpvQSfAyoQ9KHZI7NK3oK8qyE5G+nre2NMW/0eRT1BFz8joolS6OyA9JgdBzqRGu
 e2/xP9AG1VUgojZu496cY38eVCQBFTv0sKWwNPX1LxNGUuhFANAE/T6I4VMZLDxOmwiNG01Z7kY
 VzB9Fc4iu0/FqtRTA2KQw5Od3lIULr1ugNTGGEg/DQNcb4JsCqWJ6bYajSM3FSH2BNeO92ngueQ
 E7ixeqQ1VTdnuOvCBzaVabk7krLH+lzEjwCp8kcJqnWrA4dXZkRzAIs7kKCPvYKQxz6IjGpC/m0
 z4Lyf1J30ur3VRu6S1Z5WzsKSKo5DiqJjgMik1jiS55I1UzypfE0pX9Yn4uZYgWkuxuqQsLDjOs
 uNi3BrfP5TTibmXh+8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150026

* Josh Poimboeuf <jpoimboe@kernel.org> [2026-09-14 12:00:26]:

> > It could be a bug in Powerpc readelf that this line doesnt get printed.
> > However since its breaking with existing readelf, its better to be
> > reverted.
> > 
> > With the revert, we end up calling readelf three times but this should
> > still be fine since calling faddr2line is a debug tool.
> > 
> > Fixes: b8d9d9496c1e ("scripts/faddr2line: Combine three readelf calls into one")
> > Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> 
> Can you run
> 
>   bash -x scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c
> 

+ set -o errexit
+ set -o nounset
+ UTIL_SUFFIX=
+ [[ '' == '' ]]
+ UTIL_PREFIX=
+ READELF=readelf
+ ADDR2LINE=addr2line
+ AWK=awk
+ GREP=grep
+ export LC_ALL=C
+ LC_ALL=C
+ command -v awk
+ command -v readelf
+ command -v addr2line
+ [[ 2 -lt 2 ]]
+ objfile=./vmlinux
+ LIST=0
+ [[ ./vmlinux == \-\-\l\i\s\t ]]
+ [[ ! -f ./vmlinux ]]
+ shift
+ run_readelf ./vmlinux
+ local objfile=./vmlinux
+ local tmpfile
++ mktemp
+ tmpfile=/tmp/tmp.BGkKH2pxoy
+ readelf --file-header --section-headers --symbols --wide ./vmlinux
++ sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' /tmp/tmp.BGkKH2pxoy
+ ELF_FILEHEADER='ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF64
  Data:                              2'\''s complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           PowerPC64
  Version:                           0x1
  Entry point address:               0xc000000000000000
  Start of program headers:          64 (bytes into file)
  Start of section headers:          425572840 (bytes into file)
  Flags:                             0x2, abiv2
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         2
  Size of section headers:           64 (bytes)
  Number of section headers:         61
  Section header string table index: 60'
++ sed -n '/Symbol table .* contains [0-9]* entries:/q;p'
++ sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' /tmp/tmp.BGkKH2pxoy
+ ELF_SECHEADERS='Section Headers:
  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
  [ 1] .head.text        PROGBITS        c000000000000000 010000 008000 00  AX  0   0 128
  [ 2] .text             PROGBITS        c000000000008000 018000 1474ed4 00  AX  0   0 256
  [ 3] .rodata           PROGBITS        c000000001480000 1490000 6217ce 00  WA  0   0 65536
  [ 4] .pci_fixup        PROGBITS        c000000001aa17d0 1ab17d0 004590 00  WA  0   0  8
  [ 5] .printk_index     PROGBITS        c000000001aa5d60 1ab5d60 00f770 00  WA  0   0  8
  [ 6] __ksymtab         PROGBITS        c000000001ab54d0 1ac54d0 045120 00   A  0   0  8
  [ 7] __kcrctab         PROGBITS        c000000001afa5f0 1b0a5f0 00b830 00   A  0   0  4
  [ 8] __kflagstab       PROGBITS        c000000001b05e20 1b15e20 002e0c 00   A  0   0  1
  [ 9] __ksymtab_strings PROGBITS        c000000001b08c2c 1b18c2c 039a9c 01 AMS  0   0  1
  [10] __param           PROGBITS        c000000001b426c8 1b526c8 002e18 00  WA  0   0  8
  [11] __modver          PROGBITS        c000000001b454e0 1b554e0 0005a0 00  WA  0   0  8
  [12] __ex_table        PROGBITS        c000000001b45a80 1b55a80 002ab8 00   A  0   0  4
  [13] .notes            NOTE            c000000001b48538 1b58538 000088 00   A  0   0  4
  [14] .BTF              PROGBITS        c000000001b50000 1b60000 4d833d 00   A  0   0  1
  [15] .BTF_ids          PROGBITS        c000000002030000 2040000 00138c 00   A  0   0  1
  [16] .branch_lt        PROGBITS        c000000002040000 2050000 003030 00  WA  0   0  8
  [17] .got              PROGBITS        c000000002043100 2053100 000380 08  WA  0   0 256
  [18] __soft_mask_table PROGBITS        c000000002043480 2053480 000080 00   A  0   0  8
  [19] __restart_table   PROGBITS        c000000002043500 2053500 0000c0 00   A  0   0  8
  [20] __stf_entry_barrier_fixup PROGBITS        c0000000020435c0 20535c0 0001e8 00   A  0   0  4
  [21] __uaccess_flush_fixup PROGBITS        c0000000020437a8 20537a8 000008 00   A  0   0  4
  [22] __entry_flush_fixup PROGBITS        c0000000020437b0 20537b0 0001d8 00   A  0   0  4
  [23] __scv_entry_flush_fixup PROGBITS        c000000002043988 2053988 000010 00   A  0   0  4
  [24] __stf_exit_barrier_fixup PROGBITS        c000000002043998 2053998 000060 00   A  0   0  4
  [25] __rfi_flush_fixup PROGBITS        c0000000020439f8 20539f8 000060 00   A  0   0  4
  [26] __spec_barrier_fixup PROGBITS        c000000002043a58 2053a58 000690 00   A  0   0  4
  [27] .init.text        PROGBITS        c000000003000000 3010000 0b0000 00 WAX  0   0 32
  [28] .exit.text        PROGBITS        c0000000030b0000 30c0000 004158 00  AX  0   0 32
  [29] .init.data        PROGBITS        c0000000030c0000 30d0000 1c4580 00  WA  0   0 65536
  [30] __ftr_fixup       PROGBITS        c000000003284580 3294580 00eaf0 00   A  0   0  8
  [31] __mmu_ftr_fixup   PROGBITS        c000000003293070 32a3070 001830 00   A  0   0  8
  [32] __lwsync_fixup    PROGBITS        c0000000032948a0 32a48a0 000dc8 00   A  0   0  4
  [33] .data..percpu     PROGBITS        c0000000032a0000 32b0000 1e0e58 00  WA  0   0 4096
  [34] .machine.desc     PROGBITS        c000000003480e58 3490e58 000410 00  WA  0   0  8
  [35] .dynsym           DYNSYM          c000000003481268 3491268 000048 18   A 36   3  8
  [36] .dynstr           STRTAB          c0000000034812b0 34912b0 000001 00   A  0   0  1
  [37] .dynamic          DYNAMIC         c0000000034812b8 34912b8 000120 10  WA 36   0  8
  [38] .gnu.hash         GNU_HASH        c0000000034813d8 34913d8 00001c 00   A 35   0  8
  [39] .rela.dyn         RELA            c0000000034813f8 34913f8 519030 18   A 35   0  8
  [40] .data             PROGBITS        c0000000039a0000 39b0000 610100 00  WA  0   0 128
  [41] .data..init_task  NOBITS          c000000003fb4000 3fc0100 004000 00  WA  0   0  1
  [42] .data..page_aligned PROGBITS        c000000003fc0000 3fd0000 010000 00  WA  0   0 65536
  [43] .data..cacheline_aligned PROGBITS        c000000003fd0000 3fe0000 023500 00  WA  0   0 128
  [44] .data..read_mostly PROGBITS        c000000003ff3500 4003500 03cb80 00  WA  0   0 128
  [45] .data_nosave      PROGBITS        c000000004040000 407bcec 000000 00   W  0   0  1
  [46] __bug_table       PROGBITS        c000000004040000 4050000 02bcec 00  WA  0   0  1
  [47] .bss              NOBITS          c000000004070000 407bcec 725338 00  WA  0   0 65536
  [48] .debug_aranges    PROGBITS        0000000000000000 407bcf0 0279d0 00      0   0 16
  [49] .debug_info       PROGBITS        0000000000000000 40a36c0 fa4d575 00      0   0  1
  [50] .debug_abbrev     PROGBITS        0000000000000000 13af0c35 673114 00      0   0  1
  [51] .debug_line       PROGBITS        0000000000000000 14163d49 211a8e7 00      0   0  1
  [52] .debug_frame      PROGBITS        0000000000000000 1627e630 3ba1f8 00      0   0  8
  [53] .debug_str        PROGBITS        0000000000000000 16638828 426e36 01  MS  0   0  1
  [54] .debug_line_str   PROGBITS        0000000000000000 16a5f65e 0004f5 01  MS  0   0  1
  [55] .debug_loclists   PROGBITS        0000000000000000 16a5fb53 1efdaf5 00      0   0  1
  [56] .debug_rnglists   PROGBITS        0000000000000000 1895d648 4d9186 00      0   0  1
  [57] .comment          PROGBITS        0000000000000000 18e367ce 00002e 01  MS  0   0  1
  [58] .symtab           SYMTAB          0000000000000000 18e36800 42b670 18     59 150524  8
  [59] .strtab           STRTAB          0000000000000000 19261e70 379870 00      0   0  1
  [60] .shstrtab         STRTAB          0000000000000000 195db6e0 000302 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), p (processor specific)'

> to see what line it's failing at?
>

As you can see, the last executed line line is

ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
which it self is called from run_readelf

since sed -o errexit is set in the script, sed returns an non-zero error
and that causes the script to exit if the line is not found.

The other options are

1.  to reset sed -o errexit  in run_readelf
diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcf..f1b83913d08c 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -116,12 +116,14 @@ run_readelf() {
 
 	${READELF} --file-header --section-headers --symbols --wide "$objfile" > "$tmpfile"
 
+	set +o errexit
 	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
 	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
 	# line when multiple options are given, so let's also match with the "Section Headers:" line.
 	ELF_FILEHEADER=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' "$tmpfile")
 	ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
 	ELF_SYMS=$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfile")
+	set -o errexit
 
 	rm -f -- "$tmpfile"
 }


2. or use || true with sed, so that it doesn't fail.

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcf..6e867b053ac4 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -119,9 +119,9 @@ run_readelf() {
 	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
 	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
 	# line when multiple options are given, so let's also match with the "Section Headers:" line.
-	ELF_FILEHEADER=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' "$tmpfile")
-	ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
-	ELF_SYMS=$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfile")
+	ELF_FILEHEADER=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' "$tmpfile" || true)
+	ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p' || true)
+	ELF_SYMS=$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfile" || true)
 
 	rm -f -- "$tmpfile"
 }

Note: only the SECHEADERS line needs true but adding true to just that line looks hacky.

3. remove set -o errexit for the entire file.

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcf..174ab098750f 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -41,7 +41,6 @@
 #   free_reserved_area at mm/page_alloc.c:6429 (discriminator 2)
 
 
-set -o errexit
 set -o nounset
 
 usage() {

4. patch I sent before, use readelf multiple times.

I have tried and verified these options work correctly too.
However I feel option 4, where we run readelf 3 times is the cleanest.

> Any chance the below fixes it?
> 
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 622875396bcfc..550c0f9b9d473 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -78,7 +78,7 @@ GREP="grep"
>  
>  # Enforce ASCII-only output from tools like readelf
>  # ensuring sed processes strings correctly.
> -export LANG=C
> +export LC_ALL=C
>  

As you can see above from the log, I have tried this but this doesn't help

>  command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
>  command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"

-- 
Thanks and Regards
Srikar Dronamraju

