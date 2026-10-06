Return-Path: <linuxppc-dev+bounces-28952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7ACCA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:24:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzW7D4YfRz30Pp;
	Tue, 06 Oct 2026 20:24:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791278696;
	cv=none; b=DbtHmjuLL4yUoZ7sB6tXHKS0YCSK06gEU1zt4ASfL1TI4G36o4sg69VZvuya6zSPfLqU3N0pMHkJyiooh6ZSweDxjiRC9Y20IKUYZbQkeSSC6e/VPjjRXQd27NuuH48BCNcE9ti2QKEJADE+icVqX/osbncdlRuO1U7NDRKf07lJoEnXQaeY6okNcwbnkbzXgV65QMPF5Qlpaxwt4bZPJQVJUL6N5O59sag/hkK8eBZDrkltZRAi2QO8U0kMgFs1pd0Z6irVSepjyL4I1PdQwBzX7jXfsMQkvWkCjov2Rf0DxuCDLESvjJrhTCIt+ZpKFP6GFVyr+2RRmb6VEFJsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791278696; c=relaxed/relaxed;
	bh=FwTlJ5UQ6AWxL4SurT47yrw+s88iAmevtRb+S78ziO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5L3tCljBqOCTuDEz3Gvsv1sLQhgpoJMYJsFbWTilNM7ZvdkIjtQwjejHtsu9j0svMqsnmQX0g9SDxf3hoeDxk/0Mg1kjFxyOV7swKC8bRfqzWJfwTa8S92hH1B5UnehyS3UfqoomA7Uf/Ir8H6sqag49S0c5T/wkuMd2sGTi3309l3dkBPFB1p/FjG4oVQHocU0dqiYebl4ifaghTTD/pgItH3LQH0uRWQj5IIGEo4oc39AUrV+1UnC+6G0pjcM6eYlAIDtkL58Ie5Qo9AZh8RDbmPloi/7SLHjm2DEVYU+YoSLDclMCZcUvKpp5pm2NbXR51jwOl25kQZ7A82TXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KK/0lhIC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KK/0lhIC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzW7C5Gs1z2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 20:24:55 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966brUx2929762;
	Tue, 6 Oct 2026 09:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FwTlJ5UQ6AWxL4SurT47yrw+s88iAm
	evtRb+S78ziO8=; b=KK/0lhICAcVKMl3zTAaOYzz1y1vzi/2OB0O9FT7hyR/l1+
	3pA+wt7DzhA+USKKDAPIpZp3TvdlULqok8jfE7eSyBhImJEVwPD/EioUr8NT90ud
	Lzy6m+UpIXs0oHemxKQiTUIQImCS6Nx3Wzc+NfQKNRhQ/VwtX4Wv1lhHJpOOVlpO
	RQMWYUa9rKTGmj+hhQbeR5hPYt+rm2AqBOWM0Zgf87bchFGvPDl3DYvr7XYmQsz0
	wb23v/+28f0PQ1qopzqEqzlF0KRkiqAv2MBKFem4P0RVllJWgLoTMxWep8doH7kD
	15wmUd7WgaNydbWtS3/lxpt27ulgcu97e5hSsBMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv65g2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 09:24:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6966leWW2849998;
	Tue, 6 Oct 2026 09:24:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g933r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 09:24:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6969Oolx42139998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 09:24:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0699D2004E;
	Tue,  6 Oct 2026 09:24:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD14A20040;
	Tue,  6 Oct 2026 09:24:48 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.24.208])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 09:24:48 +0000 (GMT)
Date: Tue, 6 Oct 2026 14:54:45 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [REGRESSION] RAID10 severe performance regression / unable to
 rebuild degraded array
Message-ID: <asS9dPrjE7CDRPcM@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <610543697.64938.1788619385880.JavaMail.zimbra@raptorengineeringinc.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610543697.64938.1788619385880.JavaMail.zimbra@raptorengineeringinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8Ea7olivVEVdwBk2Ep4bd0fG-Fn_QSP1
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4be64 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_MR6v-QCxBS8ncdU9A4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: tWkzs2AerZvY3tZbJYl6DC676JLCblhP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNiBTYWx0ZWRfX1ZiqTJIwSKhK
 RZPge/erZ+hIOlfzUzXVGjSxM1ILNRqD/yXudQADwK9WgLXXpl3DNWSAMDwxMH0QoSJhp7mLPny
 kPHbwEdPK/w7uB5KSj1mN5zj4Z06+L06Vs3XBRS2qjvFoiLtP28BC3B9MG3cg/vu2mYWKZ7EiEr
 rpG8HAk5VCJfq6ah4sBL8BBK/bJk2hLkRR3MU/8NwGNEBZqJEYKqabTfBkgSxE0Mj7GzQMqQuxi
 MELdafeVAeybewnmAj/PV4LVeL5frG3210GFdLLR9tuck7o32yqbiTA9GQ4RwcXDucxzDLlWzCE
 NhwepwGIwVMOt+nZp6FePa21CrlTwX1SHiGkWFxZmLse0cKeybjEuCspYXurzLQ7NYXNh1RLDp/
 yEngBSjVMb4qabhfygqiQG8hJyKIqBGHgAiUl38Z4vQYqti/qVmagWiVRRGatwN0XUvN6m3YvMw
 afosebIYZAQp2svJKKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNiBTYWx0ZWRfXyuJcegX7RGTS
 mcbkEHAGRWxwLUDjQWT83M8S7bichHS5e3AaKXx8ZEjyO6Y7j74oLYMmZDwjKYzhWnKHwsEH6Iw
 jk7PofGJkLpChLufKaxsYmDmQmEqW2I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060036

On Sat, Sep 05, 2026 at 09:43:05AM -0500, Timothy Pearson wrote:
> After upgrading a POWER9 pSeries guest on a PowerNV host from Linux 6.1.0-18 to 6.12.94, rebuilding a degraded RAID10 array behind an LSI SAS3008 controller passed through via VFIO proceeds at ~1MB/s with 100% CPU load on one core.  Booting the same guest with the old 6.1 series kernel and resuming the rebuild of the same array proceeds at over 200MB/s with minimal CPU load.  For completeness, the default 6.12 readahead settings were adjusted back down to the same values as the 6.1 kernel, with no improvement observed.
> 
> No variation in the regression was found between host kernel 6.12 and host kernel 6.18.  Since there are no other reports of similar issues from amd64 users, it is presumed this is a POWER-specific regression.
> 

Hi Timothy,

We suspect this degradation is caused by the spurious interrupt problem
you reported. I had posted a fix for that problem [1], would it be
possible for you to see if this problem persists with my patch applied?

[1]: https://lore.kernel.org/linuxppc-dev/20261005084534.1588611-1-gautam@linux.ibm.com/

Thanks,
Gautam

