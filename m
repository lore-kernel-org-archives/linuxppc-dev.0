Return-Path: <linuxppc-dev+bounces-18819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CE510A1E62
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL5J3K2vz2yS4;
	Thu, 26 Mar 2026 21:45:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774521908;
	cv=none; b=hcPpZNlvakth0/ZvpVfGF3srbx1LfGiULCYu8BoSf6/D2AVV8fMXLaTpJihmNolKDqS8paRnMkS3Ng0EDms8GEIN6fqbMxyT5QMaf7DSFzLPWlaS85VsxBNT2M/F/EykYvUqhR9KVMwv1MIZ/xo7EvyBwogDKjhwcULkNIcZ34FZkjZu/UQyALZQ74swzIQvCkxDgkJ2ez2TnVtB++mNEe0Wvyr2iJkZ5ze9kzRt9/jDQ9M5OV4K2fL8IQkOFrmHr52pcVjLlIN6qeG2OjGRR9kN7Lm+FEf488qsELargDIxKnptKrzOM3Np4VXgMSEa57sKLM0wRS0HJkXcj0Pe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774521908; c=relaxed/relaxed;
	bh=n0BAauGmagTbOENQ9IwerF9CZPUvOyYDalEidW4Zs5U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=WsCj9ZyDlAgNn9/bNZncov0fX3KN6DCa8cji0A2/q5zjzsar1ZxKO3FQkT4amDGf30DBVnia4E2NsI8I3syEWq9gd1jWR9f3OZmiKsNUiCDsLJUGeu8pkOCwaUO9hHTNp4MgzXITJyeviqA4vAZbG42bLoSGGevhdp3ozbUI79wvgmqo5cxtMDIquhqIyqxTkuf574wSIbHrQUK35FL9TRi/PbY0nzYSmo/gsp1HhkZ+QDRgi38d4Tk6q6CuGekx8EN1JlPQpo7X3FdigcmhctJZNHT4u1dZMaART3GAJTz7UakWQWM1Ok4XQOxkJ1DRUYHSYEjCTkEKbpyx3PdMQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eCSLl1KF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eCSLl1KF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL5G4wCHz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 21:45:05 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82a67ce6969so637603b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774521903; x=1775126703; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0BAauGmagTbOENQ9IwerF9CZPUvOyYDalEidW4Zs5U=;
        b=eCSLl1KFLKx5XUXqc3f9KnfJbn5+XbAGEO6DZJJInODmWPlQnNSHI7g3CIYMfgNtto
         7xJags/hMjKZN84nisPiNy73elc5MxgHdKPTuSzR63fm9EcibJxitVqsi7rfUSu6JJsw
         kR9nnWXEYEPaqYlIShQAErgx9Go1ypYQbxEwu6Ei3cZ5mGJuzbwhGgz3HdExjec0K8QV
         mptf+FcA61TJwNH9wXPqwqkAbfQWWNNmyUVZTsCr1s51px1FR/F6a4U/4EEOZSScSFtX
         Vvw+TT/Qnbz4qf/Y7Jp748L2JKpimGLI6VI4ihLgEF2TCYRTvSed3NZfZ849fpElTF2Y
         ARSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774521903; x=1775126703;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0BAauGmagTbOENQ9IwerF9CZPUvOyYDalEidW4Zs5U=;
        b=aCZ4MGSMvKpOm4HwxI/N1jYNUpdQIPZlfnXJRksauMlbY7c3f9ShqYK+vUM/6hu8Vd
         AcTnMmgf9VerxYU4tOdwOIr3f1rrRVWhM4/y/3R3s2bGB0bl1AzgCInWsvckIWranbG8
         qb9OKBkXoVCg9JA1JpeCILk/NhL9/TYWDFiz5msjSuyB/+HtSbpSXodigjwf4fkyoPiZ
         lTrCQUddjwUt3kNDj7iXqMdQdvoVxvsqSUhDRZsLstV02I/OvQY7KQ0UAjRkdT8BD4HD
         u08NsO2TuCcZsUZoK9dkCrkJI25Lu+PYJGtTQtx/hS/v5wEvkR5uDepVwV/n2Tf0ZnIr
         62dg==
X-Gm-Message-State: AOJu0YwdGlqVf/j4QOMtGLeWQ3bxSm2ROP9rCBz2jAa+ht4er2nKIZr8
	ad8hyfu/yZSyXRDkYA55o+ZAy8NP6utRuMnOYxpMdfjCGTo4fdlUnad5
X-Gm-Gg: ATEYQzyWEQu2eN8cEXteejo8p7TIRi/OTYtkWv51oiDOmkFxeJrvKzLh1cewdtvvqQR
	he092GDOqA4JZZOty/AzRz/+fzSGvqyWD5dRTNxRAia7rFrjk+EE8Y90ofhqwQvdfF14qa2M4sj
	lGA7aC8mqkLehup1QwLGkV4ZZ4aymkFVTsJUP4h0aehO+R8TBxOWEcPQgT2nD+Dp3ySUfCJxF9F
	Cc7es9MxzHbVj7fhd7m4P9LFq1Ht+vnkmYu+BceaHoefCPxmoBtRH6ZlBDJyHx+h4keba4/oxxR
	vjTLQ+hSCBUvcRsi3lFXXNYu4V1xR96UshKQ43kynVu7sxOhVllSriuaZzVLiSZJdPQ7Y4yKZje
	+XBxom61NfYkCppzpej2FfA9EUjs0QDtYTNEw66r/sBNJ4vp4VanON5axWz6y4fWHwGtCeTOxul
	7br7w1EP3K94J6CIeqru8Buw==
X-Received: by 2002:a05:6a00:3c8d:b0:82a:805a:7cc with SMTP id d2e1a72fcca58-82c6de6dc69mr6815122b3a.4.1774521903497;
        Thu, 26 Mar 2026 03:45:03 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3c2714sm2284862b3a.48.2026.03.26.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:45:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Gaurav Batra
 <gbatra@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
Date: Thu, 26 Mar 2026 16:08:35 +0530
Message-ID: <1ph6ooyc.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz> <1phlu3bs.ritesh.list@gmail.com> <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz> <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com> <5x6knm5q.ritesh.list@gmail.com> <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com> <341nolfr.ritesh.list@gmail.com> <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dan Horák <dan@danny.cz> writes:

> Hi Ritesh,
>
> On Wed, 25 Mar 2026 23:12:16 +0530
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>
>> Gaurav Batra <gbatra@linux.ibm.com> writes:
>> 
>> > Hello Ritesh
>> >
>> > I think, what you are proposing to add dev->bus_dma_limit in the check 
>> > might work. In the case of PowerNV, this is not set, but 
>> > dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
>> > was before.
>> >
>> > Also, since these both are set in LPAR mode, the current patch as-is 
>> > will work.
>> >
>> > Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
>> > not able to lay my hands on a PowerNV box yet.
>> >
>> 
>> It would be this diff then. Note, I have only compile tested it.
>> 
>> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
>> index 73e10bd4d56d..8b4de508d2eb 100644
>> --- a/arch/powerpc/kernel/dma-iommu.c
>> +++ b/arch/powerpc/kernel/dma-iommu.c
>> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>>  }
>>  bool arch_dma_alloc_direct(struct device *dev)
>>  {
>> -       if (dev->dma_ops_bypass)
>> +       if (dev->dma_ops_bypass && dev->bus_dma_limit)
>>                 return true;
>> 
>>         return false;
>> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
>> 
>>  bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>>  {
>> -       if (!dev->dma_ops_bypass)
>> +       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>>                 return false;
>> 
>>         return is_direct_handle(dev, dma_handle);
>
> this seems to fix the amdgpu initialization, full kernel log available
> as https://fedora.danny.cz/tmp/kernel-7.0-rc5.log
>
> Tested-by: Dan Horák <dan@danny.cz>
>

Thanks a lot Dan!

@Gaurav,
In that case, please feel free to take the diff and submit an official
patch (if you think this looks good for all cases). You might want to
test your previous usecase once, so that we don't see any new surprises
there :)

-ritesh

