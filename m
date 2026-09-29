Return-Path: <linuxppc-dev+bounces-28529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664D2CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:58:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvTW90sBgz2yD3;
	Wed, 30 Sep 2026 05:58:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790711893;
	cv=none; b=U3JqlASeUrS2xU+Y8FQQNSPNecomMAGpa2B92HdNGXRP2aN0sIqdkAgm0SyXIodo47G51Pilo03TG4xELl6gPuD1nYrUFzTZ/wAVJtP5YuvVRv2klrWj4rnZ/oo7T0SA+oowW/mhsyU0T/YTw2VkAUbO752DirtHqGA/bQGU/xluOvw1WnxJG46qWET7e0LzV6i84elS9NqS3sKoDFBaHSV7Kyxz1L1D3Wv9fyC3KYtAB4u02Lj7LWzn5AXwTNlKSumTl+iSEYhKkknHOgHlLV4wW3hffptr71SLAxsdG3U8iphl1KWG9Og0/8aF/7C0/18bySHsiD8rtTW8W7Y/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790711893; c=relaxed/relaxed;
	bh=wptkKhbCiZtycKOd94k+T/nH1+I0zylfX8wphlhJCFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDhw91Edoe1FOiDP01Ezos/s5lCB17m6V+Gxv9PQV8JKAk95kNtFtnvn5bgC/TaaNlsnqhJde6KmTLgKFcPrB0G+Q+PBQ5PipfZPLwXDWYQ7HkvB+IVRXv/4bfskzTQ1Krz307mHpck5qjow+zNj4iAKu4v9ixyTY59ZdMQMp2/KwBhM+5QR4mXW2GcVaoQ45WESp1abhBwRcIpDvLuKpmbrCn03C55Y1Qlc72uNWQ/95Uu5LFwYZ4+LgxlYOVEeO+KOO6xBv4kUEqyC2V/2mTE0ZpaTC9qfKl3YU78BgwBDxn3an0UOAtFVebeAvh5Wi1I1uI35fgqpYRvYOU/8hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iWezuwI9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iWezuwI9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvTW81q7Sz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:58:11 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5npo4018055;
	Tue, 29 Sep 2026 19:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wptkKh
	bCiZtycKOd94k+T/nH1+I0zylfX8wphlhJCFs=; b=iWezuwI96mWZKd4O9rNpDu
	26Z/qnyno0GEY5Vde5eqhB8Hx5Mcz6De6CIf7klpn8nx5P5k68NZDeGnaH1Jodsz
	zLr3f4fuMGO3tDqSMuqVVNoXPQMDBqgxwkxBELQ2pXivvE8U9NO4FpLwpXIjHbow
	Y3VH9GtVpuCDM3wy23ArGq6+DqKGNAlaSVfta1D6HfT5t07yV0mrnuuGXVAH8Okz
	Ixdq51pDA1FXn2m/53CEEL1voLpEH115bbmbqaUrLr59jUjhLeQ5uaaedbfgrSFa
	u693IXBLhRKFZlie8tSP5EI+Xn0UswBlC6yEFGRK5t8KYDyNvsP+fIF5LBk8DAog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt87m8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 19:49:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68THm3KN2198010;
	Tue, 29 Sep 2026 19:49:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23gfm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 19:49:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TJnFoZ44564908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 19:49:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F78820043;
	Tue, 29 Sep 2026 19:49:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6AE020040;
	Tue, 29 Sep 2026 19:49:14 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Sep 2026 19:49:14 +0000 (GMT)
Date: Wed, 30 Sep 2026 01:19:25 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <20260930010555.da0b1682-03-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
 <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
 <arubQ77S4mvvykaN@kunlun.suse.cz>
 <20260929163751.4923b819-9f-amachhiw@linux.ibm.com>
 <aruso0aJ4lsrERTb@kunlun.suse.cz>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aruso0aJ4lsrERTb@kunlun.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dzxm3IC5PlKf7ENDYXBD2cSvsFChDDD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3OCBTYWx0ZWRfX7X6e3shSOl/d
 gvws2rxBGAgKDb7hD1jZxdMo3hswYiXFE9luhsrrTIfAXhmo5sLTKJXOdwP7WWohqh2bZMpW7uh
 zVO4evm1G7ORp9U4O9f89vB3z0y5eQqZtIckMrEs9PX8bFY+isTTnyneLE8jxd2uk8MvLZ9iCkR
 ADeTUDCTvuwrb9URtSkUoJMkD6MxiuoQw9A/V8381GyOu10TZndsC49H/pc2eUmKYxJkEFrQeHm
 e3bEByJMgUDL3s0/E/Kbo6Dll1jm/BdvRZvmWNNb1FV66XsODZ0+xPdICYEGNwpSHL2pX0m9nzW
 ucP09/wmfQbAJBsqqWIFg/uO+RQlCYDmBHcEN/JfeIQpN35oI61LHdPBLBjjyGBnNLqB9nuHS1r
 H31az7gU1lXrqhN2/fHqpkubdqwMD8bTgASyqDw/SaTuhd6TLQeeINP2zjk4r7hIaeK5gVaWow5
 caIArcCxxWboscwm/VA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3OCBTYWx0ZWRfX2gulhvDkuLox
 cy0rhZ0/VaqYi9wh5iv8TjGss5PvLk9rU8tRwODBtiv59oQHqdNikerOefI2yhlg3ReU+PUM/Dz
 jgTyZF9tjI+7N/YtuUTx1hfgeOFLZus=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abc163e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VLc2VSdLAAAA:20 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=S--FcjTHKVNtzBQIlrYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: dzxm3IC5PlKf7ENDYXBD2cSvsFChDDD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290078

Hi Michal,

Thanks for sharing the host information and the full guest boot log.

On 2026/09/29 02:18 PM, Michal Suchánek wrote:
> On Tue, Sep 29, 2026 at 04:39:05PM +0530, Amit Machhiwal wrote:
> > On 2026/09/29 01:04 PM, Michal Suchánek wrote:
> > > On Tue, Sep 29, 2026 at 09:36:05AM +0530, Amit Machhiwal wrote:
> > > > On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> > > > > Hi Michal,
> > > > > 
> > > > > Thanks for the report.  We have been looking at the crash and have some findings
> > > > > and follow-up questions.
> > > > > 
> > > > > On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > There appears to be a regression between
> > > > 
> > > > < snip >
> > > > 
> > > > > > 
> > > > > > Linux 7.0.12
> > > > > > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > > > > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> > > > 
> > > > I have been trying to recreate the issue with this kernel and config but I
> > > > haven't been able to.  The L2 KVM guest boots fine everytime.
> > > > 
> > > > In addition to the requested information, could you please also share your qemu
> > > > cmdline/guest xml you used?
> > > 
> > > The XML of the VM is below. What other information do you require?
> > 
> > Thanks for sharing the guest XML.  I had requested some more info [1].  Could
> > you please share that?
> > 
> > [1] https://lore.kernel.org/all/20260928111234.faec09f7-8d-amachhiw@linux.ibm.com/
> 
> Hello,
> 
> full log below.
> 
> host:
> 
> numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
> node 0 size: 122139 MB
> node 0 free: 103635 MB
> node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
> node 1 size: 139516 MB
> node 1 free: 128483 MB
> node distances:
> node     0    1 
>    0:   10   20 
>    1:   20   10 
> 
> The patch does indeed make it possible to boot when the buffer
> allocation fails.

Glad the first fix works.  That fixes the crash (the NULL deref in
__find_event_file()), but the ring buffer allocation failure itself is a
separate bug worth fixing too.

My suspicion is that with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, si_mem_available()
returns falsely negative during early boot because NR_FREE_PAGES only reflects
the non-deferred memory pool at that point — the bulk of RAM hasn't been handed
to the buddy allocator yet.  The check in __rb_allocate_pages() rejects the
allocation prematurely.

  [    0.149312][  T743] node 0 deferred pages initialised in 20ms

Since the issue is not recreating on my environment, could you please give this
patch a try and see if the actual crash goes away?

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..224cc0e5c066 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2454,7 +2454,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
         * not going to succeed.
         */
        i = si_mem_available();
-       if (i < nr_pages)
+       if (system_state != SYSTEM_BOOTING && i < nr_pages)
                return -ENOMEM;
 
        /*

Thanks,
Amit

