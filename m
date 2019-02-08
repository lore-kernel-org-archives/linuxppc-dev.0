Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA217C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:55:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E342D20857
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYtk5kQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E342D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wwBz6ChhzDqW3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 23:55:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FYtk5kQ7"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww5c528MzDqTR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:50:44 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id z20so8536458itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fdozYqGTV+6ky2AZtZxrK0ofNU/9VU5d4Wl9yDN9W4k=;
 b=FYtk5kQ7df/N0D2nuWmpY+Fb5P8pHINlWwwfMZFxUHQKtMv+AjIX7gC9HzmN9vtyqd
 SSNCweyuece2VM1Xfea+1ZJmXofnvrH2IWSqG4UuiWol48HFJbcN1mieqdgbv6aNRIAF
 jnCKHtkGeuYAe8NlI6A/JCmYrq4UWNiGbp0Ett3RQyHoIZGVj7xVm1AbjM0LUHgD1B8z
 HDiCh1426YgCsqQZOEmxXnEMQHRzfVkQiln1wUc4FpXEdfntUxslIN+/2TUjl+Ms4N6m
 cw0YDLA5Vw7zP5C0JTuzFelK9CF0zsKbHKXmqcy/Wmb6c4Tq0+pQzF/N6SyJX/FYfssS
 m8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fdozYqGTV+6ky2AZtZxrK0ofNU/9VU5d4Wl9yDN9W4k=;
 b=DZ3pHoEKeWUNPeifkYzwej95EbbWSh6OZsfGXtMy8pIOY74nMQn9O7hzRcaChYzMxy
 3x6d4oh2Lr4dgA51+Q0GWsCrmduBmVCSWpHU0csNKdLkrsbnbbykvvjmMM3dYMCqaYfa
 OeCppxpntkIMB3wzhroTZlMAQ9qIyTE8Bq9HhVs4k2ULpTX2tDW9u4Y8pKKqiyGQTu3I
 dOzpw6ky0vA6Jm0PNrafNa8g8BwKDliYrqao8DjIXXsaFWH5bHF152KLRS86KOhQhDKC
 pae961HuWNi72q/c/6kevzfZYpGkMIyyHuP3knMIDk34uAimNWtDPJqPYVQztUfp9p8U
 9y2A==
X-Gm-Message-State: AHQUAuYewF+laCedV7jZEDANboKkfInNs1jji/wJMIR5PDlXFPhT1Cu+
 zR9ip0xh96meYRptVjrsKmbm0J2br3B6aOeEStNRmQ==
X-Google-Smtp-Source: AHgI3IakYJDaxvO/+yM6HZuJgcC8yZNhBsIKxMX8LoChVgr2HlqGUeF7ca4AzvWs2s6a8gPeXrvfruVRp2RaKkTKtrw=
X-Received: by 2002:a24:2b83:: with SMTP id h125mr3163974ita.4.1549630242284; 
 Fri, 08 Feb 2019 04:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-7-oohall@gmail.com>
 <87tvheihqa.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvheihqa.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Fri, 8 Feb 2019 23:50:30 +1100
Message-ID: <CAOSf1CFJqFaAwE34GFU4cwWkhGd-jwUPGANadAcNNwp3H2mvqg@mail.gmail.com>
Subject: Re: [PATCH 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 8, 2019 at 11:32 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Oliver O'Halloran <oohall@gmail.com> writes:
>
> > This patch adds a debugfs interface to force scheduling a recovery event.
> > This can be used to recover a specific PE or schedule a "special" recovery
> > even that checks for errors at the PHB level.
> > To force a recovery of a normal PE, use:
> >
> >  echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover
> >
> > To force a scan broken PHBs:
> >
> >  echo 'null' > /sys/kernel/debug/powerpc/eeh_force_recover
>
> Why 'null', that seems like an odd choice. Why not "all" or "scan" or
> something?

When an EEH event occurs the bit that is sent to the event handler is
just a pointer the the struct eeh_pe. If the pointer is null it's then
treated as a special event which indicates a PHB failure. I agree it's
a bit dumb, but I don't really expect anyone except me or samb to use
this interface so I went with what would make sense to someone
familiar with the internals.

>
> Also it oopsed on me:
>
> [   76.323164] sending failure event
> [   76.323421] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
> [   76.323655] Faulting instruction address: 0x00000000
> [   76.323856] Oops: Kernel access of bad area, sig: 11 [#1]
> [   76.323946] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> [   76.324295] Modules linked in: vmx_crypto kvm binfmt_misc ip_tables x_tables autofs4 crc32c_vpmsum
> [   76.324669] CPU: 2 PID: 97 Comm: eehd Not tainted 5.0.0-rc2-gcc-8.2.0-00080-gfacc0d1d9517 #435
> [   76.325054] NIP:  0000000000000000 LR: c0000000000451f8 CTR: 0000000000000000
> [   76.325402] REGS: c0000000fec779c0 TRAP: 0400   Not tainted  (5.0.0-rc2-gcc-8.2.0-00080-gfacc0d1d9517)
> [   76.325768] MSR:  800000014280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24000482  XER: 20000000
> [   76.326243] CFAR: c000000000002528 IRQMASK: 0
> [   76.326243] GPR00: c000000000045edc c0000000fec77c50 c000000001574000 c0000000fec77cb0
> [   76.326243] GPR04: 0000000000000000 00177d76e3e321bc 00177d76e4293a1f 5deadbeef0000100
> [   76.326243] GPR08: 5deadbeef0000200 0000000000000000 0000000000000000 00177d76e3e3216b
> [   76.326243] GPR12: 0000000000000000 c00000003fffdf00 c0000000001438a8 c0000000fe211700
> [   76.326243] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [   76.326243] GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000e814e8
> [   76.326243] GPR24: c000000000e814c0 5deadbeef0000100 c000000001622480 0000000100000000
> [   76.326243] GPR28: c000000001413310 c0000000016244e0 c0000000014132f0 c0000001f84246a0
> [   76.329073] NIP [0000000000000000]           (null)
> [   76.329285] LR [c0000000000451f8] eeh_handle_special_event+0x78/0x348
> [   76.329602] Call Trace:
> [   76.329762] [c0000000fec77c50] [c0000000fec77ce0] 0xc0000000fec77ce0 (unreliable)
> [   76.330113] [c0000000fec77d00] [c000000000045edc] eeh_event_handler+0x10c/0x1c0
> [   76.330464] [c0000000fec77db0] [c000000000143a4c] kthread+0x1ac/0x1c0
> [   76.330681] [c0000000fec77e20] [c00000000000bdc4] ret_from_kernel_thread+0x5c/0x78
> [   76.331026] Instruction dump:
> [   76.331197] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [   76.331550] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [   76.331803] ---[ end trace dc73d37df5bb9ecd ]---
>
>
> cheers

This is probably a side effect of special events being a PowerNV
specific concept. For a pseries guest there should never be any PHB
PEs since (hardware) PHBs are a concept that is hidden to to a guest.
It's like EEH is poorly thought out and full of layering violations or
something...
