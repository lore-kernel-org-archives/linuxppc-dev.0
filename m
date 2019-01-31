Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8622C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 15:25:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6775220869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsyLjm/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6775220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43r3vV5xmlzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 02:25:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c41; helo=mail-yw1-xc41.google.com;
 envelope-from=jcmvbkbc@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZsyLjm/2"; 
 dkim-atps=neutral
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43r3sM6XW3zDqbB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 02:23:16 +1100 (AEDT)
Received: by mail-yw1-xc41.google.com with SMTP id p65so1423567ywe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FEGsjMX0dp8RIKABY7YbpDek7VAiBMQ5lvDJ9kXcOns=;
 b=ZsyLjm/2i8qflJj65Hki7ZjvX/p5TsVDbFLDy7tSrA+zq8/rmQhKZ5yU4Bl9kcqNBG
 CY9HOGBpR1srhF7u4H9mYJcYyDuPjhrBD47VmrCaaN1SX2ExDlH0GQYz6bDNKGIeER/N
 DF6b1r3SOqJa9XC74nY0HVQaA3twQDl0/0usSyHts9dncP4v3Vg8voOJ8+jyAG7v0bUA
 B6+B6kriQluxGxRJeHVpFuS3YlZmyHiGWyoenK6JbziwuNQ+Alt9qkijGVE2SEtb3tDq
 9pqtKFQFBYtBJG7fxZ1NDZFxq1qNSGZFFtsmGMF43OGLzTtwPolkWURu5aoBZtbx+lxK
 2bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FEGsjMX0dp8RIKABY7YbpDek7VAiBMQ5lvDJ9kXcOns=;
 b=PlyB0HYwedt2lSrOfPkgf93Wz+hJYTPpDZFL16VsrznUi/kyG5O5l22LON6piQC/z8
 YPkl54mRFK14qkVWZZ5kNCrlrFnKQ5QOGE7xd6EL1j7QBYcAT4FreNJITz9hbUT0PYip
 6/71+jTai1XfP6+tDTg7V52Ej7mCNNLX11A9H2Bf37HBz/UoAetwGpSmw8hEHoWT0oKT
 vZGroYVDEXwz7z5n+m/vTOk8IcN2oH1T5XhUiyYB4X25zGCFuwsVxdQ5NfhFq2kXpVzt
 NddWo1y9uXiuqdDEgHMQ2rnosJaUH/I5TuESS7R0AK3ueFktPmzG7P1QlbcXWujZOahf
 Vhew==
X-Gm-Message-State: AJcUukemvwVsgOFbdqmCeuwddPr1nTk1iiSiMh8rBddEmo76h+iSeiTk
 qRpK6BmM92t+r2kIV85mh75D+QNbZODLo6KYQ6c=
X-Google-Smtp-Source: ALg8bN6VKPBr8Isk9xxBy7E56UDJe1SXYMfF3Ab4zY9Hf3yytlNnD8xLHhr8GacDmx2eMD/3OVRnEkNlKLgL+Q7RzmY=
X-Received: by 2002:a81:5b07:: with SMTP id p7mr34659637ywb.468.1548948194353; 
 Thu, 31 Jan 2019 07:23:14 -0800 (PST)
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 31 Jan 2019 07:23:02 -0800
Message-ID: <CAMo8BfKhjwimXrGCcPjmS0+w8o6yW=ohG-hZ7caWnGpPSF6qJA@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>
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
Cc: Rich Felker <dalias@libc.org>,
 "open list:IA64 \(Itanium\) PL..." <linux-ia64@vger.kernel.org>,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, Guo Ren <guoren@kernel.org>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-s390 <linux-s390@vger.kernel.org>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 linux-um@lists.infradead.org,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 12:06 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
>
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
>
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> Acked-by: Paul Burton <paul.burton@mips.com>         # MIPS
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> ---
>  arch/xtensa/mm/kasan_init.c               |  4 ++++
>  arch/xtensa/mm/mmu.c                      |  3 +++

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
