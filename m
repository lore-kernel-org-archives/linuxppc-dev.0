Return-Path: <linuxppc-dev+bounces-18563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1CDD58CB4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 00:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffDkc4pcVz2xls;
	Mon, 23 Mar 2026 11:36:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774226200;
	cv=none; b=FmCF0KKdWSXbcwtrFNcenZ9oOjGTlda60SnvEr9Iw/kpsyhr2jWeWGTq0lso5ue4WMQM/z+CDmFvVbknk+eo5Nm1vNg0YQSvOBN2QWdBA5DTpGSqyXI5M9AIXZkYB5bfKf+OM5sPOrOA79IAcKyLss2BM7eAiFrtiOd0fa9BndzCkG/ckuZ+CCPc+jttllkvZ2ZadHiWpwOq/ysvxK3aoc48Qy1t96X79PHvFhveAQA5wYkJp7m1jKA5X7lko8RcqTsEKWLPZpJjlScdQ2OvxbSiQEqOtfDZQQ1UmF6KJ5HNpm1n/559jBh7q5+XkGKxN5T7GI/GsbimKi9/PeJVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774226200; c=relaxed/relaxed;
	bh=XUNjsJRMkb+HTDokifbsZ9wmoKhH8Iz0vtFPn8y+DV4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DAmhlyXBb52L+gQmdOeOdxvsBwjy334qz+JXZWhPKgc27hNH08W1gULucCa8MzL+XPdnGBQpcF/OX3mMzsgigtyEta2CNAj0l0ICyzGhqdFikckUR/BmHQdPqLlWsH5qdTu8VBGlL57Fk4YV0jlWy8R8z/OfrshusemnVV+inSpU+i+1EI5pRztmSm0jIVSEWCz2M1mdW6Iuvt2gVzsAfE0QCJNGVbbmHC9HtI2CTQzZfo8Zf0OH98wSyVnPZxGzPL7UfW/eVTpJumRCQ1LJoeVil+081TSFsspaPx5J53ul0GeXZSxff7PtrmcREqhNiFSXWVtN8V9U7lW0zKys4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=ZKV1HFzm; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=ZKV1HFzm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 384 seconds by postgrey-1.37 at boromir; Mon, 23 Mar 2026 11:36:37 AEDT
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffDkY1BZcz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 11:36:37 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D96217791C2D;
	Sun, 22 Mar 2026 19:30:08 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id A-akTtLceq3C; Sun, 22 Mar 2026 19:30:04 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id AE3FC77908D9;
	Sun, 22 Mar 2026 19:30:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com AE3FC77908D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1774225804; bh=XUNjsJRMkb+HTDokifbsZ9wmoKhH8Iz0vtFPn8y+DV4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ZKV1HFzmEvDGTobM3UaLN/g+35d0v8QcEGLuYq4dzqkodwkfpVNG6iGZRzaqJFUlN
	 ULLKzY/pPRNHWSAtVoAuwNXehuRtv8vAPjcToBSDBOOTlb1aeQzGkigJFnCpC3bfIo
	 4MNM1WcPvIyar+DdSwXucIz7HSfXXxJ7UtrDncXU=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C-xwQSM_Itd6; Sun, 22 Mar 2026 19:30:04 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 657787790EC7;
	Sun, 22 Mar 2026 19:30:04 -0500 (CDT)
Date: Sun, 22 Mar 2026 19:30:04 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Gaurav Batra <gbatra@linux.ibm.com>, 
	amd-gfx <amd-gfx@lists.freedesktop.org>, 
	Donet Tom <donettom@linux.ibm.com>
Message-ID: <1646525566.315562.1774225804200.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1phlu3bs.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz> <1phlu3bs.ritesh.list@gmail.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and
 newer
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
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC145 (Linux)/8.5.0_GA_3042)
Thread-Topic: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
Thread-Index: kp4EDOKqz4Lv02hEmHAiKBZnOTq8kA==



----- Original Message -----
> From: "Ritesh Harjani" <ritesh.list@gmail.com>
> To: "Dan Hor=C3=A1k" <dan@danny.cz>, "linuxppc-dev" <linuxppc-dev@lists.o=
zlabs.org>, "Gaurav Batra" <gbatra@linux.ibm.com>
> Cc: "amd-gfx" <amd-gfx@lists.freedesktop.org>, "Donet Tom" <donettom@linu=
x.ibm.com>
> Sent: Saturday, March 14, 2026 11:25:11 PM
> Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and =
newer

> Dan Hor=C3=A1k <dan@danny.cz> writes:
>=20
> +cc Gaurav,
>=20
>> Hi,
>>
>> starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
>> initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX41=
00)
>> with the following in the log
>>
>> ...
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 2=
56M
>> 0x000000FF00000000 - 0x000000FF0FFFFFFF
>=20
>                  ^^^^
> So looks like this is a PowerNV (Power9) machine.
>=20
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] D=
etected VRAM
>> RAM=3D4096M, BAR=3D4096M
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] R=
AM width
>> 128bits GDDR5
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: =
64-bit OK but
>> direct DMA is limited by 0
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:
>> dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M =
of VRAM
>> memory ready
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M=
 of GTT
>> memory ready.
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) f=
ailed to
>> allocate kernel bo
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] D=
ebug VRAM
>> access will use slowpath MM access
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] G=
ART: num cpu
>> pages 4096, num gpu pages 65536
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] P=
CIE GART of
>> 256M enabled (table at 0x000000F4FFF80000).
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) f=
ailed to
>> allocate kernel bo
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) c=
reate WB bo
>> failed
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:
>> amdgpu_device_wb_init failed -12
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:
>> amdgpu_device_ip_init failed
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal e=
rror during
>> GPU init
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishi=
ng device.
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe w=
ith driver
>> amdgpu failed with error -12
>> b=C5=99e 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm fi=
nalized
>> ...
>>
>> After some hints from Alex and bisecting and other investigation I have
>> found that
>> https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed50=
1af956dd0
>> is the culprit and reverting it makes amdgpu load (and work) again.
>=20
> Thanks for confirming this. Yes, this was recently added [1]
>=20
> [1]:
> https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.=
ibm.com/

As this patch appears to be primarily aimed at improving performance, and h=
as introduced a serious regression into the kernel for a large number of ac=
tive users of the PowerNV platform, I would kindly ask that it be reverted =
until it can be reworked not to break PowerNV support.  Bear in mind there =
are other devices that are 40 bit DMA limited, and they are also likely to =
break on Linux 7.0.

Thank you!

