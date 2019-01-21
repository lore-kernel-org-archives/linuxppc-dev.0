Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86128C2F421
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 15:55:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD96420823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD96420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jx2V4vCXzDqVH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 02:54:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jx0c5MKHzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 02:53:20 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id w25so20873991otm.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 07:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qe4qvfUSct3qbRBy94TjFwoY4JsWWV/7jTLSUh2s9Uc=;
 b=bXZr8qgm8LnaxU1laRTcePwwda09xvKVwTlGunKbghg09DrNQ0fg+fLUUaxVM+3ZbT
 4KVjnicm7rpPITkZIYxTPVOxdcTipuF36/xbE6Zzgq1cKPhfzBMLi4ESVXMG+ZGNY5W5
 MbN7snke2PK16QKXveXhwxkqv7uAY5Jroetd95xVvHCx8y1M0Kiw/t51W6BKpqX00C1k
 jTPzSYAU/A17otgGo6XBwGoW+1oboSE6IjUjHnaoIbmiLlSpdJTH8vdh8HwLFx422gut
 odu967HwWuH1GNoQEu3GPHzEGC211ZelcBIqcNb7rZLROaqV4UCHQYUUSqszZOlrovng
 OfiQ==
X-Gm-Message-State: AJcUukfcSG8U9fdu1r9tNJU4W135R0yPQRNI4qnrpN6l3yrpd3eg2NZ9
 /zajIeonW46Rg9AShqNH+w==
X-Google-Smtp-Source: ALg8bN5f8uRSnN1F9ByVmrjy2vqK+nLdhCS7+fHZfCp+KAEWucx2r/nFVsjPH3omA1OF1we0etGxLA==
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr20118154otf.30.1548085998676; 
 Mon, 21 Jan 2019 07:53:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w17sm5645274otk.12.2019.01.21.07.53.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:53:18 -0800 (PST)
Date: Mon, 21 Jan 2019 09:53:17 -0600
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 3/4] kbuild: add real-prereqs shorthand for
 $(filter-out FORCE,$^)
Message-ID: <20190121155317.GA7426@bogus>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
 <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Paul Burton <paul.burton@mips.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 07:02:43PM +0900, Masahiro Yamada wrote:
> In Kbuild, if_changed and friends must have FORCE as a prerequisite.
> 
> Hence, $(filter-out FORCE,$^) or $(filter-out $(PHONY),$^) is a common
> pattern to get the names of all the prerequisites except phony targets.
> 
> Add real-prereqs as a shorthand.
> 
> Note:
> We cannot replace $(filter %.o,$^) in cmd_link_multi-m because $^ may
> include auto-generated dependencies from the .*.cmd file when a single
> object module is changed into a multi object module. Refer to commit
> 69ea912fda74 ("kbuild: remove unneeded link_multi_deps"). I added some
> comment to avoid accidental breakage.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The patch context depends on some other ones.
> Please use 'git am -C1' if you want to test this
> on Linus' tree.
> 
> 
> Changes in v2:
>   - clean up arch/s390/boot/Makefile as well
> 
>  Documentation/devicetree/bindings/Makefile |  2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  arch/mips/boot/Makefile                    |  2 +-
>  arch/powerpc/boot/Makefile                 |  2 +-
>  arch/s390/boot/Makefile                    |  2 +-
>  arch/x86/realmode/rm/Makefile              |  3 +--
>  scripts/Kbuild.include                     |  4 ++++
>  scripts/Makefile.build                     |  9 ++++++---
>  scripts/Makefile.lib                       | 18 +++++++++---------
>  scripts/Makefile.modpost                   |  2 +-
>  9 files changed, 25 insertions(+), 19 deletions(-)
