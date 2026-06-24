Return-Path: <linuxppc-dev+bounces-22956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29348CDB470
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:39:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glYjV3dvHz2yYq;
	Wed, 24 Jun 2026 17:39:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782286766;
	cv=none; b=bkDCVfid98HX0EpV9duWxXWO67NhxCLxkwnbF52iYB7WlKnJDLGppcbjSj5EBXqq83QIXBE3+5LoGiv6yw6xA4j3nyOq6cVBvxH63T++6l33NABFQU9Uw3AeUYt3XvthxtYme7nk3ZYfdurrJGp7fkfHDi7fzA4u82ubSa8GxvWEUFPdUDtFBmuUEhTYg5DPonIKRWDtHer1jBSi0adfysLSabhXx2Ce26j+/ZupyBdc0Kqf1gcaDC1DJUBFeqCUo0RTHA3s+RMTWeLp4xFU2BOR1JVK3DjGa56HDLAf+T5NPOdOl4xOj/BjYysMt9xm/w7uWcFEJXHlPFNhT5dp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782286766; c=relaxed/relaxed;
	bh=gvM3AnF/Fta9TC5HFSPt1C3zMHdGGPapYSdvj0mcWC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K83QY5M7yPIohD8nTjv3HkhWE7EZxoI/icUIMaMRJGppEHhQUIoR4vNzjKJ1fUQ4S62YWfB/Tsi6s97BI/CdON/5DEAiWo4/gGrticreNLgddjP2/P/TKqEXzH0GB7iXrtLHzSZd+acdf3wQpzlscjvk5khBxbs2olt3ZjTfPKH0OrEy7pX/RoH6vUAVyiXpxZh0cLmao0WhO6C+5sBrlS70gfzfmqCjS1ylS2FcjUOImudmzMTAFpPklVb4l6y0yKYZOc5+TUEYHGll2FETWpnydOvxlrUTrAjMXcp8xPfP84RKb5I9SzeCcnKjwSpNW5UIhcE8TpTnlULRkMGgCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KDvyRCE+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KDvyRCE+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glYjT2MgVz2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 17:39:24 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c8d00e782d3so254118a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782286762; x=1782891562; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gvM3AnF/Fta9TC5HFSPt1C3zMHdGGPapYSdvj0mcWC4=;
        b=KDvyRCE+zOtxIyjv/tdK2thwpfG11cydzaefbfn4ZK1JopkUeOr4Qy9XwNHzLCczq4
         zdYE9TIjwcA5cpKkpVdsCku4fy+C+4ZHlehRgINOWxKCID6iHt9IFOPZwrxJ82+OBdlW
         NEsh0G2uf2TS9MEE9PyjX4txPbp+qUXzjUEnBsNnFeVO2iZC3PMNctD+J9NJo0OkFjEq
         2BaBeUmR4juxwMlHBR+NpFjJS914AUx37jsl0wgey/xUmq9fs78aTczQOZt/unylKLIr
         KssgLuVvuMilx5qy6eJld9Ehcju/rxMTyLXcvDEKJcRAJXR7UAWpIYbmeERFDvZE9hrm
         yeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286762; x=1782891562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvM3AnF/Fta9TC5HFSPt1C3zMHdGGPapYSdvj0mcWC4=;
        b=At7ddvhqumdqM+Lzk6i+5W6D6JnFw11wO8c+mPstUskGI+voK14eyKzfuXj44PEJu+
         DaneDUv2E0FnPaGLumWYK9vw8X5Yg4HN4VZKavs6djFPHsPvkRnoq3v7n6lilkKCxTYP
         FkMhlmpAZAZy1880bpX3cc5iy4XBTgx9r3GOYuWANpK8aYtCVOv84hS0B/jwRK0NfAiI
         olejR5PFK9LcCjzEgjy+ClqjDCYU/53Q+a9354qF4aiySKf3E3OkuBmiWOXEWO2hT3kA
         9sy/9QWnGqzcScLEBH8kHQj6xZIDb8NettwIolJVSok59VLwLrmLq9PBzYbz4lsQk5Ds
         mPeg==
X-Forwarded-Encrypted: i=1; AFNElJ/n6qvRU/Jj9S4rcLwGF2SAZPBxoDmWdxC5fO9be7JE9F+zREkrvH0ZuXTFXdyJJij2IlZ7kZrG3/xihZE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZ8OS4UoauYeQkNDPoOOopRlmD8OT/JPzSxwLEcT6uexLMjHIQ
	GcwP9MeTePnhN8/h2RnDiLWVRKm4nubqtBQXQuy15b3ICDhce8scfVjd
X-Gm-Gg: AfdE7cnAmS5U6ZVgsLUEomVyBTiQYjF48DFWVgLLHsPFwwAWMYSu8IKK1YqdYIZwgdq
	hJTyG1g+Q/khAeFRnNp7IYSlMg9xgX8oCcu/Ahakqovbnez0oKTnBy3KxFyLnC/FviLosB1t/j5
	K8nzbNX1j4eDvIVhpOCbT6SX66Dm7ZIMt5+AyPZJmcigFwc0ZHvXCHIriY3MpEXUyKD4pRZxbQh
	YZ8Cj4iEWYRmPmEwHF2mA2MPMYk53eRD+H9POepVtiPwvUfk8A5sLJvAIhqfWkQ1kRdoWMcCFVv
	NVKPgFrMN6R3oxe3Yk8swWlwouRpwUFuvX0wqr9lwyLbUdmIeZDYfgj0KL7X56i+WCR6o2exwKT
	kP8MsB/qiot0X20EaDuF3ji/3Gs2mM2c9UyNvUJpnEHiZqn4og80fN8s9ffCuzFEUmKZ8fTHwA/
	I2UvvHO/e0jbf6+zcnQp8A6cRNLRtuxEL/JTJTIFigK0liRa+rXRLms3ZbQeYgN4td7Qk=
X-Received: by 2002:a05:6a20:a124:b0:3b4:7c33:296b with SMTP id adf61e73a8af0-3bd2d154800mr2801301637.32.1782286762275;
        Wed, 24 Jun 2026 00:39:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5a1d8acsm11967749a12.23.2026.06.24.00.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:39:21 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:08:48 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, 
	thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, 
	macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, 
	kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com, 
	agordeev@linux.ibm.com, segher@kernel.crashing.org, mark.rutland@arm.com, 
	ryan.roberts@arm.com, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	peterz@infradead.org, kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <ajuJeRuNEtWn80b9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <ajpp-_XnbF3UTM_E@kunlun.suse.cz>
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
In-Reply-To: <ajpp-_XnbF3UTM_E@kunlun.suse.cz>

On Tue, Jun 23, 2026 at 01:11:55PM +0200, Michal Suchánek wrote:
> On Mon, Apr 27, 2026 at 05:57:34PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Adding support for the generic irq entry/exit handling for PowerPC. The
> > goal is to bring PowerPC in line with other architectures that already
> > use the common irq entry infrastructure, reducing duplicated code and
> > making it easier to share future changes in entry/exit paths.
> > 
> 
> Hello,
> 
> applying these patches on top of Linux 6.12 causes seccomp to return
> different error (ENNOSYS instead of EPERM) causing some seccomp tests to
> fail.
> 
> A minimal reporoducer is
> 
> podman run --rm --security-opt seccomp=<(echo '{"defaultAction":"SCMP_ACT_ALLOW","syscalls":[{"names":["mkdir"],"action":"SCMP_ACT_ERRNO"}]}') docker.io/library/alpine mkdir /tmp/test
> 
> This should produce 'Operation not permitted' but produces
> 'Function not implemented'.
> 
> Can you have a look?
> 
> Thanks
> 
> Michal
> 
> See also https://bugzilla.suse.com/show_bug.cgi?id=1268620
>
Hey Michal,

Thanks for reporting this. I'll take a look at this.

Regards,
Mukesh

