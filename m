Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB130C433C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 15:05:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262A361A26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 15:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262A361A26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6QJd5LBhz3cCn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 02:05:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6QJ669Lvz3bvr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 02:05:10 +1100 (AEDT)
Received: from mail-oi1-f169.google.com ([209.85.167.169]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N8XLj-1llH0q3GW9-014XSu for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar
 2021 16:05:06 +0100
Received: by mail-oi1-f169.google.com with SMTP id n140so5968434oig.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 08:05:04 -0700 (PDT)
X-Gm-Message-State: AOAM533cUnNUEKvSm2GoEIHE/01cWWfsjSvZ1pcB4jyjTbOZFalhu5PB
 wECA8hMQdlJnZYvgRG3oSpwIbtAqaNXS9uvnoEs=
X-Google-Smtp-Source: ABdhPJxkabhICNjVimKONzi11M/Se4ShvOLHDXtHqNvGZV2LWEfIbqRfkSQLV++Q5maH4NbCwdiaxdlkbDHuJr8w0IQ=
X-Received: by 2002:a05:6808:313:: with SMTP id
 i19mr9838151oie.67.1616771103242; 
 Fri, 26 Mar 2021 08:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210326143831.1550030-1-hch@lst.de>
 <20210326143831.1550030-2-hch@lst.de>
In-Reply-To: <20210326143831.1550030-2-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Mar 2021 16:04:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1zGcjPXPhKiUVZOwocYFKNfSGSx-M_ZY1hytp1+xEt0g@mail.gmail.com>
Message-ID: <CAK8P3a1zGcjPXPhKiUVZOwocYFKNfSGSx-M_ZY1hytp1+xEt0g@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: remove do_execve
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:M4F7FLYSB0mShYpDwcTVhqDPjE6l/xzZ9cdvoO6jgFJjZeOAFll
 5czji7KBKx2+XaQxSnB9ULEw1Goo3g03tiVqdDkweDNYZIQSHGXwqvO2FqQPtzcbfwilCv5
 Q3sDoIsKuzLKCKMij/B5p+3pQ5N9W4c1B2Y5ZEwskTB5jyCgvgToRb/nxXkA/CXLW/w3K83
 LXZjhsCdGrHnnSg1IZAGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCJqDP4x+RE=:DknoFE7reHI9CoeCpesHHV
 LU3ruHZ8dc8JrNzeLjKvB81jbKRmznZ1XAyZWtDoC4Kueomqsb0TYJuRHLwrFFIODoCU+Lg86
 Z1Is9KiYdPCD4JL1NASdnYEgj7BRhdiE7Evpkc/M81VN5QwvtVO/9YSAsVtbKM1J6m6c98qW4
 s83aOGj3E/cABzCyC1M2qPXJSrAB+rN+K+x6/gLmm+XIyUr8wbpWxFzefiV5PFguFXjqe+NWr
 GxcXy3yBjnQn04YQ+80651+/3UNSIt4kL6uCOwC2ESMMpHf0h66CkARhdafynJU7cQpKT6ha2
 aQKtyCpCwehbBJ1ZI6TE4UUP7J8i4q8WJFb0lHcGLMp7SPIFNRgwNnm9Ymx5HlBgmNpVasSeC
 VhXoHDf1t0iMGkn4aYvovA/ldp/EzTWA7FqiFB2vZEgUdw+/yl6IYKBEAJkqdThulAUG3dBPB
 PnlCfUytVarggjdngbsKxgc+qcEPMCjfZN4BQnkhVDdtZfypBypIe+jZX4qGGQxUQRv5cSuSr
 x9hbD+YfRxTlHRb/FxkZzIAZWH2EMoQHebPdLAOMTriv7jGaP/j5eFkWtanaobLN9xzTSDfvV
 G2OUJn7EsphliQ4MS4cwyF9CzRcA56LOGg
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Brian Gerst <brgerst@gmail.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 26, 2021 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Just call do_execveat instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
