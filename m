Return-Path: <linuxppc-dev+bounces-28879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F93ECA5FEF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 15:24:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyRCN5gPPz30RN;
	Mon, 05 Oct 2026 02:24:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791127488;
	cv=pass; b=f+PV3wpL92u3WaesORzInIXbi9H+UMCr2apEipX+3rSnxYCSZtt87VCfS05T/3jaxsHzsJx7L/Ewk5t+0O0uL1IrWuQcSUx7rUD0pYHlBYqJmJtNL1juSyW4enS8UPGpgOBc+6TmHJgYtLNwIs9m6oFwZZqNkF1lJI1iJ6GVuyf50DA4NudPk2qD5lzx8Vt/ItdVbKq5nPeUf3sO45cf8y6iUCs5RyOhpVCx1p0oz6pJISBdS0IHJNifZIEbrWo/jArOxEI99A6H/VN6iMJO9YEUhR5hXHofuChVxAbPh5OUoJgegvzu6zIXrSH0FjqYqSiC9KpnK1vbCkAaKYchQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791127488; c=relaxed/relaxed;
	bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GieB5p1oXQ67NH0Db77/7epDN5VULp+zPDhvVSa8AqqEPF3/mrF7VWHpBDBA38ppTtwXH7iVWCgvUfLZAeA3XFnqBp5GtKZkUU6VAJGbi2ro0LsJZ+y50yLIScOAsjfH341u4+1gpBbWlBncl/vW4jnMXIQZ0453Q3SP6iVpLKiB+LO+LjjAHGYg+GeT+lIGGpuLJqwOAR/i8ebvXrCixORsCqDfAGUhV2rZ/6YCkD83rFaxfnC/Wj+acdW59ghwkAgq6au/Kb5Uk5rPCcf0VO0x7kaKiOIq2c93FQA5A8FmulCtJzhaIysZ7BSX9chb9EXfTXzwfhOfG8U9TbtDqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QqzJJ+TG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QqzJJ+TG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyRCL1SxBz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 02:24:44 +1100 (AEDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so915299a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 08:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791127479; cv=none;
        d=google.com; s=arc-20260327;
        b=rcuRb9jVqcTmMueUBoohaeA1RrA156huKbwjjEZPe41llzdEA+GxpO1erEHqoEIUzQ
         nsrceycGsvmbFdeykNFjYNWbSiqT1Nk7ShJWhfxvjS8d0Vqj8dS0D6lkTmgFzzTkYTK3
         Cn/SOCnUSstTWKdmY2S489ofyFo5kknvr1m9G0EFXLHxUM07hcJq/vJTl1hQcE0rGY7b
         85Rpc0r0ANVvYdIMQdaUzDS1hideFbeK1hFMioxZ/5I3DkPczV3dsY47aLd7yElq7faY
         MsTrpx04OInxQd4toX+GrFI/jG5hBNFlGVPZoPz9gbupWAhb7Xw1roNro3RCcqr53WQ2
         OH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
        fh=TFt6HCrPkIqWoLcMzTkijiU+TCYq9pvff98t5UvI474=;
        b=VGof68h49pwbJkchdyv6ULDxXESV8uwuuyhlDYwM/GX6o6TY3p9AHkqWj7l3YKxfg6
         DMLbyRqCfToC9ExpIXTl4D7tpL1iBJbf6kcfhNx7wr4xccn4Y6dEbSU0PS6/We/b4r4j
         MN/MH0kFE2TxsZh9AYSJCSgFVZXPTj4Ha4swoWb7zgDztTbBthpA15hNnF6ppmkLtQuC
         ia2a8AlB5ASi3ph5rYtT1MyiTKpWSm7jQ5aFYfc33A/bqmua+VMnLNnbSepIdCD4GgjW
         oRs26lbnTBQuEakzsXoTWABjGXuFKRWoHBIBp+UcsTEK3Q/XS8A5eoNuCN0nChH6gm4+
         BZJw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791127479; x=1791732279; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
        b=QqzJJ+TGkm0B2FQxJB6Ef6CoPDJBktI6C5WAb0ArFFK8Jk/1mWcDolPtSvDDXzTOhx
         psXqEm4MqMcDrDtvrMqpyD1n85njzhzCmKhntzkpSMuXVe2YbhLUJ8GzSNt4FL383S/3
         L3djxSREBChj4b7xTuHekWJFADYbySkBS4oAh2E0Lphao3p9KZ52VET/K6CNZJcqlFKA
         8QPtf7XdZSaL4XixJYBkqD9mkj5oTbhkR4FKtl2goUmOrUf7wcjykfvmXgPM9abcU1ed
         hF07VsDQjjJ8xG1TgWxZgwuihtQIZvxnzW4Oa+/YqRj/ww+8dTYco6W6goozj9Bkwtj6
         gI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127479; x=1791732279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
        b=C3+yjow2VWXJYz/lZYpZTpLrttabJmm1vKr7CptCW7jCm45n9hLjcyT/PGPVursF6m
         oXbTa5VsLBpy5b1vpLRM75K326n3AUPHxPdB83bbSHV9DxVmELzLvSt2Sf2igg7wo8lJ
         oaugyh0YzaKMdFyTKxK1IFl5NwOfrZH9zxWAGQWcbHGUaSG7DbOgivQ7oSsVQLeJNlUC
         aGYk2Ws0YAOVT3hlfpgDaYIn6EROcM7RV2iaIO8wB3vGn6pcyHpZC3ZJGypHLQFkLWYc
         GRGG6/jEI+mzd6ABQYyg6WEaun1ojZ5XmVmvHnomRRwjNLOAXyombZyGEfR5feGGywm1
         B6Cg==
X-Forwarded-Encrypted: i=1; AKwUvBy0+c08RXVyk9Ai7EtHnT6DB6k1b2wSkgz/aIjiP0dLX6+Q2MIkBWhx6yaDecy+R6lizaHQ5ZUUniAXyeg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLPMpbwSIueorHrk8FOrHW6cK7EcrQ1aECJpNV6EP1gtYDeR1UR
	+a6L/M0+KlBGuB4/jxdJUHkG7ayuj7XFexG1ST6K7vopFmjzzcQ0wXCsrOX5zFxfUJFHxI8mEXt
	3tCyj8+wS8eCTGF16rK2jpHNBOt/RFew=
X-Gm-Gg: AYBFou1zvQ7D8Ml4J3ah2F5lF7eNWBoJIhsYcu0ZTDXtwRay45DSjppPldabV/6EUEj
	+rsND8Cs8s3IA4VW2aJ8en6KFky7L9PWGp4zMilfpfEQx1msdYWKr5+qlMpwQyteXpvtebNRIX4
	KlYoWO4IMoPsQ4dXwuVOR+F3gV+XCjsaiapuAkiIL/gyO0ybyEDNJFash3YbMZ7dpTVrqCUCbf+
	NTc3tyBemKFhocjEIr4GJZ3JD+es046PDdF8MGsnNwinWj7bhBU4aBWbporJwggW602z5wgj1Lo
	O62Tg2oH4YXl8DRVIpD7kiHiT7S9Q6wjiFyDQCKFxYjVtpB1iOTM6DFo3D5jqiRh7AjEnrbHvFB
	QEySXZAhoN8uNMDERwPNJheBN7oV/sQR5RfNnsZ2ok38=
X-Received: by 2002:a05:6402:4547:b0:6ac:a828:c0cc with SMTP id
 4fb4d7f45d1cf-6afad760efemr3521524a12.4.1791127478724; Sun, 04 Oct 2026
 08:24:38 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20261002161515.932316-1-linmag7@gmail.com> <20261002161515.932316-8-linmag7@gmail.com>
 <2026100415-impromptu-sultry-ce6b@gregkh>
In-Reply-To: <2026100415-impromptu-sultry-ce6b@gregkh>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 4 Oct 2026 17:24:26 +0200
X-Gm-Features: AclHuK-uAAu0JuOLh2P2vcb8AMeHq-JogU2rRgtxPU7ZqlRRcEoJsr_m9gxHF6I
Message-ID: <CA+=Fv5T6sMOxVmS82_VF=XOWudF06y8tWSWLv3XA1aTyAv3JoA@mail.gmail.com>
Subject: Re: [PATCH 7/7] hvc: add an M3000 firmware console backend
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks alot for taking the time to review this.

On Sun, Oct 4, 2026 at 2:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> > @@ -11,3 +11,5 @@ obj-$(CONFIG_HVC_IUCV)              +=3D hvc_iucv.o
> >  obj-$(CONFIG_HVC_UDBG)               +=3D hvc_udbg.o
> >  obj-$(CONFIG_HVC_RISCV_SBI)  +=3D hvc_riscv_sbi.o
> >  obj-$(CONFIG_HVCS)           +=3D hvcs.o
> > +
> > +obj-$(CONFIG_HVC_M3000) +=3D hvc_m3000.o
>
> No need for a blank line, right?  And why no tab used here?
>

Agreed; I have removed the blank line and matched the Makefile's tab
alignment.

> > diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
> > new file mode 100644
> > index 000000000000..0ef4c888a6a2
> > --- /dev/null
> > +++ b/drivers/tty/hvc/hvc_m3000.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Experimental M3000 Open Firmware pseudo-console backend. */
>
> What will make it not "experimental"?
>

That was stale wording from bring-up, rather than a defined support
status. I have removed it.

> And no copyright?
>
>

I'll  add a copyright notice for the v2.

> > +
> > +#define M3000_WRITE_ATTEMPTS 8
>
> why 8?
>

There is no hardware requirement for eight. The intent was to bound
no-progress retries because HVC's console write path retries -EAGAIN
indefinitely; I will revisit the retry policy before sending v2.

> > +
> > +static int m3000_stdin;
> > +static bool m3000_ready;
> > +/* Keep firmware buffers within the locked kernel image mappings. */
> > +static u8 m3000_buffer[256];
> > +static DEFINE_RAW_SPINLOCK(m3000_buffer_lock);
> > +static struct timer_list m3000_poll_timer;
> > +static bool m3000_poll_active;
>
> Shouldn't these be in a structure attached to the console somewhere?
> Otherwise you have limited yourself to just one of these.
>

I can group the state into a structure. This backend uses the single
/chosen stdin/stdout pair, and the buffer must remain in the locked
kernel image mappings for firmware access. I will also review how the
state is associated with HVC before finalizing a v2

> > +
> > +/*
> > + * HVC's idle backoff can exceed the firmware input FIFO's capacity.
> > + * Wake its worker each tick while open; keep PROM calls out of the ti=
mer.
> > + */
> > +static void m3000_poll_tick(struct timer_list *timer)
> > +{
> > +     if (!READ_ONCE(m3000_poll_active))
> > +             return;
>
> Why are you accessing m3000_poll_active like this in an attempt to not
> use a real lock?  Are you _sure_ a bool will work this way properly?
>

Agreed that READ_ONCE/WRITE_ONCE alone do not explain the timer lifecycle.
I will review synchronization between open, close and timer rearming,
and make that protocol explicit in v2.

> > +     hvc_kick();
> > +     mod_timer(&m3000_poll_timer, jiffies + 1);
> > +}
> > +
> > +static int m3000_open(struct hvc_struct *hp, int data)
> > +{
> > +     WRITE_ONCE(m3000_poll_active, true);
> > +     mod_timer(&m3000_poll_timer, jiffies + 1);
> > +     return 0;
> > +}
> > +
> > +static void m3000_close(struct hvc_struct *hp, int data)
> > +{
> > +     WRITE_ONCE(m3000_poll_active, false);
> > +     timer_delete_sync(&m3000_poll_timer);
> > +}
> > +
> > +static ssize_t m3000_io(u8 *in, const u8 *out, size_t count)
> > +{
> > +     unsigned long args[7], flags;
> > +     bool input =3D in !=3D NULL;
> > +     int ret;
> > +
> > +     if (!count)
> > +             return 0;
> > +     count =3D min_t(size_t, count, input ? 1 : sizeof(m3000_buffer));
>
> No need for min_t(), why not just min()?
>

Agreed, will change it to min().

> > +     /* Serialize the bounce buffer; p1275 separately serializes firmw=
are. */
> > +     raw_spin_lock_irqsave(&m3000_buffer_lock, flags);
>
> why is this a "raw" spinlock?
>

The intent is to protect the shared firmware buffer in console output
contexts where sleeping is not allowed. I will check the precise HVC
calling contexts and lock ordering before deciding whether the raw lock
is necessary and documenting that choice.

> > +     if (!input)
> > +             memcpy(m3000_buffer, out, count);
> > +     args[0] =3D (unsigned long)(input ? "read" : "write");
>
> A string being cast to an unsigned long?  Are you _sure_?
>

Yes: p1275_cmd_direct() takes unsigned long firmware argument cells,
and the first cell carries the service-name pointer. The existing
SPARC prom_console_write_buf() uses the same cast for "write".

> > +     if (!m3000_ready)
> > +             return -ENODEV;
> > +     timer_setup(&m3000_poll_timer, m3000_poll_tick, 0);
> > +     hp =3D hvc_alloc(0, 0, &m3000_ops, sizeof(m3000_buffer));
> > +     if (IS_ERR(hp))
> > +             return PTR_ERR(hp);
> > +     hp->ws.ws_row =3D 24;
> > +     hp->ws.ws_col =3D 80;
> > +     pr_info("M3000: firmware-backed hvc0 tty ready (serialized, polle=
d input)\n");
>
> When drivers work properly, they are quiet.
>

Agreed; I have removed the initialization message.

Thanks again for the review. I'll prepare a v2 addressing your
comments and explain the reasoning behind any design choices
that remain.

Regards

Magnus

