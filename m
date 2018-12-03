Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ABC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:27:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F3520851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="B+YL2/0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F3520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4381PY6JBxzDqhm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:27:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="B+YL2/0O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="B+YL2/0O"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4381LW42PnzDqmq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:25:07 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id y78so8493011qka.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ldKQF90m/G5zm935FjxHUATkIgg00xIePjtNug6i8VM=;
 b=B+YL2/0ONXElrrEPv2dMfJsRSfvxC482aR/7TaJ5jRjF5EnoxkVwIKxroOdRLq2Svs
 tA5yiTxcv6jxtfMI6y9+l/IuhVkhvxIsJiDLL1aZO7z6Dds5EyBfI68RynSISP17B6ER
 C9wwPPLmYIr04gEUy5xugL/KooJZB5bKHEtYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ldKQF90m/G5zm935FjxHUATkIgg00xIePjtNug6i8VM=;
 b=ABz54Q+9UBWndgZciSKYSh8hzjLE+H5p8vFilIG353EKL81o4jW/8X6f79uV9JZDoI
 k5+RNZQSmuBe+Ng2nHqP+qms1Oq5jHnpH6QJjeluNGEYaIt+ADeUSgM7V8wtkUWmqcRR
 LabSQreMvcj87IR8v89zw2FwkUzLyI+6OGHZ2X5PlNBMaWnPo1QnPwzMMm80WYI+KeAY
 8gXKbGB0kPoJ785z3UStW8AaFypAJfAbLgiR7zNSlzeWXHUNvlSw+UJayaQrC+ZQBfZ2
 C62GXDrodfhyttLuwAv7mgMlcCkkpiNcm+F/1ZfSxWgaOx984VwGgfAJ3DVE5xz7r+wQ
 sWVQ==
X-Gm-Message-State: AA+aEWZ2++V3iIgPOG4zu9tTkgPmiXCtWYI5NqKdz4XfKu05XGjox/EJ
 xV/+xInBoGVwVG9rqNdT2r1nQDPlZx5Un4XHAgc=
X-Google-Smtp-Source: AFSGD/XTrD8oOLM7poO8YPp6Ubx5mZflG66w7iTFCPTnyZRuC6G2j7hFiWR7G5gB+GZqd6+2S989N8o2DXOrmLC+89I=
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr16176709qkg.11.1543879504998; 
 Mon, 03 Dec 2018 15:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20180612081413.323d85b8@canb.auug.org.au>
 <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
 <87k1lgufiw.fsf@concordia.ellerman.id.au>
 <20181118112244.GD21617@bubble.grove.modra.org>
In-Reply-To: <20181118112244.GD21617@bubble.grove.modra.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 4 Dec 2018 09:54:53 +1030
Message-ID: <CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com>
Subject: Re: linux-next: build warnings from Linus' tree
To: Alan Modra <amodra@gmail.com>
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 18 Nov 2018 at 21:52, Alan Modra <amodra@gmail.com> wrote:
>
> On Wed, Nov 14, 2018 at 09:20:23PM +1100, Michael Ellerman wrote:
> > Joel Stanley <joel@jms.id.au> writes:
> > > Hello Alan,
> > >
> > > On Tue, 12 Jun 2018 at 07:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > >> Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
> > >> produced these warning:
> > >>
> > >> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> > >> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> > >> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
> > >>
> > >> This may just be because I have started building using the native Debian
> > >> gcc for the powerpc builds ...
> > >
> > > Do you know why we started creating these?
> >
> > It's controlled by the ld option --hash-style, which AFAICS still
> > defaults to sysv (generating .hash).
> >
> > But it seems gcc can be configured to have a different default, and at
> > least my native ppc64le toolchains are passing gnu, eg:
> >
> >  /usr/lib/gcc/powerpc64le-linux-gnu/6/collect2 -plugin
> >  /usr/lib/gcc/powerpc64le-linux-gnu/6/liblto_plugin.so
> >  -plugin-opt=/usr/lib/gcc/powerpc64le-linux-gnu/6/lto-wrapper
> >  -plugin-opt=-fresolution=/tmp/ccw1U2fF.res
> >  -plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s
> >  -plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc
> >  -plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr
> >  -V -shared -m elf64lppc
> >  --hash-style=gnu
> >  ^^^^^^^^^^^^^^^^
> >
> > So that's presumably why we're seeing it, some GCCs are configured to
> > use it.
> >
> > > If it's intentional, should we be putting including them in the same
> > > way as .hash sections?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/vmlinux.lds.S#n282
> > >
> > >   .hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
> >
> > That would presumably work.
> >
> > My question though is do we even need it?
> >
> > >From what I can see for it to be useful you need the section as well as
> > an entry in the dynamic section pointing at it, and we don't have a
> > dynamic section at all:
> >
> >   $ readelf -S vmlinux | grep gnu.hash
> >     [ 4] .gnu.hash         GNU_HASH         c000000000dbbdb0  00dcbdb0
> >   $ readelf -d vmlinux
> >
> >   There is no dynamic section in this file.
> >
> > Compare to the vdso:
> >
> > $ readelf -d arch/powerpc/kernel/vdso64/vdso64.so
> >
> > Dynamic section at offset 0x868 contains 12 entries:
> >   Tag        Type                         Name/Value
> >  0x000000000000000e (SONAME)             Library soname: [linux-vdso64.so.1]
> >  0x0000000000000004 (HASH)               0x120
> >  0x000000006ffffef5 (GNU_HASH)           0x170
> >  0x0000000000000005 (STRTAB)             0x320
> >  0x0000000000000006 (SYMTAB)             0x1d0
> >  0x000000000000000a (STRSZ)              269 (bytes)
> >  0x000000000000000b (SYMENT)             24 (bytes)
> >  0x0000000070000003 (PPC64_OPT)          0x0
> >  0x000000006ffffffc (VERDEF)             0x450
> >  0x000000006ffffffd (VERDEFNUM)          2
> >  0x000000006ffffff0 (VERSYM)             0x42e
> >  0x0000000000000000 (NULL)               0x0
> >
> >
> > So can't we just discard .gnu.hash? And in fact do we need .hash either?
> >
> > Actually arm64 discards the latter, and parisc discards both.
> >
> > Would still be good to hear from Alan or someone else who knows anything
> > about toolchain stuff, ie. not me :)
>
> .gnu.hash, like .hash, is used by glibc ld.so for dynamic symbol
> lookup.  I imagine you don't need either section in a kernel, so
> discarding both sounds reasonable.  Likely you could discard .interp
> and .dynstr too, and .dynsym when !CONFIG_PPC32.

Thanks for the digging Michael, and thanks Alan for clarifying the
details. I'll cook up a patch or two.

Cheers,

Joel
