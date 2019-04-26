Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3652FC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 17:08:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868F6208CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 17:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868F6208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rL9l1Fl8zDqXb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 03:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rL822rXWzDqXN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 03:07:13 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3QH71Zl020372;
 Fri, 26 Apr 2019 12:07:01 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x3QH70Zw020369;
 Fri, 26 Apr 2019 12:07:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 26 Apr 2019 12:07:00 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Subject: Re: BUG: crash in __tlb_remove_page_size with STRICT_KERNEL_RWX on
 BOOK3S_32
Message-ID: <20190426170700.GD8599@gate.crashing.org>
References: <87pnp9mknl.fsf@depni.sinp.msu.ru>
 <db886597-8867-93e6-a507-6da4963ce0bd@c-s.fr>
 <878svwn85h.fsf@depni.sinp.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878svwn85h.fsf@depni.sinp.msu.ru>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 26, 2019 at 05:38:50PM +0300, Serge Belyshev wrote:
> ---[ Instruction Block Address Translation ]---
> 0: 0xc0000000-0xc07fffff 0x00000000 Kernel EXEC coherent 
> 1: 0xc0800000-0xc087ffff 0x00800000 Kernel EXEC coherent 
> 2:         -
> 3:         -
> 4:         -
> 5:         -
> 6:         -
> 7:         -
> 
> ---[ Data Block Address Translation ]---
> 0: 0xc0000000-0xc07fffff 0x00000000 Kernel RO coherent 
> 1: 0xc0800000-0xc0bfffff 0x00800000 Kernel RO coherent 
> 2: 0xc0c00000-0xc13fffff 0x00c00000 Kernel RW coherent 
> 3: 0xc1400000-0xc23fffff 0x01400000 Kernel RW coherent 
> 4: 0xc2400000-0xc43fffff 0x02400000 Kernel RW coherent 
> 5: 0xc4400000-0xc83fffff 0x04400000 Kernel RW coherent 
> 6: 0xc8400000-0xd03fffff 0x08400000 Kernel RW coherent 
> 7: 0xd0400000-0xe03fffff 0x10400000 Kernel RW coherent 

The starting address of a BAT block is always aligned to the block size.
All of DBAT2..DBAT7 are wrong?


Segher
