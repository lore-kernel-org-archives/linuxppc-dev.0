Return-Path: <linuxppc-dev+bounces-29268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833F1CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:58:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3LF170y8z2xSV;
	Tue, 13 Oct 2026 01:58:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::629" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791817093;
	cv=pass; b=YG2DVadqTOMOBADBP6A7ocmOAzFUAr79S4hEkz641bKwRZkYGlOmd8pWitNz+3DpSAL+N9rikJrYSjF5t7gCQ3Ho82swSzyFR14nPys1Lz08N7fW4oj30XPv9AGQ6dh46IZAom4HYoqD1rHFNjZfW05LGYu7xk04OQ4G/J6zgUIrN8aZI69pT0ErfCWw0M/dGNkVz9ZQnxgvABZAXQhq48XvB5/qINfASUew5gBcd0rY0py/B2Xyo9aa9hS0GpY78sDtx7oHZMzuvKwcAaMuaMShkCSs6yLJ5T8Xhu3XaN1KAfRVQQ4JB4A6tZbETUjoLJSddYZ6KiFLm6Gz8dTSIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791817093; c=relaxed/relaxed;
	bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc+qqZIPxsm4wvtIJDiFzIif7+u9f/VsVhyms8GkDAY17D9YuAWU8GXZN0pYE+FyqBVXsbgs4HK89TAqun3i+Oowj1QbB9cVSd7aQV5r7PyKUTiNdXZIQBNF/+fbJA+lKy9rXYrO0nVM+/6H4YqKE37mxXbCisFvDjhGaVOgfxDyIYO8MGwGpIKa6a/33XbteDUTldTRC++QsW2bqDGSEG+kitsKx/U6H4u8HO3/UbxRSotxhhYnN8uRg8CUh5hCxf0Ntw1eF0B9Dp5TFIMxcecALEHoFrOsxpaKdFGtAXA0IpfObHPdUBLTVOBTPNt/DxO+v68zq60i1qqlg/C15A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a+/8hxPI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a+/8hxPI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3LF01nMLz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 01:58:10 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso337915966b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 07:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791817086; cv=none;
        d=google.com; s=arc-20260327;
        b=ms3yJucLCp0uUKTu1EoR9bal1Wdbl5dSb2FzuFBt2dA0vUqC1c47vpHyXh2o7tmcVP
         yCtVYMfvx1kUkwYvsa1gg98j5yCFpr/k3QBAhs0JFNzYwhAaKBd3bs53uuMTMOQsEk8U
         O2XcSP3kGYj3p0EjfnZ+QIc2lNRlHrmEVLiR9qCmGiV+MeBDqZ5/QQaVIPAfv9Ce5QPw
         zWf/FZ6+hFJR3fTn5XNSxAHO5Qex82SyFt8bc4+ibaX3bQXAtiBQ8lTIuyTeH/VBcGVC
         xhJKD3+/eSEfyijD0wsxvHMmsmZPw1F37Nh6I/vLIyfgV0d4Cpw/5tufeMeIFdRBrn0a
         JH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
        fh=t1/nUiFDXU+JCOcMruKeBQSECyAq18SqgjnSc921QPc=;
        b=oV5W4I+qiYR7wVdDm1L+vk3Fy/BHPpb2fJRAkO7Dhynlc2mP8qvf4Uy8yfaFqu/HiO
         8FPtyp8NwjrmP0v5u2JzeDOmaBRv+xYbKt+KCzpB5smDtGrTapnIq+qywadU51I1cJxP
         JIYDgEDLNLDVlscuZ8xIooqZn3BlQNcFvuPW9VRzwCZolLMVIBtEAm7SuRR3+HiW0Fwl
         vY+VgOc8JpjKVTf7TWiGVmz0hy4AzcCV0J6b6nryjj4t/LYgmQ2DYlI8e8mBKOenSB0P
         PYPBonlRV0xlHWc7GGMGv/4CnK6MszVIwLYDX1p/RbGhXWRTw2WwOkaqW9IaSUOWFSCm
         7zyQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817086; x=1792421886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
        b=a+/8hxPIpoQx6dW168ERqAuBD+06cGdJPupgNOmhhBm078lUt0CUV7lKj55wjuiFJ+
         GROMNnyHcwUyQdSHPhLsHAB2TnYxei17LgRJNXYpi5pSrpwWyy+gl5mjVKPg0ALUQYo5
         hDasX7enJoRXMh3JXwzFkpRrE79NZVKkOFbd/rQaJ3owCjNjsSOtM1oh20/EzzLwDUw4
         jHLSOEZo5kd3fBvUaTxbeRm5alMm2W5u4MYYQQb+Mj47q+ZnSLHMmAvPvFPXRhG+K5Zg
         vjtzVjj6lL+9ATRqIAGr+zQy71CjSmBT/1AMPv6w3P4AZyuuZ8OAtlGbKyAS1g1tjvGM
         fgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817086; x=1792421886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
        b=L3WV+fBGTMURhYLrltkoHmkiWIITWE7x7UglUGOPmFnztvS+V0h4nq2BGqDDrBRaBX
         Ew670FB0gxEkCnqPB7gTt1IwNJ7mk0LvG5eGfcsU77Q+/jrlMdokTRfDBAjOD9zzO9Cf
         yylmsgtlKDXIaZRqx5YvDHSWm5mVpQjgecyMC39JSIdBm4hiQPpMEhlvmGZA1N2rDgsg
         BnooEROPfUBlePnBCaP6iGFZvQcjuw1xUZqwYF7iA063Y+G72roOHQENFdd+yzTs2TYT
         2fkRj36nYuKcNKkI0HA+nw7fld+cmWss3TsURc6o+5Iw+/9vNvf+gUGFfDjrQTDlaiG/
         2lvw==
X-Forwarded-Encrypted: i=1; AKwUvBzy5/arzX8LwqItys2dQh7/hdKmhQKXag7sP6LZuwrPTeEDXFZVXGcwfwcSAsRl9j8ragJcIn5AoORTQ/w=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIbAFa5bTqGjMqfBQ+EGKemCKXEbwdnJkB8pAZtfv3lIcRxI42i
	P2hwc/UR5bQw7Yc1sAH6+w542I6E1xN4ujLqZCFq7PSRA1fp5EzipZ9rEu1KXHBuoP2rinEBcQ3
	D3+16TOGqpFes/6VgtFU/nwWYq83mWUg=
X-Gm-Gg: AYBFou2dBdIWIamPqfXYp8Bn65hhihSCNrC5xItqHvZa2Rud/LTiFPmA4s2nqJvW3PI
	TuEgwI9mV+a8InY//YB0OiqLHF3G8GTQwwUNsyLINOI8wJ86EG3qNpgnDSOKLtOcdMDzwJ7QpyD
	lk5ZfOnrS6y2Hj4/mouqjSo9jxTI3OGHn2LD0MxHDezxjTowMXz5fn0hoQHarZ7IKqPUSGnrW0Q
	DdipU1tOGlQMXgqSlTQdKX9+FJdkxSWBygKZbmtbceNLncozDC+DPk2LBUWRhwbdVE5bSsiNBj1
	maY/vaOD51Nz6fMTaWjUhLEaS9TfU0725iKDuhwe43IWB4v3hFY7mBZ10geeQjfB9SDzFCDAFn5
	3Cmonrm5KiszTSJQAf4EhkZk/rF9fKZspOzVloHN+4A==
X-Received: by 2002:a17:906:4790:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c31a9a10e7fmr977505266b.3.1791817085896; Mon, 12 Oct 2026
 07:58:05 -0700 (PDT)
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
References: <20261011195729.981243-1-linmag7@gmail.com> <20261011195729.981243-7-linmag7@gmail.com>
 <1f66c850-faa7-477f-9535-761074ccc077@kernel.org>
In-Reply-To: <1f66c850-faa7-477f-9535-761074ccc077@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 16:57:54 +0200
X-Gm-Features: AclHuK_IcZyjHiUIK3u3hTnPLckXjpGLARIbdXHePuP-SPEHyVHxb2JKX2D2wsY
Message-ID: <CA+=Fv5STgFEmKU7V7rAE1-CSCnYHN8e=TA=mNDT8Wp_HBZzu+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] hvc: add an M3000 firmware console backend
To: Jiri Slaby <jirislaby@kernel.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, 
	oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, Oct 12, 2026 at 8:46=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 11. 10. 26, 21:55, Magnus Lindholm wrote:
> ...
> > --- /dev/null
> > +++ b/drivers/tty/hvc/hvc_m3000.c
> > @@ -0,0 +1,205 @@
>
> > +struct m3000_console {
> > +     int stdin;
> > +     bool ready;
> > +     u8 buffer[256];
> > +     raw_spinlock_t buffer_lock;
> > +     struct timer_list poll_timer;
> > +     struct mutex poll_mutex; /* Serialize open against synchronous cl=
ose. */
> > +     spinlock_t poll_lock; /* Protect active state and timer rearming.=
 */
> > +     bool poll_active;
>
> Perhaps group these a bit better, so that there are not such holes?
>

Done for v3. Reordering the members reduced the structure from 344
to 336 bytes with the tested configuration.

> > +};
> ...
> > +/*
> > + * HVC's idle backoff can exceed the firmware input FIFO's capacity.
> > + * Wake its worker each tick while open; keep PROM calls out of the ti=
mer.
> > + */
> > +static void m3000_poll_tick(struct timer_list *timer)
> > +{
> > +     struct m3000_console *con =3D timer_container_of(con, timer, poll=
_timer);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&con->poll_lock, flags);
>
> Any reason not to use guard()s?
>

No particular reason. I've switched this to guard(spinlock_irqsave).

> > +     if (con->poll_active) {
> > +             hvc_kick();
> > +             mod_timer(&con->poll_timer, jiffies + 1);
> > +     }
> > +     spin_unlock_irqrestore(&con->poll_lock, flags);
> > +}
> > +
> > +static int m3000_open(struct hvc_struct *hp, int data)
> > +{
> > +     struct m3000_console *con =3D m3000_console(hp->vtermno);
> > +     unsigned long flags;
> > +
> > +     if (!con)
> > +             return -ENODEV;
> > +     mutex_lock(&con->poll_mutex);
> > +     spin_lock_irqsave(&con->poll_lock, flags);
>
> Same here.
>

Done, using guards for both locks, preserving their acquisition and
release order.

> > +     con->poll_active =3D true;
> > +     mod_timer(&con->poll_timer, jiffies + 1);
> > +     spin_unlock_irqrestore(&con->poll_lock, flags);
> > +     mutex_unlock(&con->poll_mutex);
> > +     return 0;
> > +}
> > +
> > +static void m3000_close(struct hvc_struct *hp, int data)
> > +{
> > +     struct m3000_console *con =3D m3000_console(hp->vtermno);
> > +     unsigned long flags;
> > +
> > +     if (!con)
> > +             return;
> > +     mutex_lock(&con->poll_mutex);
> > +     spin_lock_irqsave(&con->poll_lock, flags);
>
> And here.
>

Done, using guard(mutex) and a scoped spinlock guard. The spinlock is
released before timer_delete_sync(), while the mutex remains held.

> > +     con->poll_active =3D false;
> > +     spin_unlock_irqrestore(&con->poll_lock, flags);
> > +     /* Block reopen until the callback has finished and cannot rearm.=
 */
> > +     timer_delete_sync(&con->poll_timer);
> > +     mutex_unlock(&con->poll_mutex);
> > +}
> > +
> > +static ssize_t m3000_io(struct m3000_console *con, u8 *in,
> > +                     const u8 *out, size_t count)
> > +{
> > +     unsigned long args[7], flags;
> > +     bool input =3D in;
>
> You can test "in" below directly, right?
>

Yes, I've removed the boolean and now test "in" directly.

> > +     int ret;
> > +
> > +     if (!count)
> > +             return 0;
> > +     count =3D min(count, input ? 1 : sizeof(con->buffer));
> > +     /* Console writes can run with interrupts disabled; this lock can=
not sleep. */
> > +     raw_spin_lock_irqsave(&con->buffer_lock, flags);
>
> scoped_guard()
>

Done for v3. Reordering the members reduced the structure from 344
to 336 bytes with the tested configuration.

> > +     if (!input)
> > +             memcpy(con->buffer, out, count);
> > +     args[0] =3D (unsigned long)(input ? "read" : "write");
> > +     args[1] =3D 3;
> > +     args[2] =3D 1;
> > +     args[3] =3D (unsigned int)(input ? con->stdin : prom_stdout);
> > +     args[4] =3D (unsigned long)con->buffer;
> > +     args[5] =3D count;
> > +     args[6] =3D (unsigned long)-1;
> > +     p1275_cmd_direct(args);
> > +     ret =3D (int)args[6];
> > +     if (ret > 0 && ret <=3D count && input)
> > +             memcpy(in, con->buffer, ret);
> > +     raw_spin_unlock_irqrestore(&con->buffer_lock, flags);
> > +     if (ret =3D=3D -2 || ret =3D=3D 0)
>
> That's full of magic constants. Can we have defines for those?
>

I've added defines for the firmware argument/return counts and the
-1/-2 status values. I've kept zero literal as a zero-byte result.

> > +             return 0;
> > +     if (ret < 0 || ret > count)
> > +             return -EIO;
> > +     return ret;
> thanks,
> --
> js
> suse labs

Both GCC and Clang W=3D1 builds completed, and the GCC-built kernel
passed boot and HVC input/output, open/close, and hangup/reopen tests
on the M3000.

I'll put out the v3 asap

Regards,
Magnus

