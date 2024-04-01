Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26368CD128A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2024 21:46:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V7l2s1l7Fz3vZ6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2024 08:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.176; helo=mail-pl1-f176.google.com; envelope-from=namhyung@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V7l2R1VFXz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2024 08:46:21 +1100 (AEDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e267238375so1620365ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2024 14:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712007979; x=1712612779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eB/PjIpA6PRw7tGHfJhncGiVnzYRJElpvidrTtCaB0=;
        b=Ugb4BlepvM95A5cu2Pxt+PcZvNza5zmMhJ3hKVuYXiWV4srF0ICBkrl8l9x1lSWZNj
         W4nsDahPsoWdF5HmFASaLcsfTTuW0iIrbRqutwSijqjoMgRKojoKKohhIVg7b6Y/S0Vp
         aarFYA8sfKAYG/AJHSNw/l4OTJRdyVkBHt9tIpUBgOBvHjTj3fyZ6ZejFgHWq5Imb5Jj
         haradEDnKFl2m5KpdsrXMZmtXJ9Egdo5WY0W3CObLKmeleQrC8P1kMIvXPGjVoK0OQAE
         WVLshYZv5zRtvMAVXS4H58wYrKxLz2ev014RhawtK8NPf5sBzjGQw42zzTkIHfXuUpHY
         +yHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY+TR8zRdCewzNcA0hegQ8yM2/W0OjpH+mEKbtYOaYpLEikUQ8+ifd86k3g12+YatS6+L3CxKMvTiF4s6pJG/6s7MqLu64C2ZHCPyRqQ==
X-Gm-Message-State: AOJu0YwCLK2cBcSfN7ePiP9yRfERgJ4YENsHnhz3TxaKCJZneMGbFI6b
	a19KaAMRc3+EMYlRJaCMK5oOGIU7c33X7nB+0nFLbGBi1O+UOIpHT5AlHe6Puc7YeHppIkz83sJ
	qMFJBHcrC1MCYqjCjs7tQCiVV/g2OZQeY
X-Google-Smtp-Source: AGHT+IHZSS65U3yKylWy9zgEH541y6gopyrRRzR5fRoL3UcYfDXqDiS18mdg9l+m2sKDnC6htPKZsXYECnphk10b6Lo=
X-Received: by 2002:a17:903:22cf:b0:1e0:73d:9172 with SMTP id
 y15-20020a17090322cf00b001e0073d9172mr21078439plg.23.1712007978835; Mon, 01
 Apr 2024 14:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
 <20240309072513.9418-4-atrajeev@linux.vnet.ibm.com> <4072f03b-a8a2-5611-901e-bc16e97c3fe6@loongson.cn>
In-Reply-To: <4072f03b-a8a2-5611-901e-bc16e97c3fe6@loongson.cn>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 14:46:07 -0700
Message-ID: <CAM9d7cg1eKQByUcDCbF25Bd8vM2ut5st1zPDzMQEi+nTC8cpsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/perf/arch/powerc: Add get_arch_regnum for powerpc
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: irogers@google.com, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, kjain@linux.ibm.com, adrian.hunter@intel.com, acme@kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, jolsa@kernel.org, disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On Tue, Mar 26, 2024 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Hi Athira and Namhyung,
>
> On 03/09/2024 03:25 PM, Athira Rajeev wrote:
> > The function get_dwarf_regnum() returns a DWARF register number
> > from a register name string. This calls arch specific function
> > get_arch_regnum to return register number for corresponding arch.
> > Add mappings for register name to register number in powerpc code:
> > arch/powerpc/util/dwarf-regs.c
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > ---
> >  tools/perf/arch/powerpc/util/dwarf-regs.c | 29 +++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>
> I found commit 3eee606757ad ("perf dwarf-regs: Add get_dwarf_regnum()")
> for x86, would you be able to share how to test these changes? What is
> the difference with and without the patches?

Hmm.. I guess it won't work well without the patch.  This is
needed to map register numbers (from objdump) to what
DWARF can understand (IOW they use different numbers).

Thanks,
Namhyung
