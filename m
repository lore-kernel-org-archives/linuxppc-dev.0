Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C8AC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 00:10:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238DA20873
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 00:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238DA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43S17H0CTRzDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 11:10:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43S1523WlyzDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 11:08:54 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8F5CC29798;
 Sat, 29 Dec 2018 19:08:50 -0500 (EST)
Date: Sun, 30 Dec 2018 11:09:13 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
In-Reply-To: <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 29 Dec 2018, Arnd Bergmann wrote:

> I had a look at the complete series now, and I think this is a great 
> cleanup. I replied with a couple of minor comments that you may or may 
> not want to address first.
> 

Thanks for reviewing this.

> The one thing I would like to see resolved (I hope this doesn't bring 
> back an old discussion you had already concluded) is regarding the use 
> of a global exported structure of function pointers, as opposed to using 
> either directly exported functions (with a consistent interface) or a 
> boot-time selectable structure like dma_map_ops or ppc_md.
> 

If I understand correctly, /dev/nvram was made obsolete by the nvmem 
subsystem (?). If so, there won't be new /dev/nvram users, and the 
refactoring here only has to be sufficiently flexible to meet the needs of 
existing users.

I'm not opposed to exported functions in place of a singleton ops struct. 
Other things being equal I'm inclined toward the ops struct, perhaps 
because I like encapsulation or perhaps because I don't like excess 
generality. (That design decision was made years ago and I don't remember 
the reasoning.)

All the arch_nvram_ops structs that I've defined in these patches have the 
'const' properly:

const struct nvram_ops arch_nvram_ops = {
       .read_byte      = nvram_read_byte,
       .write_byte     = nvram_write_byte,
       .read           = nvram_read,
       .write          = nvram_write,
       .get_size       = nvram_get_size,
       .set_checksum   = nvram_set_checksum,
       .initialize     = nvram_initialize,
};
EXPORT_SYMBOL(arch_nvram_ops);

This is because there's no need to do any run-time reconfiguration.

Is a collection of exported functions a better fit here?

-- 

>     Arnd
> 
