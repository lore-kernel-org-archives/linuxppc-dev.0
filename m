Return-Path: <linuxppc-dev+bounces-26057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573CBC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 07:21:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT2QZ2LF7z2y2c;
	Mon, 24 Aug 2026 17:21:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787556086;
	cv=none; b=nKEBrXC+w6vt0a47S5qjDQlNKUN6zbagVH8jZWg98qpKro7qBzZXsMGrwIitBIjNzpJ4/segSZ61AnrJugQHJvLanlYETygpDTrfdVi75WjJkMPqZrIFntT/1pHQT0DHcnt+c6ajViXB0SRVeGymuRF5Qlfk6ruT3WtbT8g4/EKVdPtZbhBus4S7Pq3A6Pm1xy0A+M9kdlNYayQ3fhrsfNZDs4FHU2GxNuoKWjZl/vXC7724XZRA5wDGKSJC/+lXlyf/6w5n6U7E9TzXsDTxQ+E4yrfY6RGLTGCqzZVs8YLrjEUVlgsEBEc6cb5YJJcAT6Cby1hFLILYIsn+PZuDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787556086; c=relaxed/relaxed;
	bh=tYjcNmkV1eAjExvAlj6bBHoYI9U6YNAsrB5sEgMa6Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQXW5MQMyrGeSnGSPf+KW21GPTgM3G1/bjo4+K/vjmle0Vue6zG6sn9tgLf1wpYBFEBDqagBNkxSmD/eaGy7apgpa/7pPCzhxi8ld6tU5/MWsmEx3Rm7XjvueHDWbi9CQrZerFN4U89L/pSgDvpRLecEDI2iUCtt7UU6t2lymw7iO2+RENJpEm57pKpOxaJYcbg/KbTE+HLk3Ui/Rtwu+82Y1uyidt5ejQefOrISejIR/Wi2joLv+L/gOXh3mHNtXhzUmvKnTknVvUFVXBpGF3VP/a/266Q2QH5/n9rDp/QPuQcHry0NjUkCIyzcR2jTKuVdc/sazVqt3ks1MbSJHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ry0M2cKf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ry0M2cKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT2QY0Lq2z2y06
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 17:21:24 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VjgV966020;
	Mon, 24 Aug 2026 07:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tYjcNm
	kV1eAjExvAlj6bBHoYI9U6YNAsrB5sEgMa6Ks=; b=ry0M2cKfRuif0J+ZGpb/4P
	iF4qJjD/A12jGyJ41/2RkierWMlBtOxj4Zo7B+k7HwJLBty5/OLJa1Vem4W7fvFt
	rcEkehfZHhHGtSzD+smTIT5TVffqh5Sf+/1Gj+B6KkIUlw/QqFSjOZjhIlUL+c6F
	woFlywFiuAjoYOMcbtJMHlA/8sww52AlI0zL2x6zthwkcULURzNgyzvXa7ZJQh5u
	YN4lNgyM2k+8AckL8376lfSyITrjmXXYr02Ceot6AZbsCNWenUu/6B+LUvUB8S7P
	RYOpd1PJ1Ca0a29zjcjNH4EkzhDQqw7Br2v2VO/8RdxDQBzgdtQutnGtVNSDlxFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4frnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 07:21:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O7BH18024681;
	Mon, 24 Aug 2026 07:21:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jmk03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 07:21:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O7LAkF27394556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 07:21:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39B9920040;
	Mon, 24 Aug 2026 07:21:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B81620043;
	Mon, 24 Aug 2026 07:21:08 +0000 (GMT)
Received: from dhcp-9-123-15-208.bl1-in.ibm.com (unknown [9.123.15.208])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 07:21:08 +0000 (GMT)
Date: Mon, 24 Aug 2026 12:51:05 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Don't drop pending doorbell
 across L2 entry
Message-ID: <aovw4XkBoPrqYetd@dhcp-9-123-15-208.bl1-in.ibm.com>
References: <20260812034628.1122115-1-vaibhav@linux.ibm.com>
 <8dd35d81-93b8-412d-81f3-82380f57f68d@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dd35d81-93b8-412d-81f3-82380f57f68d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fUEDhPbj0D6W4AiN-xGJ0hw57QlslNK1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfX+dwUkfE+0nFX
 yRwiU/Puuykj/jvo+VfrIHzjMyJnIg/WgaV4VwXuH5GpuRBBBwZ86WPxTfSATFBDBXVEQiG/I6g
 8a6yS7jGwd7SnwQ1Tj2oIOfG7ZrHzN0=
X-Proofpoint-GUID: fUEDhPbj0D6W4AiN-xGJ0hw57QlslNK1
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8bf0eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=gUc-mDYKWQMlX0kK0wMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfX+tM+d2HgEMe1
 yxMHPe7tX5J9z27VDJKzTFD1EoAl0r8hOEKU5gkoZ3VBWpODIcWgIeWnrE0TmEEBQN+uyqN7g8i
 Ihq03KeWUg4ThQsLyCj8ArGPeM2R46cUG7LjhK8iwoI6TRvaQjX22iNfQ/+tKaxIox8R17n3wTF
 Gn3ddm81sMIcxSSOmgue+M/1JuBtNkAKSvFYU5QYZ1MeHi1KbgokIq12BfX4/UWmorrKp7WKYYf
 0E7Bqf4b5x/SS1v/Jb9MmiuKDRx9rFctjexCL8gm1DsagZSTBUDsoH4YgXZhwqRdjV1nd5SNy61
 QOaC87t2JxpYe4TivXDuh+XhH7AccLCGWWSNhJkRVh3zXX9jZxc+1GQeeLYXV5irUwVrLC0HxHI
 0wLWLfpjbpgYuQo0d5IRDRNLAPJPKTZ5+RvJ3v9sQm2d24fXTBlUuGDWQEjU4Vkl0Y26sxkRedX
 NVVG4Z0m/XUeEd/XriA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240060

> Hi Vaibhav,
> 
> I have tested this v2 patch and it is still giving me the issue I reported,
> so here is my analysis:
> 
> a) Without applying the patch :
> 
> 1) Start the guest and run stress-ng as below for sometime
> localhost:~ # stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G
> --sched other --timeout 3600000s
> stress-ng: info:  [1464] setting to a 41 days, 16 hours, 0 secs run per
> stressor
> stress-ng: info:  [1464] dispatching hogs: 4 cpu, 2 vm, 2 hdd
> 
> 
> 
> 2) Start the migration from H1 to H2:
> 
> ltc-lp7:~ # virsh migrate --live --domain sles16_anu
> qemu+ssh://10.xx.xx.xx/system --verbose --undefinesource --persistent
> --auto-converge --postcopy
> (root@10.xx.xx.xx) Password:
> Migration: [100.00 %]
> 
> 3) Migration got completed but guest is not getting recovered from
> continuous softlockups
> 
> [ 1336.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 977s!
> [htxd_monitor:1337]
> [ 1336.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 1002s!
> [rcu_exp_par_gp_:19]
> [ 1346.015839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0
> nice=0 stuck for 1090s!
> [ 1346.016355][    C0] BUG: workqueue lockup - pool cpus=3 node=0 flags=0x0
> nice=0 stuck for 1107s!
> [ 1346.016874][    C0] BUG: workqueue lockup - pool cpus=7 node=0 flags=0x0
> nice=0 stuck for 1093s!
> [ 1356.007835][    C6] watchdog: BUG: soft lockup - CPU#6 stuck for 912s!
> [systemd:1353]
> [ 1356.008835][    C7] watchdog: BUG: soft lockup - CPU#7 stuck for 998s!
> [systemd-journal:570]
> [ 1360.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 999s!
> [htxd_monitor:1337]
> [ 1360.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 1024s!
> [rcu_exp_par_gp_:19]
> [ 1368.933835][    C4] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 1368.933973][    C4] rcu:     4-....: (1129830 ticks this GP)
> idle=afc4/1/0x4000000000000002 softirq=3694/428556 fqs=259639
> [ 1368.934106][    C4] rcu:              hardirqs   softirqs  csw/system
> [ 1368.934188][    C4] rcu:      number:        1     444039 0
> [ 1368.934271][    C4] rcu:     cputime:        3          8 1096165   ==>
> 1110021(ms)
> [ 1368.934373][    C4] rcu:     (t=1140022 jiffies g=6177 q=1684 ncpus=8)
> [ 1376.224839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0
> nice=0 stuck for 1120s!
> [ 1376.225307][    C0] BUG: workqueue lockup - pool cpus=3 node=0 flags=0x0
> nice=0 stuck for 1138s!
> [ 1376.225428][    C0] BUG: workqueue lockup - pool cpus=5 node=0 flags=0x0
> nice=0 stuck for 715s!
> [ 1376.225548][    C0] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x0
> nice=0 stuck for 1027s!
> [ 1376.225667][    C0] BUG: workqueue lockup - pool cpus=7 node=0 flags=0x0
> nice=0 stuck for 1123s!
> [ 1444.006835][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 1100s!
> [rcu_exp_par_gp_:19]
> 
> 
> b) Even after applying the patch also it is giving same softlockup issue as
> mentioned above:
> Though I have enough vcpus and memory on the guest (16 vcpus , 13Gi of
> memory)  and ample amount of memory and cpus
> present on host still these softlockups are happening after applying the
> patch too. I tried reducing stress also on the guest
> but still this issue is seen.
> 
> stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G --sched other
> --timeout 3600000s
> 
> If you are planning to send next version of this patch,
> Please do add my reported-by:
> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> 

Thanks for testing this Anushree. Upon further debugging, I found that
this issue is likely due to a bug in QEMU, for which I've sent a fix[1].

@maddy: Please don't pull in this patch for now, will ping here if this
is needed.

[1] : lore.kernel.org/qemu-devel/20260824070353.40016-1-gautam@linux.ibm.com/

Thanks,
Gautam

