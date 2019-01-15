Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F9C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1563020657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1563020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fG5b13hmzDqXX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 03:29:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fG3X1YJBzDqM2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:28:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fG3W4fhnz8tP4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:28:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fG3W3pvjz9sDB; Wed, 16 Jan 2019 03:28:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fG3V7117z9sCs
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 03:28:06 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id i7so3561893qtj.10
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2019 08:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xSeskVB6AvGwb+Tn0yeqaqi4zwuJp8tDpKXdV/Q/mXk=;
 b=OHonzC/ZuvJwEkwogb3MNpm9rzLLmvo7A8ijovlQSC017PPpwroPNobFRVLqTtvgfA
 tufZDyj9w4enYNyqDTCgKMbGDtquvwz3HnOEFT8sSxADWgLGCs89Q4Hm2OH3KMB5OTz5
 z2XIia/cu9l7B2O8+e54gyF8TozMk1RZYzX3auVb+Uff6g77L/3AH4yKPVDB6VvQccWm
 k04N4YIdaeHy6gB/N/Z4aJvSbspZJI9igWAZlGxFz6eJf/b+qn9h7kEcfXy/mFEgSalQ
 jVbYEvwGizcwwSxN/56mQXmty/3VmWJ8q5EI47l3+9dp6fTsiLkIj/IKsecdY9+qvgdt
 61+Q==
X-Gm-Message-State: AJcUukce1XSo6crDyhyts1X7kgbt04HQjWHUCe5u2s7TtgWRm8bp9uM+
 R7xOdoA9KjItuXI0bUqgeMaVcKATcok8OuFgkHQ=
X-Google-Smtp-Source: ALg8bN55c0H9HoCXnqrQL6qSM74+Aup78EDsXh9m692ZxhZJ8mfl5z649GQ7lwNC56iVI8Ucei4NuuLx5oYc46XZv+s=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr3443505qtr.319.1547569684547; 
 Tue, 15 Jan 2019 08:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20190114113620.17558-1-mpe@ellerman.id.au>
In-Reply-To: <20190114113620.17558-1-mpe@ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 17:27:48 +0100
Message-ID: <CAK8P3a3PnbJ1Mr01HeRUzk+cfK4t-yok4YTJdNrBs6f==fVrnw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] powerpc/syscalls: Remove unused offset parameter
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
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 14, 2019 at 12:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> We never pass a value for offset, nor do we need to, so remove the
> offset logic.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

This change and the next three defeat the idea of having a shared script across
all architectures. Firoz has already posted patches to move the scripts to
scripts/syscalltbl.sh, and I think it's better to go on with those
patches, as they
also guarantee that the format of the files remains consistent across all
architectures.

     Arnd
