Return-Path: <SRS0=qe53=YQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DB0CA9EB6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Oct 2019 12:49:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D3020640
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Oct 2019 12:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDTrBOZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D3020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yqw429DRzDqS4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Oct 2019 23:49:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::142;
 helo=mail-il1-x142.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LDTrBOZ1"; 
 dkim-atps=neutral
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yqpL3vqlzDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2019 23:44:56 +1100 (AEDT)
Received: by mail-il1-x142.google.com with SMTP id d83so10271590ilk.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2019 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KCumm8k8QZFgEaXx7omB9aOrf4hbPGxPHtVfgyDzsMc=;
 b=LDTrBOZ1+JfvlvTSEcwWYsX9iOf1MJ/3FxEIKmXp4Akg+bT8+VGTRqQHVDd0X/Pc8T
 5peWru6fWsvOmE81EZWhTYodhcZWSfRwnVLoQ0s9+ZDDJ/wAAZrBGoxyK91L011Q5jzu
 umB3NkXBxTUnTlLHb+HXzytdkPhcf1BA8k7x0rxVXD7NxX77WPNhl8tSSfn2K4G3Imkm
 YBZoa2UtM3fuSmJUMEVaDEh7uC4j1VHlaQpAN5OSJxiejDk5dW1RaiTNhXQwM1kZjybM
 KgOs1OaZDxXllyfDA4j/gHmEPbj8cobL+taLvSWPV+eyYoiJgVO333jORm+eRbQOVfmR
 BfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KCumm8k8QZFgEaXx7omB9aOrf4hbPGxPHtVfgyDzsMc=;
 b=uh4USBRjJ7uhaXulDFo1mGSq+uQ9DZPGd7oFfwVqsagRJzjILAKf8/nEh7t5Kvq4js
 qeavIA/kVcpJ1b3m5fvJ52UwDIFyMRgtVEgkf+OZ6cG4/IhGQa2i7Nr7SB4z6RAtb5v5
 zo0dKSlPHkBJeQHO5U82FyGvg5nmSgi2jqnvEqEJbKZyAD70iz1bHzecMLSlkkQASgJJ
 k8IIYCQrVRpe0VrpLExDCWOkokN/DCSwVXiDuFUC8YpJgU2YCIAPiWxXJzC/nUmyTdWB
 19nme44pLd97Pt3OCF0VjCrVqV3n8GchZGVeVnq8JOSfhbhXywdNSEvVZSSOT2Kh5Jni
 LvKg==
X-Gm-Message-State: APjAAAXHY7iuRviLo2s7+Hyn/turoJhjfq2OlRRIEGqOFfVvUSyzh5RM
 icKBt387XSuGdlWvWhb2O+us1nM4jezD14T5DmE=
X-Google-Smtp-Source: APXvYqzGbgRiDbN76eWO+FVMnXbtQ0VH2X2AA23kY/MsgxfNsvGqm1CxUlxMFtF/ZtAbu7rSzhosvv+FbY0J/2Yjnno=
X-Received: by 2002:a92:5ac2:: with SMTP id b63mr39871670ilg.192.1571834692034; 
 Wed, 23 Oct 2019 05:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191023013635.2512-1-oohall@gmail.com>
 <20191023112102.GN28442@gate.crashing.org>
In-Reply-To: <20191023112102.GN28442@gate.crashing.org>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 23 Oct 2019 23:44:41 +1100
Message-ID: <CAOSf1CGjVt1v4RcazXTLkbm=fsswF8a5nqsLZod4=YwymLXPvg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Fix the initrd being overwritten under qemu
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, stable <stable@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 23, 2019 at 10:21 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Wed, Oct 23, 2019 at 12:36:35PM +1100, Oliver O'Halloran wrote:
> > When booting under OF the zImage expects the initrd address and size to be
> > passed to it using registers r3 and r4. SLOF (guest firmware used by QEMU)
> > currently doesn't do this so the zImage is not aware of the initrd
> > location.  This can result in initrd corruption either though the zImage
> > extracting the vmlinux over the initrd, or by the vmlinux overwriting the
> > initrd when relocating itself.
> >
> > QEMU does put the linux,initrd-start and linux,initrd-end properties into
> > the devicetree to vmlinux to find the initrd. We can work around the SLOF
> > bug by also looking those properties in the zImage.
>
> This is not a bug.  What boot protocol requires passing the initrd start
> and size in GPR3, GPR4?
>
> The CHRP binding (what SLOF implements) requires passing two zeroes here.
> And ePAPR requires passing the address of a device tree and a zero, plus
> something in GPR6 to allow distinguishing what it does.

This is what is assumed by the zImage.pseries. I have no idea where
that assumption comes from,A B

> As Alexey says, initramfs works just fine, so please use that?  initrd was
> deprecated when this code was written already.

That's not what Alexey said and the distinction between an initrd and
an initramfs is completely arbitrary.

>
>
> Segher
