Return-Path: <linuxppc-dev+bounces-29110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09983CA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 16:43:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1XkC3jLCz2xrL;
	Sat, 10 Oct 2026 03:43:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791564227;
	cv=none; b=gg4JyDmUULppGYd35RYDrF91/pk8OOchDW9oYwPVP4oDDIMPGEiHT2JFpZUqGhRiYju4EhpdNdueOrJr6vUpSTeXRjuFFjCfCPjnKT0BbMk371tZIzLkme/YSFS92F/ntHqYiIK17t+TFevQKcmXPRpK+p8swngO0kDsySlkTK2o+oa0igY/DoJGkLcim0dO9UP7zeQeklUil5Fa1dkY+vd3r3wGzt+4tv7AJoM22pwcVthhGJmbyMVL88PYmrnWN2vKY3dUqLEJSvymEFfUvIpxYmrchJVPFK54EMBy9a+i6W+lCQCv1Qp8it0N2oJHB1ubMi9p4NhzVl3ZyAT0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791564227; c=relaxed/relaxed;
	bh=+ef5g0aMWIqMYuJsJLVaNJ8BpDjcCS4B89DLDl41NaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWnrrMvr+dpBvBnrf7DgtpZh6bQLLpeZCnZbE+KkYSTSnf6e9Gg5wWPnBjOr0loiT7RA304xiGkgk9hXsf25gnTbawwDaP4fOCxyg+Y3XyXxllwpWdyDncCG/mc+1A6JkhUSU6lWNo5MCzvIXWniIa5/sLB3gyjh33lQDJzDWou/FD+Q3T8b8OBWHBcTnJihRKkedjJjoeh6gRBDzw0q4oT5cHz2JpzGLC7Vc+Vu19K8RDaJs5ZCvpJJy9thjZHcOe5plRgNPFkFQ6Zj1DR5mZg5QBeYdhaC0ZQ64a+TWUpmZB1yMxgSkMJWLo+InLeua5u+bzZxQeqWyievhfmGew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cTZM13LO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cTZM13LO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1XkB45y0z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 03:43:46 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZg27679372;
	Fri, 9 Oct 2026 16:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ef5g0
	aMWIqMYuJsJLVaNJ8BpDjcCS4B89DLDl41NaQ=; b=cTZM13LOieSlWItd8fLkjt
	O7FzYGrOaok1QyZatwgpHPi9qnT/LeQ5vmr63d5+RI4X4uzruTZSvqd1rLXuuBEm
	1mUn9BvcZosPgJn9jBIyslqbrw1I4R22I0vyi5MURUx8O3zFSaFTfW74pmZmsxLe
	0eF1St152AgMtwSVJoD4ddP/xqm+8ECCkBtWWrxXPJWb1OusuoKDKK3+m3KdVzxH
	JKRPbHDcu3wqNEj90aMlnAqGHTF9zKfGX+LuiGRVY+5fKhjx6RutoorF/fjByUrK
	UrCtC6iVH5kqyjbswFQMFalNezbmyPbOQXxIdF0n8MuDlhdRhCbawwevzIQi46PQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw3vqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:43:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699GJLk91086207;
	Fri, 9 Oct 2026 16:43:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd1w4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:43:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Gheq348693698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 16:43:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60EAD2004B;
	Fri,  9 Oct 2026 16:43:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8639D20040;
	Fri,  9 Oct 2026 16:43:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Oct 2026 16:43:39 +0000 (GMT)
Date: Fri, 9 Oct 2026 22:21:53 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <20261009221812.73c7c644-d6-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
 <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
 <arubQ77S4mvvykaN@kunlun.suse.cz>
 <20260929163751.4923b819-9f-amachhiw@linux.ibm.com>
 <aruso0aJ4lsrERTb@kunlun.suse.cz>
 <20260930010555.da0b1682-03-amachhiw@linux.ibm.com>
 <arzoc3etsNPU0JZU@kunlun.suse.cz>
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
In-Reply-To: <arzoc3etsNPU0JZU@kunlun.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HMS2i19zRpNS7wGaK-OR05bHjbQH7ulh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfXy3UEIB9E5Z8b
 VS/1dVSXqjDWlHtCu4/x3651C2nRxrSgLecMd+IXMUFIBaZaCnNV8NZMk5k6sn9L6EFBN0/uKCW
 kanZ+A5HSSIUnYvfDZ8f2C2mH0uwwSjbXnwwDbi8wKgsIHH7IOPMcLjCXGxanC/QzeVRqrqL22Z
 0sdxGloO6TA49xHDuElQQwfEj5fBwEzIbyTRph4jlnkoNykfuvabCZBrSXocAcCxaJPu4DEL74+
 VfrO/9+yB+ZX9eOHWmAAFcaQqEJITEHEzvHW536D9ks+RBA+5l67eiwzQIPLohHYJwiOCBa6kVF
 h9MEGiicE1ptElTmtUHTuSEmYTFBjuarY+51/U7kRpqRoDE0efd3IcmuNfVZCJcwkEuyhoUAfG3
 rxw27vTq3AkmLJut51+veKvGhXMonsVL20AqhQKml5iUAmj2lp5FXDGPTbh2Rtw0VBVSCbei4sk
 aYgSjBu5wnYnW309uhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX/rvDv8iw3aoC
 2rLTfQhR7JxmhG+SkRinO8kTiNXuaOdG1jZuDstlmxyPTf5ks+mFzggA8fWfjtqB+ha7zZAK9mS
 KiNVSg6NfWTK/GgidKsMkoapVOzZFTM=
X-Proofpoint-GUID: HMS2i19zRpNS7wGaK-OR05bHjbQH7ulh
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac919bf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VLc2VSdLAAAA:20 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=TleyraooDhMmue150qsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066

On 2026/09/30 12:46 PM, Michal Suchánek wrote:
> On Wed, Sep 30, 2026 at 01:19:25AM +0530, Amit Machhiwal wrote:
> > Hi Michal,
> > 
> > Thanks for sharing the host information and the full guest boot log.
> > 
> > On 2026/09/29 02:18 PM, Michal Suchánek wrote:
> > > On Tue, Sep 29, 2026 at 04:39:05PM +0530, Amit Machhiwal wrote:
> > > > On 2026/09/29 01:04 PM, Michal Suchánek wrote:
> > > > > On Tue, Sep 29, 2026 at 09:36:05AM +0530, Amit Machhiwal wrote:
> > > > > > On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> > > > > > > Hi Michal,
> > > > > > > 
> > > > > > > Thanks for the report.  We have been looking at the crash and have some findings
> > > > > > > and follow-up questions.
> > > > > > > 
> > > > > > > On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > There appears to be a regression between
> > > > > > 
> > > > > > < snip >
> > > > > > 
> > > > > > > > 
> > > > > > > > Linux 7.0.12
> > > > > > > > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > > > > > > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> > > > > > 
> > > > > > I have been trying to recreate the issue with this kernel and config but I
> > > > > > haven't been able to.  The L2 KVM guest boots fine everytime.
> > > > > > 
> > > > > > In addition to the requested information, could you please also share your qemu
> > > > > > cmdline/guest xml you used?
> > > > > 
> > > > > The XML of the VM is below. What other information do you require?
> > > > 
> > > > Thanks for sharing the guest XML.  I had requested some more info [1].  Could
> > > > you please share that?
> > > > 
> > > > [1] https://lore.kernel.org/all/20260928111234.faec09f7-8d-amachhiw@linux.ibm.com/
> > > 
> > > Hello,
> > > 
> > > full log below.
> > > 
> > > host:
> > > 
> > > numactl --hardware
> > > available: 2 nodes (0-1)
> > > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
> > > node 0 size: 122139 MB
> > > node 0 free: 103635 MB
> > > node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
> > > node 1 size: 139516 MB
> > > node 1 free: 128483 MB
> > > node distances:
> > > node     0    1 
> > >    0:   10   20 
> > >    1:   20   10 
> > > 
> > > The patch does indeed make it possible to boot when the buffer
> > > allocation fails.
> > 
> > Glad the first fix works.  That fixes the crash (the NULL deref in
> > __find_event_file()), but the ring buffer allocation failure itself is a
> > separate bug worth fixing too.
> > 
> > My suspicion is that with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, si_mem_available()
> > returns falsely negative during early boot because NR_FREE_PAGES only reflects
> > the non-deferred memory pool at that point — the bulk of RAM hasn't been handed
> > to the buddy allocator yet.  The check in __rb_allocate_pages() rejects the
> > allocation prematurely.
> > 
> >   [    0.149312][  T743] node 0 deferred pages initialised in 20ms
> > 
> > Since the issue is not recreating on my environment, could you please give this
> > patch a try and see if the actual crash goes away?
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 04bb94c29f58..224cc0e5c066 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2454,7 +2454,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >          * not going to succeed.
> >          */
> >         i = si_mem_available();
> > -       if (i < nr_pages)
> > +       if (system_state != SYSTEM_BOOTING && i < nr_pages)
> >                 return -ENOMEM;
> >  
> >         /*
> 
> Hello,
> 
> this does seem to mitigate the problem with allocating the trace buffer.
> 
> Related to reproducing the problem it seems that it is much more likely
> to happen on reboot than first boot, and the typical solution for kernel
> test automation produces one-off VMs that never reboot. With the VM XML
> as posted earlier using a full production OS image testing is not very
> efficient. Still with something like
> 
> n=1 ; while true ; do echo $n ; n=$(expr $n + 1) ; ssh 192.168.0.2
> reboot ; sleep 10 ; ssh 192.168.0.2 dmesg | { grep ERROR: && exit 1 ;
> } ; done
> 
> the VM can be rebooted a number of times without additional user
> interaction.

Hi Michal,

Apologies for the delayed response, as I was caught up with some higher-priority
work items.

Thanks for testing and confirming both fixes, and for sharing your reboot loop
reproduction snippet.

I have submitted the formal 2-patch series fixing both the tracefs workqueue
NULL dereference crash and the early boot ring buffer allocation failure:

  https://lore.kernel.org/all/20261009163557.88467-1-amachhiw@linux.ibm.com/

Thanks again for reporting and helping verify the fixes!

Thanks,
Amit

