Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C32C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 04:02:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05462072E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 04:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05462072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B9lL420ZczDqgD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 14:02:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B9lJ02YjXzDqVR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 14:00:47 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id E0F9D29AFB;
 Tue, 21 Jul 2020 00:00:37 -0400 (EDT)
Date: Tue, 21 Jul 2020 14:00:33 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 13/16] scripts/kallsyms: move ignored symbol types to
 is_ignored_symbol()
In-Reply-To: <CAK7LNATVDfHJG=+G6DqkR-vSyVhb8KmxcT0ae+ukdi_otthi8A@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2007211312530.8@nippy.intranet>
References: <20191123160444.11251-1-yamada.masahiro@socionext.com>
 <20191123160444.11251-14-yamada.masahiro@socionext.com>
 <alpine.LNX.2.23.453.2007201132240.8@nippy.intranet>
 <CAK7LNATVDfHJG=+G6DqkR-vSyVhb8KmxcT0ae+ukdi_otthi8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 20 Jul 2020, Masahiro Yamada wrote:

> 
> I got a similar report before.
> 
> I'd like to know whether or not
> this is the same issue as fixed by
> 7883a14339299773b2ce08dcfd97c63c199a9289
> 

The problem can be observed with 3d77e6a8804ab ("Linux 5.7").
So it appears that 7883a14339299 ("scripts/kallsyms: fix wrong 
kallsyms_relative_base") is not sufficient to fix it.

> 
> Does your problem happen on the latest kernel?

Unfortunately this cross compiler (gcc 4.6.4) is too old to build 
v5.8-rc1 or later. I will have to upgrade.

> Which version of binutils are you using?
> 

This toolchain uses binutils 2.22.

In case it helps,

$ powerpc-linux-gnu-nm -n vmlinux |head                  
         w mach_chrp
00000005 a LG_CACHELINE_BYTES
00000005 a LG_CACHELINE_BYTES
00000005 a LG_CACHELINE_BYTES
0000000c a Hash_bits
0000001f a CACHELINE_MASK
0000001f a CACHELINE_MASK
0000001f a CACHELINE_MASK
00000020 a CACHELINE_BYTES
00000020 a CACHELINE_BYTES
00000020 a CACHELINE_BYTES
00000020 a reg
0003ffc0 a Hash_msk
c0000000 T _start
c0000000 A _stext
c0000000 A _text
c000000c T __start
c0000054 t __after_mmu_off
c0000090 t turn_on_mmu
c00000c4 T __secondary_hold
c00000dc T __secondary_hold_spinloop
c00000e0 T __secondary_hold_acknowledge
c0000100 t Reset
