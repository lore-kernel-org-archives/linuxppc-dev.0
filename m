Return-Path: <linuxppc-dev+bounces-19942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BBAF9B5E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0t8n52rFz2yr6;
	Wed, 22 Apr 2026 18:45:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776847529;
	cv=none; b=L0EY1HnfuUt3lDxyvxrgHvT+Eh7u3osvpSkmroiadzhk5rU9q+8gdlM0ut48/uMclK9xX8LxIYvgb/dGG/338nrOv+8Glr1feVoOI+0b89aZwguTynuogWje7dO9QhxWVUbnQ2PqJ/LGuM2rxOdJ1TaOgbJ85Hu1f1TIKTN3B9JxV0djiBObSqSo9+68VmuOJaWZE6fyVYY6i4E69DDORubCfIHKeU5u04LThvCehNnbztVRVTspqYkFc9XKkBbUHpypDS9SM1IS1RldLCP3Qpb+CX7QRS7H6hzr78x/yPnNQZDfhj3luwUkoU2OOV3Alba5lC/WBLuzSXFHByBCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776847529; c=relaxed/relaxed;
	bh=5nzzWLRM14gCMo68Gw80lFQtpEDbPKU5oX4IPo99Eck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYuPEXA22/5JZ/Mo2YaOX01g1yAFmCAcUSQ00o1uy/dX6W6Tgc1IlgSBYC80EE4dw1b+YqPqKHI1wGqF5NGGtNleNeqbxe2jetYl/CdoCFYfJm5CMswvmTpOD0vS7nlCOd2xS6pu8fIAbvXA62916HseDGHGuXKp+syxQLS5HUkEsKdfWAl7mql76Dn5EZ9OgZlWBfiDB+3YqKk2g/I/9rTGv8T/wrKPfvGqovk30mAMuQv1sHR25ITQpRUL6oyr7huQq1KeYMnt4mH1C54A5aswuLB0n3WkHlA6jl7unQ7rcBomwO4UQopcJCfDQPmKDm2qTD48pisMIw4hX2GYgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MAD3is3O; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/Bhji4fI; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MAD3is3O;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/Bhji4fI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0t8m0T3Pz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:45:27 +1000 (AEST)
Date: Wed, 22 Apr 2026 10:45:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776847522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nzzWLRM14gCMo68Gw80lFQtpEDbPKU5oX4IPo99Eck=;
	b=MAD3is3Onv/bOoBKuHW1wjcyHz3hqI5+C8cujYrIRrVdVoiOk7KoPQDqeGdfS4jY4GsLsL
	5/NjXwT5Mrh7yksrlTvQ3PT/ZxGQ/OURO6/DesrngJ5MX7ca7B7Kg/AGCe64m5rlpQqjdz
	xi1VS870d+XZ7e4I+m2K0VS/L4cj+OvtThVrt1ny5H2u+H0vm9BaayokR/CiL7thy/fXVG
	kWxNmwlPTHHZe5jTDfkSPhYbrqHFd+ypj5okMZ83AptMUUuGygg+VRjBh9yCIXKbKx1pia
	oB8YQPpua44CNAZMcTstbqrHFPkwTCyWCC5pQC88/vzCL2+9Wm+Oo+Pyjqpvzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776847522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nzzWLRM14gCMo68Gw80lFQtpEDbPKU5oX4IPo99Eck=;
	b=/Bhji4fIjCMF4t0dR952vgbdwty6z6aPQaHTJdOrpBjUy17nyVrWYVxSyPyGyzaKeRuBp9
	CZhbFmLv4gXeQLCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: New warning in linus/master
Message-ID: <20260422103218-1efdbb73-51fa-48c9-ae92-75306147d61f@linutronix.de>
References: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
 <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
 <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com>
 <20260422092713-4021a1a5-3a54-4260-878a-aec1bef3f8c7@linutronix.de>
 <CANiDSCtfiPDiqzhjZGoCJbLC0fRoH1HLKrvYUt7jLDYEBQHqgg@mail.gmail.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCtfiPDiqzhjZGoCJbLC0fRoH1HLKrvYUt7jLDYEBQHqgg@mail.gmail.com>

On Wed, Apr 22, 2026 at 04:06:45PM +0800, Ricardo Ribalda wrote:
> On Wed, 22 Apr 2026 at 15:32, Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Wed, Apr 22, 2026 at 03:00:11PM +0800, Ricardo Ribalda wrote:
> > > On Wed, 22 Apr 2026 at 13:57, Thomas Weißschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> > > > On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
> > > > > Media-CI has found a couple of new warnings in the latest kernel
> > > > > version for aarch64 and powerpc. They get fixed with this patch and
> > > > > before moving I wanted to know if this was under your radar.
> > > >
> > > > Thanks for the report. I was not aware of these so far.
> > > >
> > > > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > > > > index 7dec05dd33b7..65914842fae0 100644
> > > > > --- a/arch/arm64/kernel/vdso/Makefile
> > > > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > > > @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
> > > > >  CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
> > > > >
> > > > >  ifneq ($(c-gettimeofday-y),)
> > > > > -  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> > > > > +  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> > > > > -Wno-maybe-uninitialized
> > > > >  endif
> > > >
> > > > (...)
> > > >
> > > > I'd like to know exactly what is going on before suppressing the warning.
> > > > It is a non-standard warning, only enabled by *some* of the vDSO builds
> > > > for some reason.
> > > >
> > > > > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/pipelines/1649144/test_report?job_name=cross-gcc
> > > >
> > > > While I was able to download a configuration from this job and also use the
> > > > same container image, I can not reproduce the issue. Is the configuration the
> > > > full one or only the template?
> > > >
> > > > Could you provide full reproduction steps?
> > >
> > > You can try repro with:
> > >
> > > work/linux $ podman run -v .:/workdir/ --rm -it
> > > registry.freedesktop.org/linux-media/media-ci/build:latest
> > > $ cd /workdir
> > > $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make allyesconfig
> > > $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
> > > arch/arm64/kernel/vdso/vgettimeofday.o
> > >
> > > The gcc version discrepancy is because I the error was due to old gcc
> > > version and I was playing around with that... but it fails in both
> > > gcc14 and gcc15
> >
> > Ack.
> >
> > > You can try with debian testing with
> > > work/linux$ podman run -v .:/workdir/ --rm -it debian:testing
> > > $ apt-get update
> > > $ apt-get install gcc-aarch64-linux-gnu build-essential flex bison libssl-dev bc
> > > $ cd /workdir
> > > $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make allyesconfig
> > > $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
> > > arch/arm64/kernel/vdso/vgettimeofday.o
> >
> > Both reproducers do *not* reproduce the issue for me.
> > (It is more or less exactly what I tried before)
> 
> 
> Ok, I think I found what is going on. media-ci was forcing
> KCFLAGS=-Wmaybe-uninitialized
> 
> https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/test-build.sh?ref_type=heads#L29
> 
> And something has changed in the kernel in the last version that
> triggers a (hopefully) false positive.
> 
> can you try with:
> 
> CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
> KCFLAGS=-Wmaybe-uninitialized  allyesconfig
> CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
> KCFLAGS=-Wmaybe-uninitialized  prepare

That works!

The warning was introduced in ed78b7b2c5ae ("vdso/gettimeofday: Add a helper to
read the sequence lock of a time namespace aware clock").

It is *not* a false-positive, specifically:

do {
	if (vdso_read_begin_timens(vc, &seq)) {
		vd = __arch_get_vdso_u_timens_data(vd);
		vc = &vd->aux_clock_data[idx];
		/* Re-read from the real time data page */
		continue;

This 'continue' jumps to the end of the loop body and if the real vDSO datapage
by chance has a sequence counter of '1' will exit the loop, leaving 'sec' and
'nsec' uninitialized. My believe was that the 'continue' would jump to the
*beginning* of the loop body, which is cleary wrong. Previously there was an
inner while loop() which would make the 'continue' effectively start at the
beginning of the outer do-while loop.

	}

	/* Auxclock disabled? */
	if (vc->clock_mode == VDSO_CLOCKMODE_NONE)
		return false;

	if (!vdso_get_timestamp(vd, vc, VDSO_BASE_AUX, &sec, &ns))
		return false;

} while (vdso_read_retry(vc, seq));

vdso_set_timespec(ts, sec, ns);


I'm working on a fix.


Thomas

