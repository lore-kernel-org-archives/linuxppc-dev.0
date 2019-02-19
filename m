Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFAC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 21:57:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019882147A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 21:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FlgxZkii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019882147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443vjj074DzDqCc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 08:57:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sifive.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=palmer@sifive.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=sifive.com header.i=@sifive.com header.b="FlgxZkii"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443vgn6bXTzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 08:56:02 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id g6so10826673pfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 13:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=zwftrmOanSdXzGc8vLBd3uz4NYesZr6TcF6+HO5ue/8=;
 b=FlgxZkii1ql/ihK9/mTDXJZxMuqUGxQwjTuD6Js76dnbctgvl2vSAe73VTxWX0xlb7
 BKd877LCMLLdk6LW8f4WKDe/gS9oAlDjgZYEe1IMhhBkQXAL3XEUweP90fm9CSEfFhzZ
 BCv/zekDCVH2tH45qJ0Dmo3Lo8Q17+hY7POGQaiA9MhIacwSqf8DXZxWUGDzGrCo7n4P
 TdJEoZjKEOWaP6NY6P5BVye0gnsh9Hwh8MNOS0MNih3UBfYeTrenAdbJzcn6HJIrgM9Q
 fKIG8nwg8X6c+GdKIPT7yl4iXDtkQAxswC5ygIPe8949hzgOefWv54XIb1CmDmkhQUkx
 Ss9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=zwftrmOanSdXzGc8vLBd3uz4NYesZr6TcF6+HO5ue/8=;
 b=d2UN/bmDxnFjWsuDlv+OSCEZiwY1cymwQMrhkhfsOay3HKz4VZLPeV4c2g9ZKIj2nl
 qBZRzURG6q1ZB6n66zzvz0VPw/QxPi9THNYJIYHnH5yQs/Hv5/l8CvoR6lIP0w5NxeHS
 HIIhz12Ymcn5klz2S41UGhOqBFUeqrogDWIJK+kGes7gM3DIrAF8TgZ+a1tSKuWLaYxm
 asqirGRVxz0ReDqZ8OYVnJrTc02ipDru80p2w9Klnk9N3oiv8HztwscNU2zoCdcZh8gm
 Wx9tQaduQOuHyjzDnETZThc0RRvqbFoDbSyNgiMZpXWBU6SWLVP7ayAJwEX3NqH+oOvj
 kDgw==
X-Gm-Message-State: AHQUAuZtcdXTjhNGtrAhb/ZwY41bWmsVbI79HxgRySXlWwH8lsBGpQH2
 RI6j3ET5mFMGy9qDRdUnekudQQ==
X-Google-Smtp-Source: AHgI3IbO71j/yAEHBSC/UTbub00j189AuzZZ0wQvGAVS08M3quqG9okfN46WWJ73A48emt4TkHOIYg==
X-Received: by 2002:a63:5b1c:: with SMTP id p28mr25442696pgb.73.1550613359530; 
 Tue, 19 Feb 2019 13:55:59 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id u2sm21380550pfh.134.2019.02.19.13.55.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 13:55:58 -0800 (PST)
Date: Tue, 19 Feb 2019 13:55:58 -0800 (PST)
X-Google-Original-Date: Tue, 19 Feb 2019 13:55:45 PST (-0800)
Subject: Re: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
In-Reply-To: <20190219151759.GD4121@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-a73ea6c9-683c-4ee0-991e-24a6608b6887@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
 yamada.masahiro@socionext.com, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 19 Feb 2019 07:17:59 PST (-0800), Christoph Hellwig wrote:
> On Fri, Feb 15, 2019 at 06:32:07PM +0900, Masahiro Yamada wrote:
>> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>> >
>> > HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
>> > should just select it if supported.
>> >
>> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Do you want this patch picked up by me?
>>
>> Or, by Palmer?
>
> Given that I don't think I'll have the rest of this series respun in time
> for this merge window:  Palmer, can you pick it up?

It's on my for-next.
