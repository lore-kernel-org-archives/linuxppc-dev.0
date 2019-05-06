Return-Path: <SRS0=pfuI=TG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49003C04AAA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 09:13:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8F62082F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 09:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiczZxhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8F62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yH8p4PRCzDqC0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 19:13:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YiczZxhl"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yH7F4Yl4zDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2019 19:12:09 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id w24so6065664plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2019 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2zkFvMfXSuPxA7TswP4qZ+QIZKRpTzLAUwlBxIZ9PzU=;
 b=YiczZxhl+N5iLdzUGTmZ+vv61ahbfT5sYkO+ZKl1O183V89+BhJz/LVCYZW69Rs96I
 B9L09hT9RKBTMzQPy68tiva/wZUTF1HeqiQA0wgIQKQi9hc9wauqzRc3OKkCm1b+45xD
 /TIxR7gFTxFuR4TGryfYzNp53n1d0MoSOlSKqUI1PygQXIr4DIq/BsZfwXixIBOH9ZxQ
 yFa4fMS2Zky76vcoykF14xxJXsTp6HA89kojG6J76npL+WXgKQ2KtB8ZUuikGBrAHTkD
 gd51bYyzDfYbsyUC+pmkXYFFrzi2nJRQ6fAyiK8dpDyV02X1sRuhxEHafOiBQ4LbnHZJ
 uFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2zkFvMfXSuPxA7TswP4qZ+QIZKRpTzLAUwlBxIZ9PzU=;
 b=rtmoXDOCN1iWxHXCW99JXPu9fKTBoZaOWTW8aPQd0kCi5A6VUfoUnm6W7eTxX0/0bh
 ner2lykQCXKPKkQxbF/v2DrHicIzHa6NNoheX4uJBvn2KQKTKN/3FRCRXxqzqbH/QYZ3
 NCKtAC0BQhbNt4URBxSToVsl94lrqhJDU5bwMrom+eMFplZjvCbmgs+5vj5a0K9QlsrT
 lAxJk8dZKmoQ6OXovIV8muU7xvDrctvMD0Is4TvDuY9+GjUmdq7XtaIqEd6vz4bWz8Jx
 KBwPF7sf5PvDii7niqv/0VVKHdHIPMVaD82iTo9KxU+vW1WN1Dr3CvrA7qUex2fTe2PV
 giYA==
X-Gm-Message-State: APjAAAWwV4nocE+FKbRCFvIabyw8ov3KQ86XGeR0aiFjmODyfHA7wpue
 MGasQ+HLiW0OkkJQOFymtLUheEuK3Int60N0UmQ=
X-Google-Smtp-Source: APXvYqzcd/LiJVbbE8cCf+fOVIBhczP6XN4ND6V/1pkV1QnBDFee3E6dAicqEB0BMR5uY867+F0seVXH98gF0RaaX4M=
X-Received: by 2002:a17:902:8349:: with SMTP id
 z9mr30421370pln.144.1557133433288; 
 Mon, 06 May 2019 02:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de>
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 May 2019 12:03:42 +0300
Message-ID: <CAHp75Vc2-zzRYk0vpdPQm5duZwW+v=svEndTPV4Sr59QrGcMHg@mail.gmail.com>
Subject: Re: [PATCH v3 00/26] compat_ioctl: cleanups
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 linux-iio <linux-iio@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 linux-ide@vger.kernel.org,
 "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
 sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
 y2038@lists.linaro.org, qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
 linux-input <linux-input@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:REAL TIME CLOCK \(RTC\) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Karsten Keil <isdn@linux-pingi.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB <linux-usb@vger.kernel.org>,
 "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 linux-crypto <linux-crypto@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-integrity <linux-integrity@vger.kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>,
 linux-btrfs@vger.kernel.org, linux-ppp@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 11:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Al,
>
> It took me way longer than I had hoped to revisit this series, see
> https://lore.kernel.org/lkml/20180912150142.157913-1-arnd@arndb.de/
> for the previously posted version.
>
> I've come to the point where all conversion handlers and most
> COMPATIBLE_IOCTL() entries are gone from this file, but for
> now, this series only has the parts that have either been reviewed
> previously, or that are simple enough to include.
>
> The main missing piece is the SG_IO/SG_GET_REQUEST_TABLE conversion.
> I'll post the patches I made for that later, as they need more
> testing and review from the scsi maintainers.
>
> I hope you can still take these for the coming merge window, unless
> new problems come up.

>  drivers/platform/x86/wmi.c                  |   2 +-

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
