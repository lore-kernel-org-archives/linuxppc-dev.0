Return-Path: <SRS0=d5Dh=4V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A1C3F2CD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 04:47:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F43A20842
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 04:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtZrFgtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F43A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48XLvj60s8zDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 15:47:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=bharata.rao@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=UtZrFgtj; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48XLqj722pzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2020 15:43:39 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id n7so645503wrt.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2020 20:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=okutyK5a8uQZodANWxrUAY3lG9R/jofu3YcVmmvfiXg=;
 b=UtZrFgtjsSVPD97F4GruvTZtyh2VBOeQ4HKg0HP2gH+pqaH90Kj/tqXWvqJVgqLWUI
 A8QRfAJIG0iLFragRxQi4JY75xgzmcKasIin+nANgxxdQj9csad7RLWFPuSK1AkvF8Cl
 77q3rKVMKwuwtHS9sl3wggvbcKpP2CyzlN3pAXHRUeVObFSyVsoXOiWgS+JLlk6mXo+9
 cmIKQD9kIzJ9Mwhfoyu+DawM7UQVpWrrbIoKDQo8Iy7sXz9L14XsI6wu4f6Gfy30+KQB
 pmO1bQOZ2SB4rEEezl777klETr4hsjIYo9hTKe++NOgJdeaTbZSA5WKK/3EhrIpXHv0v
 qUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=okutyK5a8uQZodANWxrUAY3lG9R/jofu3YcVmmvfiXg=;
 b=kZYFKYsTTTeEHiDnprxO4mxwwNY3F1c1DI0Gy5jNa1q45bZY1HbMRdnNINhn6i298o
 MopmgSn4xCeJW0TnHweAi/o7wMa9xfpAxx3MfX3XtvnmugG8pqy78Iy2CXJQEvgx/Lu2
 apBMt34ty8Izgc4r2qTKFlTGKtXSkFO7wC6Z+qzsm/w4q0C7zkYDIQrevn64FUE0v0Ql
 QS9n3dzsGbuxPlrW3jd4rWT8mW5kox/0+pGIGRAjHe8h+4BF0C12iMdre27dQrXoEoDu
 Lf54WqJzufKV9fKjc0dUcnY1t5jZqQCXm8n6w+8e/54TMDoQCeVZbaGolyxmQ4tL8jP3
 2Z2g==
X-Gm-Message-State: ANhLgQ1lyOkBVZ+7jbfewLXNRDiHUXawjeUz6tjDUG40m4VXFWyYBoSx
 +JxzaiDZlc8cuBWEnB2jE57cA59SL45QXC3yLJg=
X-Google-Smtp-Source: ADFU+vvM2137kGKlC2DGBWaTikYu6VxUe7kjGnT7T8VaaOObxG+7akabL9DZ6E88BymipWybKPVlnzib9SXjeGFaECk=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr1770087wrv.62.1583297014940; 
 Tue, 03 Mar 2020 20:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20200228060439.52749-1-leonardo@linux.ibm.com>
In-Reply-To: <20200228060439.52749-1-leonardo@linux.ibm.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Wed, 4 Mar 2020 10:13:23 +0530
Message-ID: <CAGZKiBr=8i11YPDn+1y5j6YfGj+tVbbTKakoGje9QQ8TEw9g5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
To: Leonardo Bras <leonardo@linux.ibm.com>
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
Cc: ndfont@gmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 arbab@linux.ibm.com, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 28, 2020 at 11:36 AM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> While providing guests, it's desirable to resize it's memory on demand.
>
> By now, it's possible to do so by creating a guest with a small base
> memory, hot-plugging all the rest, and using 'movable_node' kernel
> command-line parameter, which puts all hot-plugged memory in
> ZONE_MOVABLE, allowing it to be removed whenever needed.
>
> But there is an issue regarding guest reboot:
> If memory is hot-plugged, and then the guest is rebooted, all hot-plugged
> memory goes to ZONE_NORMAL, which offers no guaranteed hot-removal.
> It usually prevents this memory to be hot-removed from the guest.
>
> It's possible to use device-tree information to fix that behavior, as
> it stores flags for LMB ranges on ibm,dynamic-memory-vN.
> It involves marking each memblock with the correct flags as hotpluggable
> memory, which mm/memblock.c puts in ZONE_MOVABLE during boot if
> 'movable_node' is passed.
>
> For base memory, qemu assigns these flags for it's LMBs:
> (DRCONF_MEM_AI_INVALID | DRCONF_MEM_RESERVED)
> For hot-plugged memory, it assigns (DRCONF_MEM_ASSIGNED).
>
> While guest kernel reads the device-tree, early_init_drmem_lmb() is
> called for every added LMBs, doing nothing for base memory, and adding
> memblocks for hot-plugged memory. Skipping base memory happens here:
>
> if ((lmb->flags & DRCONF_MEM_RESERVED) ||
>     !(lmb->flags & DRCONF_MEM_ASSIGNED))
>         return;
>
> Marking memblocks added by this function as hotplugable memory
> is enough to get the desirable behavior, and should cause no change
> if 'movable_node' parameter is not passed to kernel.
>
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 6620f37abe73..f4d14c67bf53 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -518,6 +518,8 @@ static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
>                 DBG("Adding: %llx -> %llx\n", base, size);
>                 if (validate_mem_limit(base, &size))
>                         memblock_add(base, size);
> +
> +               early_init_dt_mark_hotplug_memory_arch(base, size);

Hi,

I tried this a few years back
(https://patchwork.ozlabs.org/patch/800142/) and didn't pursue it
further because at that time, it was felt that the approach might not
work for PowerVM guests, because all the present memory except RMA
gets marked as hot-pluggable by PowerVM. This discussion is not
present in the above thread, but during my private discussions with
Reza and Nathan, it was noted that making all that memory as MOVABLE
is not preferable for PowerVM guests as we might run out of memory for
kernel allocations.

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/
