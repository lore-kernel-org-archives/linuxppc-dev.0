Return-Path: <SRS0=enMn=3D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EA0C33CA9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 05:25:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8468D207E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 05:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOtEzdzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8468D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xf7J4vJhzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 16:25:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::244;
 helo=mail-lj1-x244.google.com; envelope-from=alexei.starovoitov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LOtEzdzO; dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xf5K0F0kzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 16:24:04 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id a13so12786351ljm.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2020 21:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xOe8cEwY/+ggWSrDf4teIOpCv6NdYHvbvkF1XKTEocs=;
 b=LOtEzdzO4P0gGkSt2/IoHR9VPfhIc06dybg249hC4fdFHKqGeaO8YxYjcto8GZcco6
 HX2osGkURrzyuWIDMmPjKH6D5ziJteWrS8nP6g8cIpsmxO3g6xKeyta0lNcLNXqImGgD
 C61+M2tHogtE/Tl8QJKImmlO9aOGwRqlrM74DKpVkzILRUlW2Xd3NWS6eUv1BHk1+oxv
 6Nz/uoqwbBG4FLBT0+T4Qdp3BXsK2hZReGH8l838Wpi3S4hKpZI+O6PN3yd+BgnhdqGt
 70U3ZQqzxQXRssZfvaI+neH8/KYxh+qMbdUQS85U95UhbJwfqdQbTlh4qpLZ9gE8FNO/
 Mnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xOe8cEwY/+ggWSrDf4teIOpCv6NdYHvbvkF1XKTEocs=;
 b=K8AB/+WTLeKVcLOskGZJBwS6J2wqaiTGKNCF0Gl7sX1+tSzGBJOGqK9vNpGttx3yQo
 L4Ou4f/TJfz/fdYBmE1l7QYzU6qDp/DFyjStb9fkIu2AhshD9sUA7a3CHE3Za7miXZhw
 sbfV9Gj49lOMJ1J2u5N3GVwC++IG9sci27oOdxsltqo9NmQd7nQfUftn+43hdKXKR9Xx
 VMRhubRieMx+B34Ti5T4+1xElrjI/ZXSQsYUFOll4giFJYgvN14renELMPoK/g0JEl8q
 Hv5R8iNNCjUloXmeCImHSdFiAsMET5EOJzIAEuKn+JCnOxWYVlHogWKNDmfktWHkKFK3
 41bA==
X-Gm-Message-State: APjAAAXaUKaHqnLAcd05imaUMWqZnpXCco6Nfkqt1TH6WmbemsM8WON3
 Hlof8rg1k3xaIQYBJYpdKN/45/0EvHguwfeK7XQ=
X-Google-Smtp-Source: APXvYqwLRjvJGcaSQN7MdhbIG50V/jBBlGzk43plCv5NgKLK461rA5mo+qyywlltVwtQwDPfSOV1dXQ6+y5OCmX7tEU=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr13271564ljj.116.1578979441504; 
 Mon, 13 Jan 2020 21:24:01 -0800 (PST)
MIME-Version: 1.0
References: <a367af4d-7267-2e94-74dc-2a2aac204080@ghiti.fr>
 <20191018105657.4584ec67@canb.auug.org.au>
 <20191028110257.6d6dba6e@canb.auug.org.au>
 <mhng-0daa1a90-2bed-4b2e-833e-02cd9c0aa73f@palmerdabbelt-glaptop>
 <d5d59f54-e391-3659-d4c0-eada50f88187@ghiti.fr>
 <CANXhq0pn+Nq6T5dNyJiB6xvmqTnPSzo8sVfqHhGyWUURY+1ydg@mail.gmail.com>
In-Reply-To: <CANXhq0pn+Nq6T5dNyJiB6xvmqTnPSzo8sVfqHhGyWUURY+1ydg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Jan 2020 21:23:50 -0800
Message-ID: <CAADnVQ+kbxpw7fxRZodTtE7AmEmRDgO9fcmMD8kKRssS8WJizA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
To: Zong Li <zong.li@sifive.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Alexandre Ghiti <alexandre@ghiti.fr>, Daniel Borkmann <daniel@iogearbox.net>,
 Network Development <netdev@vger.kernel.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Alexei Starovoitov <ast@kernel.org>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jan 12, 2020 at 8:33 PM Zong Li <zong.li@sifive.com> wrote:
>
> I'm not quite familiar with btf, so I have no idea why there are two
> weak symbols be added in 8580ac9404f6 ("bpf: Process in-kernel BTF")

I can explain what these weak symbols are for, but that won't change
the fact that compiler or linker are buggy. The weak symbols should work
in all cases and compiler should pick correct relocation.
In this case it sounds that compiler picked relative relocation and failed
to reach zero from that address.
