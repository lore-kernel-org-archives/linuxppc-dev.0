Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1763C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 01:11:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754B364F69
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 01:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754B364F69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzwGZ0b5jz30Fg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 12:11:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=d/S7T1J4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=d/S7T1J4; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzwG8457lz2yYl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 12:10:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DzwG72ty0z9sXL;
 Tue, 16 Mar 2021 12:10:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1615857055;
 bh=5V9OxHYlT++Lf0PAHK5fyrGP3WfFK7LlWpGGyBlMPEs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=d/S7T1J4s+09scWOyTv2VFPvPNANr3og/GfYo5Euvc7alSAUQi3Pb2IP+jZ0Sk73c
 lLlbQF9TYKLSKRtU52OJUxYgamkA6c/pHRmAH6mkLJvl02GAbsLubxEzhdGLcDbfXY
 nYEB+E2vK+CbOHMk7Rh+IFPkrusxthFTOBSPfOzh6HKElNsDiNhqgOO/HfFM5jbOFx
 GfUop7h/1T8v/0V740gyFjwtsFcv6qjwm6H5WCyZGXqjENl5KrFpKWzyYHc68w83KU
 wltn7Jhr55POslYdEzFHThRJQDjHFz6OgsqTjCd2d4lFnGNXtT+cIqurPDQqDZlcqh
 OwaC3yoN7kmnw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: VIO bus not initialized
In-Reply-To: <90e6a559-0908-684c-9156-5f3da2b02e38@molgen.mpg.de>
References: <41c04182-20c1-6124-a221-90aef704e310@molgen.mpg.de>
 <87mtv44zut.fsf@mpe.ellerman.id.au>
 <90e6a559-0908-684c-9156-5f3da2b02e38@molgen.mpg.de>
Date: Tue, 16 Mar 2021 12:10:50 +1100
Message-ID: <87k0q752ed.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul Menzel <pmenzel@molgen.mpg.de> writes:
> Am 15.03.21 um 08:53 schrieb Michael Ellerman:
>> Paul Menzel writes:
>
>>> On the POWER8 system IBM S822LC, Linux 5.12-rc2+ logs the errors below.
>>=20
>> That's a bare metal system, you can see that from the line "Using
>> PowerNV machine description" in the boot log.
>>=20
>>>       $ dmesg --level=3Derr
>>>       [    1.555668] Driver 'hvc_console' was unable to register with b=
us_type 'vio' because the bus was not initialized.
>>>       [    1.558434] Driver 'tpm_ibmvtpm' was unable to register with b=
us_type 'vio' because the bus was not initialized.
>>>       $ grep VIO /boot/config-5.12.0-rc2+
>>>       CONFIG_IBMVIO=3Dy
>>=20
>> The "vio" bus is not a real bus, it's a fake bus we use for hypervisor
>> provided devices in LPARs (guests).
>>=20
>> So on bare metal machines there is no vio bus, the devices that would
>> appear on the vio bus are found via other mechanisms.
>
> Thank you for the explanation. Two questions:
>
> 1.  Could a bare metal system be detected, and the VIO =E2=80=9Cbe skippe=
d=E2=80=9D?

Yeah, in fact we are already skipping the registration of the bus,
that's why we're seeing these messages. We need to also skip the
registration of the drivers to avoid those warnings.

See the patch I just sent.

cheers
