Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9493C4167B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Dec 2023 18:14:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=myQI1JR1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SkWys4FF6z3vng
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Dec 2023 05:14:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=myQI1JR1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SkWxy22Yjz3cW5
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2023 05:13:42 +1100 (AEDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77d85cf1ff5so308527185a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2023 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713619; x=1702318419; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv5W8UxLCR/5ceJa4BXZdc/7xUY5p3Shixmo6OvaNl8=;
        b=myQI1JR1wYfWuY7Vp3vIh6E/3MIVUYAhjusVyO7vlbD8r0PW9JbVeiFn0q1vgN4Pnm
         AMTSv/tzGZRKoDCsgGEOyFavey8dUsRYpbPhTUE9o2mterzNTkVJGrLD3uj2pwTw0hox
         Z67Ig2iduRkOY32K60E4oCEmbecy+q/4rQIlWtz4Fe9yblRkcRkRq43ewrpOAsWa4AJa
         NvAm1YSBYU/MXYlhaG6WwoEDqzPsj4dYhe3uSY0sqai0reJwerpkc0XX9fGa127RMujl
         Sv42boRS41oQjwpFOjtx7X00AnxgLTnQs8zkuhENhJ/fkvRbLYYswEmccyA6uuIrc65N
         r4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713619; x=1702318419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv5W8UxLCR/5ceJa4BXZdc/7xUY5p3Shixmo6OvaNl8=;
        b=X5/wUdUzkYHNA+DGNi2WAqPNodO9DrjMau8iL52864XlD+GqqTDZHwoYyq2YaQ1WK2
         /GasS9eFRpW5ys+LBt9Z1cc8OAiwqlFO7rOUtZACV1AnVhPtziRsKVek5usspqHhf0I8
         TdZGJBcXnSuPgIcd72yMcq2bUeehhDjRB2XqYFj2SookoYeXpdGgcrcNr3miXdv/lF5z
         Tsst8McUvGK+j6BxVMTIX27tkpRPa9Md9QhoY62P/7pJ1rc02iIxHRbFa40w7zVGrYWV
         O8erNfPp944UkDw1WT0jauhl93J3KajA1PLV0kJwXb5f4acG149G07vDkRO+8DcKh4X/
         YNww==
X-Gm-Message-State: AOJu0Yxn4wX6mFbSMW8lOpISYWPZByTOn+wV+NODvjiy3dPtcjVvwNm8
	ZJCiqytinzg2E4+Z5btEjgmIbAOBv40cwm2f/fg=
X-Google-Smtp-Source: AGHT+IHDD5RoF3kCsuQM1b2t3YZgwiiRD95GHo5n9uXPGJLfvqKzVllX46OCHT8qfyQ/Iw/ykvNMOOKfu8qZWH64NAc=
X-Received: by 2002:ad4:4384:0:b0:67a:d891:fd75 with SMTP id
 s4-20020ad44384000000b0067ad891fd75mr567320qvr.129.1701713618841; Mon, 04 Dec
 2023 10:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204180603.470421-1-gnstark@salutedevices.com> <20231204180603.470421-3-gnstark@salutedevices.com>
In-Reply-To: <20231204180603.470421-3-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Dec 2023 20:13:03 +0200
Message-ID: <CAHp75VdxB+qEjLBq1M3Zfrh4_gnJOv70BRb1RR7+KeDWcPE6jg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] leds: aw2013: unlock mutex before destroying it
To: George Stark <gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, vadimp@nvidia.com, mazziesaccount@gmail.com, kernel@salutedevices.com, lee@kernel.org, linux-kernel@vger.kernel.org, npiggin@gmail.com, hdegoede@redhat.com, pavel@ucw.cz, linux-leds@vger.kernel.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 4, 2023 at 8:07=E2=80=AFPM George Stark <gnstark@salutedevices.=
com> wrote:
>
> In the probe() callback in case of error mutex is destroyed being locked
> which is not allowed so unlock the mute before destroying.

Sounds to me like this is a real fix, hence the Fixes tag and being
first in the series.

You free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
