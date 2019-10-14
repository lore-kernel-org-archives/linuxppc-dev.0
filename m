Return-Path: <SRS0=PY1v=YH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D20C4CECE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 16:05:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFB320854
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 16:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FJRy+r/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFB320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sNh20KfBzDqtr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 03:05:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="FJRy+r/z"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sNds4nPtzDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2019 03:03:44 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id w3so3454037pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2019 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PrIaBUAl4Zs70Rvgh9Rg9A2Po5PtzGSRs+KQTItvpaE=;
 b=FJRy+r/zmSx0gTnh8nKk1MPaEhd9110EYn+G/+d4CpMIFscpk01MlyLHoHm5nqZ8ue
 CuEul5WqlGE6j/Va+TR2Yui1YW7GVr2UUJY+9m2nC1JwH5BH8lcHf9U9XardiDiGlOoi
 LaSSoXJLXvlrU+VQVXnO4lV/hae2O2+UoHmjSciqevrjzzXyJTp2d2+Y56+KcxRdCA6F
 7jmUcI5EAM3RTKj4p1Vaa6PDjBLCH1AKMAuK0N4y1tOSRYdnDC35vB3Mw9OlU6bctebd
 2KNziMABLbLEYIGJg85nQqt/hgKI9d4QgqspA9b11El3xetBfiuEmVrbjpRyRnhgYpcf
 TsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PrIaBUAl4Zs70Rvgh9Rg9A2Po5PtzGSRs+KQTItvpaE=;
 b=bYjOR2WNNTrlzPpl64QXL+2d/B7BSHDtz7k14BJlJ9YI6L93nu+ZWUcuonrOIMGnXe
 h9/LITUJXjTR5bkoGQPcfqTNoTXjA8g0SH7f3PUZ/+6I+ioRB1GxLkwwi5UD2AHn90wg
 DVBVx0TV27K5j8kZkGlqp7+K+qO5JaGzetE9WMOLwi017e5B9yLQEStEKbHWj2LnOrWR
 MhlLcJ/BGWmXjgRBWjN3rRA2uwpoUq2urUf9Su762bjMs8FBHS5nv7GXgjVaIKVU0QjK
 5/MbJtKASeGgeHVhyF8dDPzpxQ0aOv0Wx18nSu5uiAwymQ6rocjhB5FyRaGsvrGrnFOF
 tRqg==
X-Gm-Message-State: APjAAAVZwUbWEbKuWwC8zBCE8I3jN7eNQ+lrmgpUA55SWM+5OWp+Gkg/
 YxR7+L01xJpefS3bgEZHOS0uwEjcuxv2gm45yrmPfA==
X-Google-Smtp-Source: APXvYqzU0iN+S7UXYs1uP8WMChehRjsMrIbH3W7hJo7ZotpsfsIfMcdj3QGiw3CN0MtVD1Q6FSaHcabb11NtrnpteRQ=
X-Received: by 2002:a65:464b:: with SMTP id k11mr15727142pgr.263.1571069020713; 
 Mon, 14 Oct 2019 09:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com>
In-Reply-To: <20191014025101.18567-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 14 Oct 2019 09:03:29 -0700
Message-ID: <CAKwvOdm+xxo=Qm7N8CznSExFNL=GxoJ0Da4Td2D0zUYH4mOLvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] LLVM/Clang fixes for pseries_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 13, 2019 at 7:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> This series includes a set of fixes for LLVM/Clang when building
> pseries_defconfig. These have been floating around as standalone
> patches so I decided to gather them up as a series so it was easier
> to review/apply them.
>
> This has been broken for a bit now, it would be nice to get these
> reviewed and applied. Please let me know if I need to do anything
> to move these along.

+1, we've been carrying these out of tree for some time now, with this
series merged, we can get back to 0 out of tree patches.

>
> Previous versions:
>
> https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/
>
> Cheers,
> Nathan
>
>


-- 
Thanks,
~Nick Desaulniers
