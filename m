Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C0FC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:46:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B129E2089D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdac1y5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B129E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TR8h3vD3zF3D6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 03:46:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rdac1y5p";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rdac1y5p"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TR653Y71zF39j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 03:44:28 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id c26-v6so10498025edt.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a2OL125LEPk+xfB9QwjOb/qURd6xSk4mr3m19vKmqz0=;
 b=Rdac1y5pOWy/chA/a4t0Ordy/7XVq6E3/ogruulnGipSZS+LMSzkQ8qEkI0BdypYM0
 0uxz6t1jBw9EpH8MifYHrhsruOscByGSC4alXGLA93d8kanIRGvs0FFA2sDZJxSaRyK3
 3dqNtHDxDogtTgxU8WPn9AZ7RYG77HNIEtBe/j6QWL0iJyKvA7i4s9NOkYR6oEk9ZXB/
 IihFSKkuF2Z7M6w+5wYBz2XTGZgroNsjhMsLLHrRJ+d+bkxwH3yKjZozoB37fclrdvm4
 cNG0KVEEnlAYZowMD3vn6eRh6w3FBffW/PA/A7unvrQ/nR7j4hjY9uq109TR7NnsbLgA
 Gq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a2OL125LEPk+xfB9QwjOb/qURd6xSk4mr3m19vKmqz0=;
 b=ebtKQ0/BlOwzIdW7jijXt5prtvLRY+QSj/9JnbC0D+kvQMHm0ii1EHOCVrxyDTOOmL
 v6gWeFsnSco80CaooMFScPgZrsL/uHp90moNCVWEatkWDJhHUFHld9ien0PWbxXvKDqd
 +O0buV9WxYyW1P0BfT4DRpA9fwE6prYRYuAM39ybUbE2a7pTZTouseGCbWfAMFZeG/Tr
 Lyk2lsu6T02MLZlWlPVSYOZ5eZB3jtSfnYc3iOIdSOZQiq6aN+sBT3ySocXs9d3gZ3IZ
 4Il711zUzSLh3LO7aevv5k0YJdZzhLONuJgYYKxYAZ4Hlwzc5EWpoZ0tJo7qz6vuMQ9i
 d6mQ==
X-Gm-Message-State: ABuFfohBR6MQ/MNlLWRkKWpaaIw4wxaiVb36umWyZUx8lGMSaajM5AnU
 9/qGLHp6aSye/xztZZv5ISJCSEkJX376t2Q6RtA=
X-Google-Smtp-Source: ACcGV61V2+OuLHqIf8nOHML6Ub1gNzY8vpZ15btZ9+RL/6N3fejGee8DaK/Khiufxhp47GWDFHzBzTUHMGgbWenjRa4=
X-Received: by 2002:a17:906:3f4e:: with SMTP id
 f14-v6mr23491175ejj.62.1539017065358; 
 Mon, 08 Oct 2018 09:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
 <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
 <20181004101640.t3o7v73fcipsjg3k@lt-gp.iram.es>
 <CAPB=Z-pW6FWEp=0PgphCo-mAh9pPgt0frjz_MkPp6YHuhX3-pQ@mail.gmail.com>
 <20181006122750.GF29268@gate.crashing.org>
In-Reply-To: <20181006122750.GF29268@gate.crashing.org>
From: Raz <raziebe@gmail.com>
Date: Mon, 8 Oct 2018 19:44:12 +0300
Message-ID: <CAPB=Z-qC+Xgwyb=WAD-r_TYWWRRrpLJT6jFzCfKLtkNVn_FDUg@mail.gmail.com>
Subject: Re: Looking for architecture papers
To: segher@kernel.crashing.org
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Both systemsim and my powerpc server boots with MSR_HV=1, i.e, hypervisor state.
Is there away to fix that ? writing to the MSR cannot work according
the documentation ( and reality ).



On Sat, Oct 6, 2018 at 3:27 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Oct 06, 2018 at 12:19:45PM +0300, Raz wrote:
> > Hey
> > How does HVSC works ?
> > I looked in the code and LoPAR documentation. It looks like there is
> > vector called
> > system_call_pSeries ( at 0xc00 ) that is supposed to be called when we
> > invoke HVSC from kernel
> > mode.
> > Now, I wrote a NULL call HSVC and patched the exceptions-64s.S to
> > return RFID immediately.
> > This does not work.
> > Would you be so kind to explain how HVSC works ?
> > thank you
>
> If your kernel is not running in hypervisor mode, sc 1 does not call the
> kernel (but the hypervisor, instead).  If your kernel _is_ running in
> hypervisor mode, sc 1 does the same as sc 0, a normal system call.
>
> I don't know which it is for you; you didn't say.
>
> I have no idea what "a NULL call HSVC" means.  If you make exception c00
> return immediately (as you suggest) then you have made all system calls
> non-functional, which indeed is unlikely to work as you want.
>
>
> Segher
