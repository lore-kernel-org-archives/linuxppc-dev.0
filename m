Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A8C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 21:39:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C5820815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 21:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C5820815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Rxmy5X8MzDqG1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 08:39:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RxkY5qdRzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 08:37:40 +1100 (AEDT)
Received: by mail-qt1-f194.google.com with SMTP id e5so26462550qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 13:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WwVwB1S8LdUynVFe20mibVGVOLUyPee2SJD6q4AnfTg=;
 b=uMs48CogbW7PWRoLyeBti6gGCEL2CYbg2/AykHQOeKsiWqSt5FRbG41j+r+ZYehlbI
 fzqDWEFD/Ob4iznCTergAbSTWIfCEekdWnqwuaxyNvwpLZlkQK6jUao44Sblgf8YUJUH
 OQRdRKxs8NuPYjwznuY/oGg2rL6QJJDtaYLgB6ZfDGAushpLKXuXM1MDp5aHctJQRb4V
 w8Arjbw/xV+VBR8ptFbDIM0UA6TXSUy41aY3RdVJl8t8kVVnaYN6Velg5xjW4x4kzULH
 HEheIWy4ePXitDmEprfftTPXkTRtkyluCiRsHDR82RSZOmbaLxfmPCLyZGxh6mra/eBo
 VlpQ==
X-Gm-Message-State: AJcUukfJzTjueJfc2RmYfiRn4Pu0PtilK9yCwgX30VJNq294P+szJxTA
 LJwgHYugBGJOLfDmIYWrKK8E6RqjYXXs+bqQjlA=
X-Google-Smtp-Source: ALg8bN5t2ynaRnOoH0ytyUov60/lnzeVr55hB9q7byJScxyC9/TYJH41eW1NcVvy4FlcA8WtxHp8K6moh+7TivOOWBw=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr30406307qvm.149.1546119458090; 
 Sat, 29 Dec 2018 13:37:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
 <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
In-Reply-To: <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Dec 2018 22:37:20 +0100
Message-ID: <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To: Michael Schmitz <schmitzmic@gmail.com>
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
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Finn Thain <fthain@telegraphics.com.au>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 29, 2018 at 3:51 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Hi Finn,
>
> Am 29.12.2018 um 15:34 schrieb Finn Thain:
> > On Sat, 29 Dec 2018, Michael Schmitz wrote:
> >
> >>
> >> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.
> >>
> >> Or (really going out on a limb here):
> >>
> >> IS_BUILTIN(CONFIG_NVRAM) ||
> >> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
> >>
> >> Not that I'd advocate that, for this series.
> >>
> >
> > Well, you are a maintainer for atari_scsi.c.
> >
> > Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of
> > ifdef?
>
> No, just pointing out that there would be a way to avoid the ifdef
> without messing up driver behaviour. I'm fine with the ifdef - not least
> because it clearly eliminates code that would be unreachable.
>
> (On second thought - I don't want to speculate whether there's weird
> compiler options that could result in the nvram_check_checksum and
> nvram_read_bytes symbols to still be referenced in the final link, even
> though IS_BUILTIN(CONFIG_NVRAM) always evaluates to false. Best leave
> this as-is.)

As far as I know, it's totally reliable with the supported compilers (gcc-4.6+).
In the older compilers (e.g. 4.1), there was a corner case, where it could
have failed to eliminate a function that was only referenced through a pointer
from a discarded variable, but a plain IS_ENABLED() check like the one here
was still ok, and lots of code relies on that.

Other than that, I agree either way is totally fine here, so no objections
to using the #ifdef.

      Arnd
