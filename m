Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B14606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jANViDSq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ9gq5GHVz2yKn;
	Thu, 12 Nov 2026 17:38:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794465495;
	cv=none; b=FBAdsXmbubSO7nTDouYRW1SUKWnIRU9MUXxKLrqkVkIp83hhRTTcLGS8fDny4fw0u+iSdt7FpcEqBVdSSHHGZTVNHhxcvDGTN7hqBHMuAKJywjojdDUHstMipqOQerKF7vosaKwYtq45oOnRUZ29HD4Npd5AsGFlgOPYnOCHx5cNfUpjpELKRSt99Lug3nCx9KXQquQrWRCucvt4Xe5kmFl+1o3NxDkkaSrRjIpSXU0jpkmbeYqz6MmETlA55Qwwez+0ZXHseX/sv4p0nQfqAtujK3C8j/kldri3r7MNvcsirxgtLCaoAoxrEdv1NB4X/TAE2skRNsKF7Rg+xhLO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794465495; c=relaxed/relaxed;
	bh=iRFfIlk2imt6t6yv6bIN0MN/kiJgCcKCYYhBMj7zHZE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JpLBeYbXpgG8u4dbilWUdzGCy9ii6dRbYwoZur2aVnTFmRdKJHQNtXArZI9bsoCiD0yu180eBuowQE8Gg9BcPHamghgW+IRKY5PEhT+kztOa9WSbyv6JqOBtzO2+KONwXt15rnL7fo5VRT0Zc7WsjlIatNFWI6QMWyY1YEXMdoqUnqrsMrQvIRGr994ZLfsNuM7K2AOHwQUg8bh5zMvI+pdgE1fUYQu9J7qWmRYKX+ADVzZTiX4K5S2qKpsS4qfoci9W2WjlONlyir+LqQTv3BZHUCRMA2Zipo4XzSjd6TEGRCNSjt2vh5jVBirP2y1bT6V4DgalIcljbWpJG865pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jANViDSq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jANViDSq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ9gp2tGmz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 17:38:13 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2jUbS2861878;
	Thu, 12 Nov 2026 06:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=iRFfIlk2imt6t6yv6bIN0MN/kiJg
	CcKCYYhBMj7zHZE=; b=jANViDSqvYCil6NXuTTz2+lvbtw4X5DJgETv5vJJEG1R
	yz74TUDcD22G/HNuu7tt4BErupxWtTnMmCOV3Rxk4rCL4AM0/bNwr+Wqkv8ga1lZ
	UYJI/fzgBgTokB9nfYcMG51g/vrX6bCR4BRRjhJsbyAwOgqZqVzyEGQwuXF29XOR
	HXP538IhXr0VIJyzXydnn7RQsaxvxhcaQ2el6/5rnBZtkSSXo/qK9hrJas0F4dzD
	CMGVBPeuoopAvXLi9dcbuNIvrPsesuNS81IoA1Re2Flm/JzXMKxhzAteKJnskSKl
	8DzxCG2AXyocbI060AGfKrOaplvnPmFE/0yWXtUajg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv4x23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:38:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2a1O8054026;
	Thu, 12 Nov 2026 06:38:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309qnav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:38:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC6c9RE32375318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 06:38:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51CC35808E;
	Thu, 12 Nov 2026 06:38:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02F858083;
	Thu, 12 Nov 2026 06:38:06 +0000 (GMT)
Received: from [9.61.240.49] (unknown [9.61.240.49])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 06:38:06 +0000 (GMT)
Message-ID: <0d9a9fd6-3824-4709-a7f7-eb1d5849e079@linux.ibm.com>
Date: Thu, 12 Nov 2026 12:08:05 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Ritesh Harjani
 <riteshh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [next-20261111] ext4: Oops in ext4_writepages() during fast commit,
 replay (generic/483, 64K pagesize, ppc64le)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNCBTYWx0ZWRfXzkSZbFjxUcGT
 l7AtGG2qgqdbdP8Y9/Xet/7YTiVMhCgVj7S8hWfxXsCELQlYmCx2b/ntkFCZmAXWv5puG7UPohn
 KAIUjK1hZ9wI/NHQL/i13ZAI8f0uocI=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af55ed2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-IFbq3Xo538CQDMHEQUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HUuwRGpVZWvqaF-BWHFBlM4Dujs-ih3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNCBTYWx0ZWRfX1tyninbRGAkw
 RjRCTtWO2WMkrA4/R1BhnSdfLgQSQkgVU01gw6+MunDpvC5QTnLkQlF9hIUa3RCSKw/MrSb4V9N
 GPzTO2nqZiyr6n3sAAw2i8MFb7cOrtvwr2f2QTfnDqL2+SmFkyK9Xd8BYzAJZzKAeky7GYqG0jY
 Gy2HY90IWENDAIdaxzK3Uh7zkD/xqMZAqdDIPbFU1R/QC5amOiV9DDAgmru9ZIT2/AL+oTLnrz4
 sIG+LZnxHZnPX1VzS9VORAqMm2JqIdPba/hmFB5QN8WTwjWaMg3ZoyFT+TIpALwImli4W/iGNqe
 xQgQGDSc3DFtXTrRymDO8qtzkpdu3krpAEr9bGuWKmw7HF2y8xGlpRrDpvS+NLM8+4ekGWmd28o
 EO4IEJc6MmtLex0mBYfyITBlA2vIOjAjrkwxX4XbZPPnU86SBOslmyc0oEWb5pb/FCmjiLmnW9P
 ffm4OFACuOg/p3zLWbQ==
X-Proofpoint-ORIG-GUID: HUuwRGpVZWvqaF-BWHFBlM4Dujs-ih3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120024
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

While running xfstests on linux-next next-20261111 on a Power9 pSeries
LPAR with 64K PAGE_SIZE, generic/483 on ext4 (64K block size, fast_commit
enabled) triggers a kernel oops.


Reproducer
----------
Kernel:   7.4.0-rc2-next-20261111 (ppc64le, PAGE_SIZE=64K, Hash MMU)
Hardware: IBM 8375-42A POWER9 (pSeries LPAR)

xfstests local.config:
   export FSTYP=ext4
   export TEST_DEV=/dev/loop0
   export TEST_DIR=/mnt/test
   export SCRATCH_DEV=/dev/loop1
   export SCRATCH_MNT=/mnt/scratch
   export MKFS_OPTIONS="-b 65536 -O fast_commit"

   ./check -ext4 generic/483



Oops
----
[14844.411091] EXT4-fs (dm-0): mounted filesystem 7ef13de7-... r/w with 
ordered data mode. Quota mode: none.
[14847.236154] EXT4-fs (dm-0): unmounting filesystem 7ef13de7-...
[14847.275380] Kernel attempted to read user page (1174770000) - exploit 
attempt? (uid: 0)
[14847.275406] BUG: Unable to handle kernel data access on read at 
0x1174770000
[14847.275414] Faulting instruction address: 0xc00800000ed42f74
[14847.275423] Oops: Kernel access of bad area, sig: 11 [#1]
[14847.275430] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
[14847.275575] CPU: 26 UID: 0 PID: 53042 Comm: mount Kdump: loaded Not 
tainted 7.4.0-rc2-next-20261111 #1 PREEMPT(lazy)
[14847.275587] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[14847.275597] NIP:  c00800000ed42f74 LR: c00800000ed42f70 CTR: 
c0000000009e2a60
[14847.275647] CFAR: c00000000000db4c DAR: 0000001174770000 DSISR: 
40000000 IRQMASK: 1
[14847.275771] NIP [c00800000ed42f74] ext4_writepages+0x12c/0x3a0 [ext4]
[14847.275908] LR [c00800000ed42f70] ext4_writepages+0x128/0x3a0 [ext4]
[14847.276038] Call Trace:
[14847.276058]  do_writepages+0x190/0x330
[14847.276073]  __writeback_single_inode+0x9c/0xa30
[14847.276087]  writeback_single_inode+0x18c/0x2a0
[14847.276101]  write_inode_now+0xc0/0x100
[14847.276114]  iput_final+0x10c/0x300
[14847.276128]  ext4_fc_replay_add_range+0x2f0/0x5a0 [ext4]
[14847.276262]  ext4_fc_replay+0x564/0xdd0 [ext4]
[14847.276394]  do_one_pass+0x9bc/0x1370 [jbd2]
[14847.276439]  jbd2_journal_recover+0x358/0x400 [jbd2]
[14847.276481]  jbd2_journal_load+0x28/0x110 [jbd2]
[14847.276530]  ext4_load_journal+0x7cc/0xc60 [ext4]
[14847.276664]  ext4_load_and_init_journal+0x6c/0x680 [ext4]
[14847.276801]  __ext4_fill_super+0x1454/0x2360 [ext4]
[14847.276937]  ext4_fill_super+0x188/0x4d0 [ext4]
[14847.277072]  get_tree_bdev_flags+0x250/0x350
[14847.277086]  ext4_get_tree+0x24/0x40 [ext4]
[14847.277221]  vfs_get_tree+0x78/0x210
[14847.277234]  vfs_cmd_create+0x8c/0x1a0
[14847.277246]  __do_sys_fsconfig+0x58c/0x880
[14847.277259]  system_call_exception+0x3c4/0x600
[14847.277273]  system_call_vectored_common+0x15c/0x2ec
[14847.277477] Code: 387f0740 480b8b11 e8410018 ebff0740 7dbe6b78 
386d0030 480b8afd e8410018 ebde0030 7c7ff214 480b8b65 e8410018 
<7d3ff02e> 7f83e378 39290001 7d3ff12e

If you happen to fix this, Please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,

Venkat.



