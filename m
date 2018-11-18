Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B3C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 11:25:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F452080F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 11:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjoJRIuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F452080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yV5J58nFzF1Rb
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 22:25:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RjoJRIuA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=amodra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RjoJRIuA"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yV240jlKzF3Vr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 22:22:51 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id u6so1013272pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 03:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eVIt+uod0BkmtqD5fjD06oV3zi3wkuZnxZRHYBitEcI=;
 b=RjoJRIuAQC4sI8IzHAwAz/PSmy97Jauxc2AfKYMO+dB6U32pca7vUrkelbEERCEJF1
 lekjG4ZFXXe0VG9n8+RuWtoaJBonMVDWU1d5/+kLTBYAlPqqa29PeSHewPKGOLfYsN27
 UfYRfyB8UPSPaUCdVks1ekmIMFh1XUWCGLz19P5edXYV1oObqawie4pmFHPnn1Wa/K8g
 RK6oDlTClz5z4VV+90ZH41j8mgkzrvPgqzOxMoSSmKwv9zS2Y01RFV7mzjVEaJQJnWpJ
 cJjkeCFoBw5YP+d4DR5biQMPu7ILMJSPbeT9LIc3j4ogQVshwueiQKD+rmMutuxzbxPK
 7llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eVIt+uod0BkmtqD5fjD06oV3zi3wkuZnxZRHYBitEcI=;
 b=JDCylFG/IzKPMF67YVTy9chaCyt1VvEQgRdZUp3cx34rfRJJzRzoUWa94EWb3Ggvr7
 llkvxzCEKE1AWyC+4rd/tg4UuXaLKQ42QdVUpCsutpCYxscycn++8tkayBQYeoBiVHUq
 dfAUIRgUbBfaUu3Wln+x1yxW00MYKdq86pBwcSlTao8COuA3KsR3vDcAzlzcXCZ9iEqD
 97KRilkGZDBxScF+tnhbiSkR4l2i+1BuWrH2Dta+QftiqhLILppUeOH5tuIxS/WEAxrB
 7hXabmPPIve2hXWgLWltqW/FGiem+ebW4kD9AypLbRWu9ADSsKmgpTOjQn/rzCcEjiWl
 vU7Q==
X-Gm-Message-State: AGRZ1gI0HHSaYLSoTmnXGiaTjUkj6+I+I4mFImjni/WY0btTa0+NRFtg
 jbshzfXQnibTuCcSZbsdG2o=
X-Google-Smtp-Source: AJdET5dCOURk+Kjd7LMbYSjWLm3N+tpgF+0yZqFy0BEGz8tAFu5qd2j6uoDNzfdswqmVuUOlo5EfMQ==
X-Received: by 2002:a62:f54f:: with SMTP id n76mr18565573pfh.59.1542540169376; 
 Sun, 18 Nov 2018 03:22:49 -0800 (PST)
Received: from bubble.grove.modra.org ([58.175.241.133])
 by smtp.gmail.com with ESMTPSA id b62-v6sm41907018pfa.159.2018.11.18.03.22.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 18 Nov 2018 03:22:48 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
 id 8D09580D2B; Sun, 18 Nov 2018 21:52:44 +1030 (ACDT)
Date: Sun, 18 Nov 2018 21:52:44 +1030
From: Alan Modra <amodra@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build warnings from Linus' tree
Message-ID: <20181118112244.GD21617@bubble.grove.modra.org>
References: <20180612081413.323d85b8@canb.auug.org.au>
 <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
 <87k1lgufiw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1lgufiw.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 14, 2018 at 09:20:23PM +1100, Michael Ellerman wrote:
> Joel Stanley <joel@jms.id.au> writes:
> > Hello Alan,
> >
> > On Tue, 12 Jun 2018 at 07:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> >> Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
> >> produced these warning:
> >>
> >> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> >> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> >> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> >>
> >> This may just be because I have started building using the native Debian
> >> gcc for the powerpc builds ...
> >
> > Do you know why we started creating these?
> 
> It's controlled by the ld option --hash-style, which AFAICS still
> defaults to sysv (generating .hash).
> 
> But it seems gcc can be configured to have a different default, and at
> least my native ppc64le toolchains are passing gnu, eg:
> 
>  /usr/lib/gcc/powerpc64le-linux-gnu/6/collect2 -plugin
>  /usr/lib/gcc/powerpc64le-linux-gnu/6/liblto_plugin.so
>  -plugin-opt=/usr/lib/gcc/powerpc64le-linux-gnu/6/lto-wrapper
>  -plugin-opt=-fresolution=/tmp/ccw1U2fF.res
>  -plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s
>  -plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc
>  -plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr
>  -V -shared -m elf64lppc
>  --hash-style=gnu
>  ^^^^^^^^^^^^^^^^
> 
> So that's presumably why we're seeing it, some GCCs are configured to
> use it.
> 
> > If it's intentional, should we be putting including them in the same
> > way as .hash sections?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/vmlinux.lds.S#n282
> >
> >   .hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
> 
> That would presumably work.
> 
> My question though is do we even need it?
> 
> >From what I can see for it to be useful you need the section as well as
> an entry in the dynamic section pointing at it, and we don't have a
> dynamic section at all:
> 
>   $ readelf -S vmlinux | grep gnu.hash
>     [ 4] .gnu.hash         GNU_HASH         c000000000dbbdb0  00dcbdb0
>   $ readelf -d vmlinux
>   
>   There is no dynamic section in this file.
> 
> Compare to the vdso:
> 
> $ readelf -d arch/powerpc/kernel/vdso64/vdso64.so
> 
> Dynamic section at offset 0x868 contains 12 entries:
>   Tag        Type                         Name/Value
>  0x000000000000000e (SONAME)             Library soname: [linux-vdso64.so.1]
>  0x0000000000000004 (HASH)               0x120
>  0x000000006ffffef5 (GNU_HASH)           0x170
>  0x0000000000000005 (STRTAB)             0x320
>  0x0000000000000006 (SYMTAB)             0x1d0
>  0x000000000000000a (STRSZ)              269 (bytes)
>  0x000000000000000b (SYMENT)             24 (bytes)
>  0x0000000070000003 (PPC64_OPT)          0x0
>  0x000000006ffffffc (VERDEF)             0x450
>  0x000000006ffffffd (VERDEFNUM)          2
>  0x000000006ffffff0 (VERSYM)             0x42e
>  0x0000000000000000 (NULL)               0x0
> 
> 
> So can't we just discard .gnu.hash? And in fact do we need .hash either?
> 
> Actually arm64 discards the latter, and parisc discards both.
> 
> Would still be good to hear from Alan or someone else who knows anything
> about toolchain stuff, ie. not me :)

.gnu.hash, like .hash, is used by glibc ld.so for dynamic symbol
lookup.  I imagine you don't need either section in a kernel, so
discarding both sounds reasonable.  Likely you could discard .interp
and .dynstr too, and .dynsym when !CONFIG_PPC32.

-- 
Alan Modra
Australia Development Lab, IBM
