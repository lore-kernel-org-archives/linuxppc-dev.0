Return-Path: <linuxppc-dev+bounces-29436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC8CC6B12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 21:50:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j47Kn37zTz2yh4;
	Wed, 14 Oct 2026 08:50:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791928205;
	cv=pass; b=T+CNB4VzmJuNbHpBgXN0azcPqQgA3m+zHlINN4RoDSYxKvhFWOuCJXooSzE97Lc6CXFkTkLHr3UqzyyBqEJ7aE5QUqBJuucNLHvjtkXDAbIq7YKifXWr16NjzP2TGlaAL+Cr8Wy3/oVrlDrL/cvnxePvd8Py2iuzUc1YMrV9jMocU7Zqlhrz6hRYUDDaZYX1El05wn0QPiCdL4sO12mCEo0Tug6GJiQIrhtAzw3UCOZL99nKRPDVbZ2ae7NKSxjHXQkdsXwF9mg015WyS2k6ucV1LICzlCyTSPrmT/R3doTendXdCq+VA38WmGwqHVgsD7AjyrBqASfi54XCGbC7bg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791928205; c=relaxed/relaxed;
	bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqqSguf2VCZ1GROtPz2h6LAeJ/JXTpP2Z6DS9sTzR97SLGFttOvJAx18gkVuF6864kZW0IDEb3ayLuCAso7aVX/ICyGELVEaGOxk+/sSXWg01Ql+uytxDyjanzHDoJT/b35r+SCsmXTLyRUmXg6bjNEGree/dbm815sDbcherX79gbUsSbz8gC458pV+gWcZCTn9WHDLhklfgVzHoSqbXKtlNtXsZyhXBJgGetc4r8cB0LAEqHGbVhJH7ak8AY+4kJ5dveyYRikGAAmVHA3XS3mo1FWVo3E0jcaI7Ce3H4D7RC+Yr6eL2O2YR8toa8Zip51OQAGMI8eiinYcl0JBLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pj8gLbat; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pj8gLbat;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j47Kl4GPCz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 08:50:02 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6b1cc392d8bso495003a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 14:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791928194; cv=none;
        d=google.com; s=arc-20260327;
        b=mzaJMKp5vYTHerEcvEooMkcLEqAfm4uG3iTqUQ0tjy1yvjiu+/MbToI0a4b73EaitL
         jiSoVibqJ/gUHNA8Pp+4NMzis3TKsBuh7whCnwuSXrjdosgj8Vv8tfW5iFO31fFSUoGs
         o/wTRbmyZwDn+KR8pvHXgXKWQLLoRLgOwuGS4aQjpBGwl7hdwbgtD+bAgpFIYiSsYdYf
         KnUDqP6R0ij21lCrFNu5sPpynbdss/m5pm+ad7d/iKJRrUZ1VBHjO0TIUQ5jBDdERy78
         Hlwk1HbFQ+hSh2oO4G7sqMYxoYsSP43Q7c7d2ZhuuFKY3/oHgEH+Ir2LqYvEZliCVFlP
         JDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        fh=N+pV4vje2BQ0JDmR6fxRfgxSv1FdUFIWJW1FUweu1yc=;
        b=mQq9jVbtkFyFfFCtV2yZAAT/uY2TpuljoA8DWMJaJoWwI4evH+6xPR3zMqjBqUpFnQ
         1xGmOxzW6XNNtdKW8y46S5XsQO1cHKZWjL8AktT2+3GnugghpGJt1tlYxaWrj7+RF2Ra
         sCSwGy8H5Oyx6LUp0PneqA7rIlGIHnB/+DRC6ci/j/4PBKVg3X5a2o55lAG472Fz8exp
         0ONQMP1Au0hZsOJwi95esLnB/bwvBYZUstJ7G9cANR29F/sqTHijPixkprRLKFx7aemU
         XJxlVNkAuIneKHLDB1qNBzaeEjCBinilANCRDrDBaYgEh+QMeIwhgHTgeL9q8btTrODV
         SQVg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791928194; x=1792532994; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        b=Pj8gLbat9UOF5EXG9B4hEZUTTXwUggLCOQSgzRh1q4QZ/K5co8TxBEpIhtHKO++D1B
         2AlkLxlPTG9T4dYikl22kKGwFPl03Ls9NNQYsoK2SFKNZW5ApUJKwpSxH6JPlRlKXq4W
         HxCExXQuSTv1foRWc6L8ynZR1PCrSatBqEbWFuQ+oU4AsihIzTfN7cbXSA4+jHnih5Ld
         0xAAXZY/Oahyrwc+YdTCXrZX8mr+F+nRLoKuMXDx/6klHt2lGzuTyAEYpF6t1vT/CZmO
         XbTSxoHlbfIlkGDk+J1vEOgk7kkH0j26Vfpt5kMKI9jbsDRUsCbwNZ6Rh33Zu0OO44J/
         kRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791928194; x=1792532994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZPrQT2G0Mv3qvoWmFl/L9HCd8QbTElzi8/7c9AFh2A=;
        b=1oFjqyIMehOb9KM6TUElVx6IG/Of7CkZTVSSCA827m2JEMzBJfbr3MM0ttRnLuK6c9
         KcZBvuuUsN0dNaIbzk1Vf98y8ay9fy9sFdnEaBsvjhG1ROCtHJQE0ZiuMqef06wdd5mi
         v9bbnlf9cFiRBYbQCcmepcrps81wvRUNeysYmgshwO8ZFCgFyFCLjr+3MSyhIu07EPSb
         UpwGwtEbDkOzkyQIO9QMxjKD3frN/GWQwiQyqFRXPkZMtESW0ssntnGZ/eVPXWjsu/2V
         DNkizpH7drkOAuaJXEZRtP/bTdfzMOEQe8aAViYthYEZ7wo8XZfjDIpqmFcPD1k3yRuk
         bKbw==
X-Forwarded-Encrypted: i=1; AKwUvByYw4LRu/ken5aS3bi4r8AmXisIpHRZGNYDAfZF89XKbIX6PvhUKwXRRqJZwj6VqAF7CgtuDE8TWlVr+c0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ+C4C6tLorCzMzmWg0JXLV+I5HeP1Xj0nutXR/4CoveMQ6+9Cy
	l5nKDgSaRM4wkVD7fhEMXjDH7JstRb4pA26g6/wWtnsXLAViAc/c5z8LOeNIrluUb/P7CCbfQDb
	rLEOEcPStN7WHjWjnoWqCbfzNHXYe+0g=
X-Gm-Gg: AYBFou2K9v1VUsETd3wp7Xdf/WFOph5fqJAnVVxJxgmjaAmacC+7ym/zF5FfBs++Njz
	Iz3z9IJOkH/NA7/sTdPyfsA88N43iHurwoc0SCI1FVcLSMlwa3DRv957L/+wHD+AU6HpPdPBbAe
	w3JfJzheA4AQGvZ+UkVjC+gdZm3v3ow4brYexndyC1ngAEJ4t/Hz7zQSB56kDSNF/9koOl0Ic3N
	/RbFw8WWNjDJ7vKg9T5ZQjSriMAoJr3LZIF/baaT1VrnESNdPcTPAn6s+d9WqyJANPX6KxPG1jS
	SB0nsAz8FPlU/aa8FaFXYscJZsa5Isyb8RvD4XU+UsCl978PGGbf3TXHY08QUz8kUQ5cp4rSxNp
	kLDiA2U9WHjagAE9j/tJ4Knnsb5tq38lAIpDG7fMEpQ==
X-Received: by 2002:a05:6402:4006:b0:6b1:c526:afcd with SMTP id
 4fb4d7f45d1cf-6b1c526bc10mr5749588a12.11.1791928193882; Tue, 13 Oct 2026
 14:49:53 -0700 (PDT)
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
References: <20261012184826.986050-1-linmag7@gmail.com> <20261012184826.986050-9-linmag7@gmail.com>
 <2026101313-plank-outlet-d3da@gregkh>
In-Reply-To: <2026101313-plank-outlet-d3da@gregkh>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 13 Oct 2026 23:49:40 +0200
X-Gm-Features: AclHuK9ealETNMhI5yAH6CuVcBjpteVRfkO1A49G7BEeIOYibyNYpBtxXrN7t70
Message-ID: <CA+=Fv5TuSDvXc0kXkTVHSver1znah2pbMofgrfMFmiyCZgHfGA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, 
	oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Oct 13, 2026 at 3:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 12, 2026 at 08:48:09PM +0200, Magnus Lindholm wrote:
> > Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
> > the firmware model and console endpoints before registering it. Keep
> > firmware buffers in locked kernel mappings and serialize their use in
> > atomic console contexts through the existing SPARC p1275 interface.
> >
> > Poll input while the TTY is open and synchronize close with timer
> > rearming. Return zero on no progress so HVC retries buffered TTY output
> > but drops stalled console chunks instead of spinning indefinitely.
> > A firmware call that does not return remains unbounded.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > ---
> >  MAINTAINERS                 |   6 ++
> >  drivers/tty/hvc/Kconfig     |  10 ++
> >  drivers/tty/hvc/Makefile    |   1 +
> >  drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 219 insertions(+)
> >  create mode 100644 drivers/tty/hvc/hvc_m3000.c
>
> I'm guessing this will go through the sparc tree, so:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> thanks,
>
> greg k-h

Thanks for taking the time to review this patch,  I hope to
get the full series through the sparc tree. I'll pick up your
tag for a v4 which I'll send out asap.

Regards
Magnus

