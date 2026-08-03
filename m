Return-Path: <linuxppc-dev+bounces-25242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF71AC55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vJ0YX3z309w;
	Mon, 03 Aug 2026 16:58:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740284;
	cv=none; b=Ejri78yreF/wSW+biBHyONmMrevTsUbLo1cgXekbCY0vr9+Fxe+LtZvDNGpXhAufKV+td2cCwCbv33eWxy+wM8p1yCjyzoTCmTA4574yks9qa07q5dIPcvF6tByxEJO7M6HvVBY3xt7uqnoBOdMhd5TJYhch7ksAdvInov91CTFLuFquRNWDXzI7XgvoaTblfVR3XQGIOJ+k90mfD7Fe8fFVKE+trw1RZPIaCGni9lfrWDdFSRke9QJnIIXSaXj4cgns5r85jvnP92owOKY4zd8+IGV0CKAPEqZZvHsEX4wQsBXMzYH0LbHGBAu87wIy5QuVX1IA/16zc9TcZ/ogVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740284; c=relaxed/relaxed;
	bh=1R3n+IoCM1ZOHUYIV5Qef7lSPk282K7E+G3fJSsnbZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5dqoloj5Uj4xSToYbySJ0kc5dRuTXMokQLXVh+N2FRFGa4B/YoMqaaBnno6RXNtw0cyQQhdZXZGt8MaJZ4GaTW3HaN7xUv3RTqkwKpheE8rTjzH03/SfRztB6L6dAyjWJVLW8QjdM0186UolFlKnhSz/FTwvBMrk15wU6dTqmz8IPCxQ/154zq+hTf1PWLtALKV8Yu5FBsueRE4VoX/x/3PZh93U/YqVMwVDhBvj67BagQejzJ2miMNZMbP9A5mBKc+Eu+2ReaeKxWp6yW3OVG32e1pw0fS6AC0A+04rqewhOhsyi/TeFG6bckTSXXJTfsyAn8P+bp3A+A1zEGV8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fN58jN80; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fN58jN80;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vH29Zmz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:03 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llkk0167346;
	Mon, 3 Aug 2026 06:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1R3n+I
	oCM1ZOHUYIV5Qef7lSPk282K7E+G3fJSsnbZE=; b=fN58jN80xax3qT4brUZ1ua
	BSCFnW8fjd/iapsRkoC7EIb+lOPWEgJi7+4RMFK52msVCTzTWzyN1XoAnVxh+tar
	k1SPdlyE5OznYaTy0gChXFNBYo61osoGchmiK0IbhermOKmBR+ST7wJWcB6GbY/h
	yb0OVbyGQS8/S3hPed68vsfLNL1hExiWaMYJgzEc2iCbFUC5/jzTQihre9IZfXm8
	ASd3XC7Fr96Y3/8XXkuC7Bp+2FtjJ/DsofNoVgdGqFQ1ZihMBr0y0P08kqvnvSlX
	O/7tvJFS5KAfVao8IZz/kuxb5FBJRKxN4XtZBgCQkhhPDOpb8f70Xb5/j3mpCfDw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fy5ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uFNo001010;
	Mon, 3 Aug 2026 06:57:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh430d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vMOu38666544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 631762004D;
	Mon,  3 Aug 2026 06:57:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDCF120040;
	Mon,  3 Aug 2026 06:57:14 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:14 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
        ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
        tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
        nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        justinstitt@google.com, fujita.tomonori@gmail.com,
        joelagnelf@nvidia.com, gregkh@linuxfoundation.org,
        prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com,
        lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Date: Mon,  3 Aug 2026 12:27:13 +0530
Message-ID: <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708082454.1254320-1-mkchauras@gmail.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXzixZXzybs/2o
 hUANJj1w7Lz32jxnD2KmcjMwry6QVvpb/HPQpbr8B8OCd07J7Md+RSrl/eYt9RPKRtMnk+jvA32
 VCNlXc15NxW159YoV1qGzXMoQBxmITYfyUTxA/QtZPCAy/Yl94v7YcOx6QoFgh5XyZJOHlg9G7i
 CIRifyqGI6nXoJOJ6XWODSN9ZLsQdi2xDrxCE0vJpQqv6Kmdff5gcdsH6ZcGZOev46g9MiL+KCp
 YM5eIjoqLAKc3wOD9TvGDtZ8gPhiAj++6H5izS7JyKVvnFXkX2DHSZg99PVzuYphlkMq/m6/6A6
 87MsnjxK6KHPO0v116U+worintGA4ZJxX9/O6E7eRAMlAUi++vx4lb5c/W7hkLOEbfgkPLLJOSB
 0FFuYSRElSGqFVzUWkgf5FWosMV1CZywP6K1r/IX5D2uUoYy7IHaSS+t3MoKvqcDGy5mOcnV0PI
 9r5c6SKauJ4ZPuerorg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a703bd6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=8O71z6kVuDHv7qOZaOcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0z1FItzTZBVV0JDu10ANRIm4pigg_8Gl
X-Proofpoint-ORIG-GUID: TGfsrqQzsgVAuxm8WyNEIEWnR2AAlIak
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX0nf5gkRq3noj
 37ycwIHjzcvJeumGGfqXbg9nyPRbv4SaKmxC2tx8NJGExr6ugyHF7WD9V+vRx7bMf03b8drO2df
 CHNEiRqVgpbGJqA5pzV2KuF4L1UZLe0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enable experimental rust support for ppc64le and ppc32be. The patch for
> ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> `rust: Add PowerPC support` and the discussion for that is done here[1].
> 
> This has been tested on
> - powernv9 hardware
> - pseries P11 hardware
> - pseries(9, 10) qemu
> - powernv(9, 10) qemu
> - rustdoc on x86 and powerpc64le
> - rusttest on x86 and powerpc64le
> 
> [...]

Applied to powerpc/next.

[1/7] rust: Fix "multiple candidates for rmeta dependency core" error
      https://git.kernel.org/powerpc/c/00cdfd072c709c608606461d7d44d4613119bfa9
[2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
      https://git.kernel.org/powerpc/c/be809b60cbb61aab96179f44ac3670242ae72996
[3/7] powerpc/jump_label: adjust inline asm to be consistent
      https://git.kernel.org/powerpc/c/13244c0a40139fe66c4c5c5655f4d732a6002957
[4/7] rust/powerpc: Set min rustc version for powerpc
      https://git.kernel.org/powerpc/c/e299147cdc8e19c6421a6b7863dc82a35b09d967
[5/7] rust: Make __udivdi3() and __umoddi3() panic
      https://git.kernel.org/powerpc/c/c93c194e4ee71a734986fd99a8b1ec9fbb7a9b8b
[6/7] rust: Add PowerPC support
      https://git.kernel.org/powerpc/c/73b741adb264967093ef4eb59905618a7e0d0de0
[7/7] powerpc: Enable Rust for ppc64le
      https://git.kernel.org/powerpc/c/bc87cbdb952e9223616b839d64bdb4723aa2ed1d

cheers

