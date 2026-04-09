Return-Path: <linuxppc-dev+bounces-19525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13DBE9DE76
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2026 09:15:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frvQs2x2Sz2ygf;
	Thu, 09 Apr 2026 19:15:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775726101;
	cv=none; b=jbDnQUit6RVGiA8HPYuHhAGvRA0MRj+GsMpUGZfo2GRKbercNtz4vQ/8BelcHGpZu9J+Au2ZziaHTBu4IdUcP7zewjP3jImck+dOJjPqMtHn2QR75MF4dOkk2dOUTwJ1SMFrQ38+PvflQnv2tnQIUW733197thKFLACBEyUvXzK3dqAg1T/EMWR32IzVfRPyttM1tGyyKvySLXmwWSGfXA1MohWEMjKOpVUXbUp/+2mueLjJjUU2tU1P1aXYyROJPTOvuv9PlRZt2Mvgvy1XQnTLO6/LLqs3RX6YdrPyOp2lT8Gz2Fo09EqsyqS0Qh49+LpEqd2cu/Ttxcj1kSaesw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775726101; c=relaxed/relaxed;
	bh=qztn0r0ppqqfTSSHEE5GGMaEoUogSLVB8uoV0JfYYPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=egRHlSIaqfLKOSWF68UGIFihz0eMLLZD6eWliZjyVxO3SyMbnSQo/P2b1gEKa6VCYAOK+BJTyJYlMJoNFPVRGHlm0jePigbMU+cCGqoCTbgNZtIVtcrWNbOBIG4gN6yYjA0I6HU8Qjy5o/EdRx+9WBMiZ5SKp7vpl2PPvP7KUwzHzi+pDXUE3JSjhIf0GUrFN1vmMIXI2hJ60UluVa0G4QeYHEfcLUw2gZGD6F+o1B+MF6kzk3lGWaRr0VDCDFAF96LJF5WU/gVxNvumV0OMUVLP6r4nMBcGptQ/q9ffvhwEBNrIEzwsKcdirMnuAwsl2S3CVhiqdMbUdFHq47ySaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CnUpwO8I; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CnUpwO8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frvQq2cBtz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 19:14:58 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638I5ijO2304658;
	Thu, 9 Apr 2026 09:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qztn0r
	0ppqqfTSSHEE5GGMaEoUogSLVB8uoV0JfYYPA=; b=CnUpwO8IEPBif0oOYhiDN1
	kKwTxbQ3z4oLHGiuTnwOp2S2R6mVh2byJUfia1iWfnG/I1rdnnFCu+JdjNLXNc9t
	+S5H5DjTiUDYij6t7Huc60UPf2sHeuHKpWxyHvHsa2eOxtFlNqiEWMB2cHuGmdVb
	msY5fi8u/B3AAeM4JVc3FEQXoJFv/GUfCCHbhBaCnfh/0NbJUT86kiIvHkNGsbGo
	7KKa6QuSmT8HHvioRRPVkmHpW6oV89SD8HzIScZ2gmtTUq9eURPCSZhU8JqPZVOo
	IxwBelbvY1jxtqR5bYpPSzqgf25M655SQNhWGfVEwnJourfTYDlyp8eZJxorNNYg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g3cdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 09:14:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63983O6E013824;
	Thu, 9 Apr 2026 09:14:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4ay52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 09:14:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6399Eau231457868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 09:14:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44562004B;
	Thu,  9 Apr 2026 09:14:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B7E20040;
	Thu,  9 Apr 2026 09:14:34 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 09:14:33 +0000 (GMT)
Message-ID: <72dc5a95bfa2fbb24df65428a435547dece676fa.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/fadump: invoke kmsg_dump in fadump panic path
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Hari Bathini
 <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>
Date: Thu, 09 Apr 2026 14:44:33 +0530
In-Reply-To: <99c837d3-7b70-425e-b1e3-e4e5361eca5c@linux.ibm.com>
References: <20260407054341.308710-1-shivangu@linux.ibm.com>
	 <99c837d3-7b70-425e-b1e3-e4e5361eca5c@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d76e02 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=WMI16Cjdq0lrhamvfOQA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: iP8FdnExCGRarXAQ-Wm1ZeOS_2T9oI3h
X-Proofpoint-GUID: 97fRoAlpzxd3NPk3ShcGcV084K1lIZoK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3NyBTYWx0ZWRfX9F92c8r4ccef
 iOxut1g/Hq1NNn+BAD7d89JArOejkNL7PCvAIuqgZDG8aqiuPhQ0j2Sxztp89fZFiTK5VDaybi3
 xJA1EBuv2C5zvX9s1fF8ixl7Yjovk4hO4xL51Qsc90hRP0AwzbLMJxOLuoZ9HusRAzDh1Qfr9Nd
 OpdT26t4gebqf9AftADC/c0bhR7bWUJAhofW7/SKsUHhBc/bAfE4ANpbgNKRPcb1VnneYdS7+WP
 0rhEAMjBRVySOy2zj7tsmz8aFscr7rF8eRQNV/1mrU6NuTRHq8gWPRcWwhJrTIjhyL3Svdop5Mr
 X7zKE0lPPGCwUj6vUT2+rfp00EElAWghf0DddEOisFTpZeMnRhgtj1aPaL9QWWrBIacUtO3TahP
 4A+CCPNh1mNIcWe8LZ2YhAlJlQn21G54aNVd3MFsNQ11u/3xQj/1tOJDOv+uNKKPlkFYNvA3/IU
 ZwIvQA4mpylyrMQng8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090077

Hi Sourabh,

On Tue, 2026-04-07 at 21:00 +0530, Sourabh Jain wrote:
> Hello Shivang,
>=20
> On 07/04/26 11:13, Shivang Upadhyay wrote:
> > fadump is registered in panic_notifier_list and gets triggered
> > before kmsg_dump_desc() in the panic path. As a result,
> > kmsg_dumpers (e.g. pstore) are not executed.
>=20
> Can you emphasize why it is important to call kmsg_dump_desc()?
> Because fadump captures the full memory dump anyway.
>=20

Sure. So pstore kmsg_dump can be useful in the cases where we fail to
reboot system with kdump/fadump. Because pstore kmsg dump is collected
during the crashing kernel, it can be *only* information that we
collect from that system.

>=20
> > Invoke kmsg_dump_desc() from the fadump handler to ensure
> > kmsg_dumpers are called during panic.
>=20
> Can you please add some command output from before and after
> this patch series? It will make it easier to understand the impact of
> the changes=20

To test for this case, we just made sure that pstore kmsg-dump file's
time stamp was getting updated or not. Currently in fadump's crash path
pstore isn't collecting any logs.

>=20
> >=20
> > Cc: Hari Bathini <hbathini@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reported-by: Shirisha G <shirisha@linux.ibm.com>
> > Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> > =C2=A0 arch/powerpc/kernel/setup-common.c | 3 +++
> > =C2=A0 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kernel/setup-common.c
> > b/arch/powerpc/kernel/setup-common.c
> > index b1761909c23f..c329b071643d 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -68,6 +68,7 @@
> > =C2=A0 #include <asm/kasan.h>
> > =C2=A0 #include <asm/mce.h>
> > =C2=A0 #include <asm/systemcfg.h>
> > +#include <linux/kmsg_dump.h>
> > =C2=A0=20
> > =C2=A0 #include "setup.h"
> > =C2=A0=20
> > @@ -748,6 +749,8 @@ static int ppc_panic_fadump_handler(struct
> > notifier_block *this,
> > =C2=A0=C2=A0	 * If firmware-assisted dump has been registered then
> > trigger
> > =C2=A0=C2=A0	 * its callback and let the firmware handles everything
> > else.
> > =C2=A0=C2=A0	 */
> > +	kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);
>=20
> Can you move the kmsg_dump_desc() function before the comment?
> The comment was for crash_fadump() function.
>=20
Ack.
> Yes, panic() passes the reason for the panic as a string via ptr. So
> it=20
> is good
> to pass the same to the message dumpers.
>=20
> As sashiko suggested:
> https://sashiko.dev/#/patchset/20260407054341.308710-1-shivangu%40linux.i=
bm.com
> =C2=A0
>=20
>=20
> I think we should call kmsg_dump_desc() only when fadump is
> registered,=20
> to avoid calling
> it multiple times. If fadump is not registered, this can be called
> twice=20
> in the panic path,
> first here and then again in the vpanic() function. Checkout=20
> should_fadump_crash() function.
>=20

Sure, ill find a new place to call this.

> The second point from Sashiko is about introducing something like=20
> crash_kexec_post_notifiers
> to give users the option to call message dumpers on the vpanic path,
> or=20
> on the other two
> paths as well (system reset and die) when fadump is configured.
>=20
> I think this is not really needed because there are already existing=20
> crash paths hitting crash_fadump
> (system reset and die) on which kmsg_dump_desc() is called directly.
>=20
> > +
> > =C2=A0=C2=A0	crash_fadump(NULL, ptr);
> >=20
>=20
> As of now, crash_fadump() (which initiates memory dump
> collection) is called through three different paths:
>=20
> 1. System Reset
> 2. die/oops
> 3. panic
>=20
> We call kmsg_dump() -> kmsg_dump_desc() to invoke all message
> dumpers on the system reset and die/oops paths. The only
> remaining path where kmsg_dump_desc() is not called is the
> panic path.
>=20
> panic() -> vpanic() -> panic notifier call chain -> crash_fadump()
>=20

Yeah, the other paths should be covered by this line in crash path here
[1].

> I think it is good to fix this path as well. Thanks for the fix.
>=20
> - Sourabh Jain


Thanks,
~Shivang.

[1] http://elixir.bootlin.com/linux/v6.15.6/source/kernel/panic.c#L387

