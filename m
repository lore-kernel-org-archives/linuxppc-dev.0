Return-Path: <linuxppc-dev+bounces-28485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECB2CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:09:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvFmY0vV5z2yvy;
	Tue, 29 Sep 2026 21:09:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790680141;
	cv=none; b=diugpSIDKbszSzbXUJSJF4zf5/SyNc0lCxCR+x5zrzvVrr0xOfPsbRuvljY9oickL980r1xZvYkNVr77mECylQkYCQzH/Lg722eqWbDE1WymvLpyE/gN/uYVXs916+QSLC8cNYZUJ9lPlA2VWKDyxD/lHGTHtlW7F8xbeqWbiJxqvTgiEjTtYODnD0tIhTnJJpbmK1xUTAMtCHUbewdWul41lAGSD9UBcXvxCfZVL9K81I8TRjDCI26ru0ENgC0BP+FDibwQYnGVpQqPP3lXLmOLS7q3NY7MkV9fvpfuLtneHd1YqEcuQ/v6e4gN7PPnWc+BYSEEEPj+J7cUcX3KRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790680141; c=relaxed/relaxed;
	bh=jBG7LxsZAkAXQra+/wGEdIA2WFszAwn883qUK7hhWgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XThj77jqQPPMzdkkfHagNHKFojnkCUMX2Fm4hqz/Qjl5FroGAtd+grZhZf/N/m4Kg6F8jHKA+WXW+2eWI7AWjeY9grpsfyyPEGN7xrx1J3Lhw2B3FjSqkUkM2YWZXSwsxeYLdzOCm8y8KvHAwyPYXk3k/+GAvvw+7OgAx+g8hpUzBXaIdoW5Zy0XP7/btjpmvdZSoOJW75n1rxMpdwVEnRsxw5KH45UuLvCr62/MaJajuyq4ByEmPyLVnMcxFPL+UfHER0/6rwegJbSpuRDsgcbNpAVJsOD2t9tgtwZq88031Eun234aLdQB5viVsKJ59lKTfdxuzKDeLeuJxWYoXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bMAd+rKv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bMAd+rKv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvFmX21mhz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 21:08:59 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5NBF2187809;
	Tue, 29 Sep 2026 11:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jBG7Lx
	sZAkAXQra+/wGEdIA2WFszAwn883qUK7hhWgc=; b=bMAd+rKv7QDku6pMB22vLd
	nyn1IlQDzAaJm+3VMk0tFnf1BKP5xLRmxqJ6qD5jp/hMAvag1vGy+fxDj09/OExl
	XGKNstVSMH7F8j2zwItBdYzZNwMNhGL2eH+b/f84jwZqyugB5MzikJP3TFuiiHoO
	S+F28OwYFVeVZsnyxwPnlIXh8/1uqYw8XhAV6FChdJVX4rHWj6Rmng3RgAz6WcfU
	1+CCpOCQtuviA2l2k+Wq1dY9PwE0gJzod7TvpvW1QbUiJavExIxbP+5Uh8iQfXT8
	dkJ6G2lhomob8AXT6WFDtP7QTJ2cVbHZbny9E7NKoWrPE/PD2pOnE2GzSUm1tCPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6k4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:08:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlhhm1608057;
	Tue, 29 Sep 2026 11:08:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck9cgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:08:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TB8tYl38338828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:08:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2CA2004B;
	Tue, 29 Sep 2026 11:08:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD6F20040;
	Tue, 29 Sep 2026 11:08:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Sep 2026 11:08:53 +0000 (GMT)
Date: Tue, 29 Sep 2026 16:39:05 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <20260929163751.4923b819-9f-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
 <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
 <arubQ77S4mvvykaN@kunlun.suse.cz>
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
In-Reply-To: <arubQ77S4mvvykaN@kunlun.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXwaQHaRlZaBvM
 GwnpTl3vfDk3yWlr0RvP9BAa9GuDDlWgv+/jAECObjyo7KIwTygeq/J3Mki5XWLWwDuCS6nBtC5
 8ZoXtV0uN+q+0YsYV3v+RMsEDofE71B1gSnnwDYdxr86XJa9TYSMT/2mrPndslnRKYMo08Di48K
 TfyI0BakfvKbwzxnp8AGxdQ9pOM5po4coqMZRxk2GbPxK5izm0Gz27uUWPPEVvypKZ/wufIbzIs
 JDaKlQ0z73+T2z8vbRGzn6FQucKQoSQjm9lB6JkFz/wvu0u/fgRVh7/TBcqlKqJERPp/xVmJT2X
 DIwG/7E/oYIdhu6dImlOBw1bYaaA9ERB3mNzqovfH1Ovf09wxv72XdGHgMZrjdS/FJxKyfJDqLV
 Ti1NkF+srA7keA67Hc5x4G4dvL5ky0qyXY4NMl+y96n9vgSvhnR3Z7G4/x0qxqSAUa7j4AGUaeK
 pk4C0HA46OzdFa6Toxg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abb9c4a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VLc2VSdLAAAA:20 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=6VyZ6CMpfp4q-7wJFy8A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: cLzbJ0OqIQsP8M4LRgIhdYuaqXzvvokZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX+SlOvbeMAJcs
 QNdpCFCU436LzVpKlra2HTXuBhmFk1UpNpNbgRTRZ32ObwdYeqz03l/4A+zh3BahZVPXCgg2kHP
 Ts2xCCt6BYY5Ks33SU8aCoWRbEAilYM=
X-Proofpoint-GUID: cLzbJ0OqIQsP8M4LRgIhdYuaqXzvvokZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On 2026/09/29 01:04 PM, Michal Suchánek wrote:
> On Tue, Sep 29, 2026 at 09:36:05AM +0530, Amit Machhiwal wrote:
> > On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> > > Hi Michal,
> > > 
> > > Thanks for the report.  We have been looking at the crash and have some findings
> > > and follow-up questions.
> > > 
> > > On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > > > Hello,
> > > > 
> > > > There appears to be a regression between
> > 
> > < snip >
> > 
> > > > 
> > > > Linux 7.0.12
> > > > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > > > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default
> > 
> > I have been trying to recreate the issue with this kernel and config but I
> > haven't been able to.  The L2 KVM guest boots fine everytime.
> > 
> > In addition to the requested information, could you please also share your qemu
> > cmdline/guest xml you used?
> 
> The XML of the VM is below. What other information do you require?

Thanks for sharing the guest XML.  I had requested some more info [1].  Could
you please share that?

[1] https://lore.kernel.org/all/20260928111234.faec09f7-8d-amachhiw@linux.ibm.com/

Thanks,
Amit

