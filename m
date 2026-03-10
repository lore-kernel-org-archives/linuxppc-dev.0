Return-Path: <linuxppc-dev+bounces-17940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFAFCC9A7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:13:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVHV811vSz3bjb;
	Tue, 10 Mar 2026 13:13:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773108800;
	cv=none; b=TviNR4CchNsLsppbbMvSzCtFuGY4kAGH/kTtyQ98fMhRsx5lsDn10JAGfuamIEB6IEthrE6d3pQyWMSV+DIccHVhN+RfOX/aGWu/3EXQzlBsWiJr6lnmMMxEd4jERbOmsprRamMwHlh3vSWp4C9qDdpBxFIMe652dKlvTsZ27Bd12g7cVIN18QleLtINPwSmiq6Ded03dgtFfUTKiugLmS4iuTKjbxPHRDMIjs6H2yjVxmMkWtanU5vGwGyc4j2tk51Yd8pLy8nKgf4URm3wJxYrrBOQ7lWKMj7gGPeu0Jk9GhzkyU8BmQXccrsGw0phJEQfJ+hFvAooEsC5Y5A6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773108800; c=relaxed/relaxed;
	bh=aCV6AtrZqJOTKDcJoDwJvJmch/wh+FICVhihLLbm0gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L5cC0+Q9ozH8XDcBfXo6LCrKz+Uc2VPd80mBbIeaoBzFOMrpqz/3YM6vNSFuN/YT3nV0KS4U5eI8lQLGn5Rfoh1Dc8naLTfWQ/AXnHSb9/kWyr9DQXH/MK2y7KLkvVsEXgagTW7Tx8ndplOelkstmmGsSWe02JEnpzUiz+gsswOKCQvbk1waneUB3M/C0DPuv1X3zXB3mHjQaXenCn+4RI1O6yTcgCvkkjqRAoG3oaanqxCjIoRieaWzICHmyNvmTEJatwR5kqzuJaTLRxBAplhJPujyWG+lEGV3yo4aA8Bj4ImBEL4jK9OyrRFU10djPBgbyDhAbah0MShcbv+heA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9eTEjCJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZ+Djjx2; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9eTEjCJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZ+Djjx2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVHV661XDz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 13:13:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773108793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCV6AtrZqJOTKDcJoDwJvJmch/wh+FICVhihLLbm0gc=;
	b=Q9eTEjCJGTSIR0My6f7xooqePX+H8yKQJyD5pdHcxG5uhW2ivc2YpDBI2SBKcNBshPl83h
	YhaIRIT6ThlcFyLSP3yYbWlIYswr6swq3sbC301fIB2UWQsKrxN0HpZXZxH4ETZ1lAOjyM
	jUbZJ0DAmocdFYa9OQ4uQ28oQJNysbc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773108794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCV6AtrZqJOTKDcJoDwJvJmch/wh+FICVhihLLbm0gc=;
	b=FZ+Djjx2MvtxE0MDxukJy3KEic915C4rR/cL8LEZroceX2hCZKJv6BsQhrHF0Jg4aj67+9
	LGzzll6vV43ad2eJjsYkk6h8NVAuynbaOHosf3FZS7TRrsC9JaXEBOvjDAxNy0MjByG4xn
	c5/t1eekWyC5FvthX+RYL0y1aLSP35Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-0W-wL2VWPKuFFCHVPIHhug-1; Mon,
 09 Mar 2026 22:13:09 -0400
X-MC-Unique: 0W-wL2VWPKuFFCHVPIHhug-1
X-Mimecast-MFC-AGG-ID: 0W-wL2VWPKuFFCHVPIHhug_1773108784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 810F31956050;
	Tue, 10 Mar 2026 02:13:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C06ED1800761;
	Tue, 10 Mar 2026 02:12:54 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:12:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	rdunlap@infradead.org, pmladek@suse.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, paulmck@kernel.org, lirongqing@baidu.com,
	fvdl@google.com, rppt@kernel.org, ardb@kernel.org,
	leitao@debian.org, sourabhjain@linux.ibm.com, jbohac@suse.cz,
	cfsworks@gmail.com, osandov@fb.com, tangyouling@kylinos.cn,
	ritesh.list@gmail.com, hbathini@linux.ibm.com,
	eajames@linux.ibm.com, songshuaishuai@tinylab.org,
	kevin.brodsky@arm.com, samuel.holland@sifive.com,
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
	liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, brgerst@gmail.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <aa9-HYdKT8MhAjhi@MiWiFi-R3L-srv>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
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
In-Reply-To: <20260302035315.3892241-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NbyB9Tn8gbv9aJesOz8j5ByqmUk984yeFnXYkOLqVO4_1773108784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 03/02/26 at 11:53am, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Rebased on v7.0-rc1.
> 
> Basic second kernel boot test were performed on QEMU platforms for x86,
> ARM64, and RISC-V architectures with the following parameters:
> 
> 	"cma=256M crashkernel=256M crashkernel=64M,cma"

The whole series looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>


