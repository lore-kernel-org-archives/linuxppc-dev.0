Return-Path: <linuxppc-dev+bounces-27447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C830EC88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 22:47:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkxwp0G5Yz2xk7;
	Wed, 16 Sep 2026 08:47:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.180.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789510899;
	cv=pass; b=B6nfU/5cWbw+5aIuTP86ofAH7JNvwDQEveEJjKp9hLyJTCjVwWctl+BhAUeVwclALx5bPAnae42ABhlvL341CR71TBFV7BE3+JoVLTFGPnM9lNKaQDqZewp8V8OWsw2nlMBJV9G/oho5mwZuOqs0GisQY+mwwOZsPlxL1a1IGulRg5Hp8HDXaba+taC91tScQXO8dtWQxhbHu1zw1MVTc+oZK4L0mZZMDsga3/fRMpnVW/xCXfHQ6hgSeVbiBcShznmL1tYbv6kOIUcBQgbB+w1ZaKaifHev7bWD3cdobu3/y7CtqCSjL8YO3f2TULmVgYEFnlMOLMYeD2n8VpGGmw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789510899; c=relaxed/relaxed;
	bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRDqml0ZizwxEvteVB+riLtDlHci3aYBSS/cvbi3NZA633Hj7Igm80KGvGsiojFYjixY/p8vZ2jF5ZTXRTN4Ozp4ToEc9n9sVMM9P4AhVVsBpwxqJE5e49JDUWXA0Uelgd5DQhQ/wcDnfT5sclrcrAXKoOFnYPXMiVX0eVwh08m/jIH5k/OZKYuOLvAUGBzGgFcRMLoltlXzjDUCL40Rh3r4lkZs2Ru0WfeCPNhXFFBJwxfJnkCB3FE3Z5O9cA1V0MRAoi15Bl3UYh/28VSX6Phr7NWuFk9Cc6fu4sohdRfOPvQZoA5Pz5AR0zupjK8oqE9P4QbFppzJGoysyiUe8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IV/k2TQj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DyhN+Faj; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=robin.clark@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IV/k2TQj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DyhN+Faj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=robin.clark@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkxM575fNz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 08:21:36 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ0iI079873
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqageh57d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4574f1cac98so10163376fac.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=Ncd5ojrXwymhHP8kHatj6llKScjIzZg5c6enI6XneLklyzuuxbKi7YA8QVa3RvI/l9
         Jbs5Els/9uYcykbqoU+HhOtDCljY65cQi7OdQVjUEOr945J9k99uY1T6t5gHMoEVjIO/
         BxMTy8EKSKA7Z5cDxg7LZyFyso4kxU3bz4dQLO4EK512QNEmLr8nfdG/UzNesTPdxKPS
         wMRjVo1z+g0vtrk2XWw210b78O3s/MdBqyPbngeigWHQgwasG3r/x/cBlQrBmWrOgBTw
         UW2t6W6pTkvBFsxe17X2heyd/MLCTi5aaPpPjT1sKSWKvuaEFIqMD82/hjpVPjOAO0Tb
         cDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=sf4QmnUrLchGXsTpBjGmkAvLkKd4R+W0M60rYqlJop8=;
        b=HQcOqJGZU7JYcFfzcEWLThGj4+KATuTIfnNm24QNdnD/IJvs55koCFrH+lpcK2b1oN
         xXcKaPiExWhgjw3cs0Hjq0YOW63u+1RGgPZ9lGKGRrX/kuHt/j3VzygCyv89M5eHgm3H
         B1KcTYOH7j+XHOU/ZqxkAinDzicO1HGhD4gG6dXvhY/DHpY9OJ7/H+5hv54W+IpXtIzL
         KXth/Vy31hI0Jgbb6bQfZnrX0zJflfwX+oA1GwhKFE8irGNDu0iLVpl4BANiiaRpnOAI
         By6SD/PPsAbTY+jCdhQ9dinqhrLQora3tx3TMNYAV+kmoPY5ER9d3I8gtckSahIwWFKr
         TuBQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=DyhN+Faj8pTt15en4nuwJlZkgy7eJJ3grUxvDWksanTKoMCfdDx9YmzRmlQ7yxQHGf
         H5hvc3NJ8POFaL1B52ml6lX7ZE7S+HvGs2T0dP9yFSwwDDlpCb5Ld7zx/iA0wNOyGtsk
         e2jkO8oWLJ6mjRf0cGIVjrt+lmfzPY7I+JLKM+pIKSgDN0u/jOYfEHeUomGYbfBBYll2
         mif12uMGcfddvzUmCmVq/ROkfCEHiGCAnHVWk4c3JCibtaJ/a9SdcSm9GyEdpVS8V6nF
         BbhtusNCl4+ob4Bn5/y8jXYM9NCXI7U6XMEeNCF6qsZ9SvosoU6GBj+Ip77Vmi+XMkvh
         BbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=XxD0prGNCvi6xW4UIMsNOsMj+f2mKo/CJHRPUZ3BaSD1slbD9wZeqwR1ngT3LXufK5
         MR0w1fpz94X6VdRyhLn11AsO4QhcNrPlnfFIKUWKC7RsOrfr6l2zWT1Y4xv7NKa8EbOR
         eiao41YSFpYiDqN7Zsu8xEtWfGjGZzg5jNxj/ouM8sT8vG/e+n4EQb0xigimztYNPk2f
         E1urKMtreY5E+meih5HQLAzux4Xc7eOYtPo2GUB3x/BzHSv6gcomjOYsbTsL7sJ6MJ8o
         Q26CKaYGpDekyE3F/8k0vdHlXoXMiBHDdYgd5fZi2hKs3Nm8iqbRdaAyI5BtaWoiHucM
         IbaQ==
X-Forwarded-Encrypted: i=1; AKwUvBycfZra87zHf7r/EZEttK4khMo3JPiLwO/3PIlCNXPCCmi7hB+T3o8A8xqWePLFPLW76bVfaLaALZ+Zd1E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nqFpHYXrcmvDcyJ0uEYVMLSdQVm4w+jiCfD89w05juUmFHpRvD
	Wk47TRuhWZdwmtoWptJ+fpW8J8Y35DFZG309D2jZ17wNRh3HGB4/bHmExF9OajzIPF6W+KHOuGW
	QZbW/aueFjTXFUX2mSrg1ManduuOSejxzEq8pRkbxKCY/sY3zJELI9CRV7xICL3ypQyc7rC7wSx
	cwceUjMXvZmcsmAjv+muZznjjMCzCv7S6hLh0R8jZsp7w=
X-Gm-Gg: AYBFou3yf3rUZVemqviuCLABwRYCAdiOBKlKWoXmzk0uR9zbGSx3AIsRiUYXHMkXFGS
	yMUO0b9ltu4kY9R2FUwkRvlt0fKVdxbSQEHDJBVi4H4x0JFWR/4BtptnahyING3inZ1oIKa4jFv
	+07tCa6a/AXybLdchVNfipWa6P6yzsja9T5cOd7MbtIFwx6QNH9NJKu8eK
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189778fac.2.1789510890871;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
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
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXynoo6MRaVUOf
 qK4RxhU2VWOn6QgL4fkfYEvGcTaiRS7JRSf2kgCNnZ3eoIi+xaVYj37e52FhwmHob35o7E5Up3M
 z+75UgPoxwYsLlRYu6WlBYDT0mHD7/Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX7AbuD7QcmFJR
 clw/wR344jlk+fK+k1CEd7AVvIMhZFu8aExZ0mqlZEKk+/tR8V2R3rIJcfDg/UhD+R7xAhIrgTt
 rHQZBKj+cWnAaNHClAJeq4FfFQl37zof29yskqcvzEdNshZ1QG2Z3XxstKopQ0wRrxcbEyiF67O
 eqDnOdE+kV7SX7ou4X0AJJEigcYOhRlM+dLjaMTVUUwpLH7PvysZdumut6joKmfoo6OB1aYlKaa
 YNtaJBmfn1L5aVazYvOvGLKh3YlES7Ef5yNnmflG8qO+RwQRmJFvuoUp51MsYLRFNuTK2NBSwhp
 z90Jgj2hRA+KCu5W8FXWuKsGu1DaZoPT8dEznoS7X4l/IO/1cyI0Vs8nnl7KHb1n1BWCOw5uD2y
 ofZWzokzzyp2wSmdBQbDVp9OhJs3x+imYAbx1Cg3Ig/7/cG/RdknWvW1/iz2B74EKbt4OXtKbsi
 mrPXAwOH//SnkdLZn9w==
X-Proofpoint-GUID: b1N4xGBuwGCCpR9U69JdeyWvNKgLc9CQ
X-Proofpoint-ORIG-GUID: b1N4xGBuwGCCpR9U69JdeyWvNKgLc9CQ
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R

