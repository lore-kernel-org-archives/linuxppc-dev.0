Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53751C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 21:38:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF6520869
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 21:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY50ghsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF6520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YsJ01ygKzF3Qm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 08:38:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RY50ghsx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RY50ghsx"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YsFH22S6zF3Nw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 08:36:03 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id q19-v6so6839582pll.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bDjrAoUpXFo6BGFoyEt5TRYalMYDfkiGz3Z0CU2hn4I=;
 b=RY50ghsxGXWnkCBURVulnAECoZ0eZ4GsQauGKXOBRI9p1KdJlThLiYihNT5HUwgJrp
 OQGvyUPPi3YteoFLYRTzROnMRyy95rClR197lxJOWQ/SjKuya/ruSwl/0nAKd8wrRctt
 zRHEjb8/5t3CBzuHmUHSUXN3ZN3kdmyLFY8sPJbCJa5QowxvuQxNeAYQeu747rMKLyVi
 cXupxrZduxQbFICT6zcF6A30zbW5/pEdHo9vAX7r0ya5XpnVqJUR7e1K3NNSH59/x1Lh
 sN0Z72xcJ1kPLOn5RN8dt18GXbyqMDoUpLd44dLzfEFAou9QXh84MUQbI6hzEhiv/3Pb
 LJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=bDjrAoUpXFo6BGFoyEt5TRYalMYDfkiGz3Z0CU2hn4I=;
 b=bhp2KaxhveTcjH5FellEYWC7xBYpi37BVJuXf6cDk7DJUsnryc0bIwR2qAytEHuwCI
 5Wj0stkP13Pclc6vIOUHfs3gPr45Qv+6u+Ka9MqqHPEtt9rLph6xD7CQTKzbNov3TJjl
 PLHgrs6aUVkqlGmXVZvolBoEX4ACJtgGxZj3xEYD40HA4z+/cEw/3heJikKS7LH7koyF
 PNVL8Q6I1WBiy1uxraWtbuhDZ1/idOMNEnERvNzWpx2MFCP638+YTVwQ3vvKsPRd3qbd
 EsE1qrcx/hTx4p2Oz/lXawK9UttXNdCQUCJIy5kPwKkjhCs/4DIA14+ZHE09U+R8ldky
 npqA==
X-Gm-Message-State: ABuFfoh1a0pD7BD8QYIUws4QjQpePokAZJuZVd3hr0ZJbi4sVjuxbUQF
 7AuRpnoTvaZ9DtUbcXhDxuI=
X-Google-Smtp-Source: ACcGV62gmT1qWSh98m4bT1c91ESUVze3pk9p691kIB2YKoHOVzTkxlzN977v0lIxUJLKCYkclv8kig==
X-Received: by 2002:a17:902:70c3:: with SMTP id
 l3-v6mr19361448plt.125.1539639360981; 
 Mon, 15 Oct 2018 14:36:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net.
 [108.223.40.66])
 by smtp.gmail.com with ESMTPSA id j19-v6sm13213842pfi.137.2018.10.15.14.35.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 14:36:00 -0700 (PDT)
Date: Mon, 15 Oct 2018 14:35:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015213559.GA7976@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015193914.GA9881@roeck-us.net>
 <20181016073359.3fa7bb32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016073359.3fa7bb32@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 16, 2018 at 07:33:59AM +1100, Stephen Rothwell wrote:
> Hi Guenter,
> 
> [Again, just cc'ing the PPC folks]
> 
> On Mon, 15 Oct 2018 12:39:14 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20181012:
> > > 
> > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > >   
> > 
> > Bisect log:
> > 
> > # bad: [774ea0551a2966c8fc29a6f675c3e28c5c6fa586] Add linux-next specific files for 20181012
> > # good: [0238df646e6224016a45505d2c111a24669ebe21] Linux 4.19-rc7
> > git bisect start 'HEAD' 'v4.19-rc7'
> > # good: [dfbf78faefa3c26d94208398e62bf25ea798e7f2] Merge remote-tracking branch 'spi-nor/spi-nor/next'
> > git bisect good dfbf78faefa3c26d94208398e62bf25ea798e7f2
> > # good: [3f296bb430327676912966c56d2f078f74e6b4ab] Merge remote-tracking branch 'tip/auto-latest'
> > git bisect good 3f296bb430327676912966c56d2f078f74e6b4ab
> > # good: [056ff0c45d1780f7bac1b54bd4160647efc500ad] Merge remote-tracking branch 'staging/staging-next'
> > git bisect good 056ff0c45d1780f7bac1b54bd4160647efc500ad
> > # good: [d7946b50c21a7d88af6c8e88d976ba3dfca651cc] Merge remote-tracking branch 'pinctrl/for-next'
> > git bisect good d7946b50c21a7d88af6c8e88d976ba3dfca651cc
> > # good: [72b5ca3121d5352fbb8fe3e1abaa86748205c0cb] Merge remote-tracking branch 'xarray/xarray'
> > git bisect good 72b5ca3121d5352fbb8fe3e1abaa86748205c0cb
> > # good: [e3895cf23a25da6dea2c8e986d4f6c24fafe5448] hugetlb: introduce generic version of prepare_hugepage_range
> > git bisect good e3895cf23a25da6dea2c8e986d4f6c24fafe5448
> > # good: [627f8833ac26e66d4b50676a0251499474bb4ee4] reiserfs: propagate errors from fill_with_dentries() properly
> > git bisect good 627f8833ac26e66d4b50676a0251499474bb4ee4
> > # good: [e38910adf47ba1d0b5a5a573cc26bde1ec533147] memblock: replace alloc_bootmem_pages_node with memblock_alloc_node
> > git bisect good e38910adf47ba1d0b5a5a573cc26bde1ec533147
> > # bad: [f89bdd2c52666d9da4bf4ef3a97a7188586ba0fb] dma-direct: fix up for the removal of linux/bootmem.h
> > git bisect bad f89bdd2c52666d9da4bf4ef3a97a7188586ba0fb
> > # good: [3108d998dfc36eb7f6b7f2917fc561258f742094] mm: nobootmem: remove bootmem allocation APIs
> > git bisect good 3108d998dfc36eb7f6b7f2917fc561258f742094
> > # good: [1f94dacb1d0ed0d1068b89ad867a198d3eca7bf2] memblock: rename __free_pages_bootmem to memblock_free_pages
> > git bisect good 1f94dacb1d0ed0d1068b89ad867a198d3eca7bf2
> > # good: [c3954ade0c1b499ae587f3edb813876216212836] memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
> > git bisect good c3954ade0c1b499ae587f3edb813876216212836
> > # bad: [cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6] mm: remove include/linux/bootmem.h
> > git bisect bad cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6
> > # first bad commit: [cde1c7f7e92aef241f1c1a09a4d1f1f06fd565b6] mm: remove include/linux/bootmem.h
> > 
> > Reverting this patch together with its fix-up "powerpc: fix up for removal of
> > linux/bootmem.h" fixes the problem. This also fixes the traceback seen with all
> > other ppc64 images.
> > 
> > Guenter
> 
> Thanks for this ... though a strange result as those patches were in
> next-20181012 as well, so I wonder what else changed.
> 
Quite simple - the bisect is wrong. For some reason I started with
next-20181012 (which was fine), not 20181015 (which is broken).
Repeating it now. Sorry for the confusion.

Guenter
