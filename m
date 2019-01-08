Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C2CC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:31:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04562070B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyg7o4mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04562070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z56N2RD0zDqc8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:31:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=deepa.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qyg7o4mV"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z54J72YHzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 08:29:20 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id s22so4337736ioc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AjS78uQSbCdKCPygo0CoQj9gYIa5n4/romkv0n456+Y=;
 b=Qyg7o4mVqxawxBe4EdUFL8t/+X0LIBjR+JsHbwPd4l3Z+vmPATWIB59hpJiCBMydC8
 SKW9spP+0tNfpVYcy82Z5dESPcfxlob9rEHguF0roulT7lyvt/ILd6wKGZ33ksfvgq0u
 kVmiYVIMwRkRUM7FSi1ayrMZUh9bGHqC22tuqZmfhj4691aF8kPqVKzm5nfxxzYHqD/u
 Sz/8hc0o7YAcUeSCDIpIVcQ+VU/aftIxsK0reQx+7ya+owJ9xh095LUI3bAFrjfU8b8f
 LQpmA+kJKfUWi6LeUXFuEW9LpMNrVQB2dwaq6ox6WZSTnP5nRawvmxx5/QrNEQNMs6Gs
 nUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AjS78uQSbCdKCPygo0CoQj9gYIa5n4/romkv0n456+Y=;
 b=HOiOnr0a1+9C2jI7/ilJof9BtG4eCsBjWvj1yMeuBIVAW01tIbAMNJAbOkjectgttb
 QyOJh/dh8sKooLetSg6P3SpLOUrQiza2k7tz8D1+d8gjdfqfnU/d1pPgOgPqSkqq2JQc
 C6RaETjoe5sUbNNUColt4AFyuu8lk5EoR3uh/i4ehK2cmMUeLO2VByyYHtO0pGuhIDLy
 Yg5SJNi3XDafU1n2HWmFzTyS+5ru+EfiLUFbbhNbgIxSV+rtAFgUTCAdn/G1x3IeIekL
 qAlOCnB88rivRd0iFXQDPdtvvuEnwe2R+426IhYd3dB2FW3QIXv/PpJcMCaswdOtO70u
 PJDw==
X-Gm-Message-State: AJcUukfJTYyyKH1vPk0PHl1qBWV36eq/DAikF9xnAVkIUx72u849hzi3
 ODKdsaZ2QmV81AK3RQZ7UEd1NXyjJyUguDtpnIQ=
X-Google-Smtp-Source: ALg8bN5SW1k1cSp+b8s5Z3lPIKWAfapgdrB+ci7GO15oZ8FdL206oogHrlJ7RwN11610nK7mA22HPpd56e+aazMhpXU=
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr2015591iod.184.1546982958943; 
 Tue, 08 Jan 2019 13:29:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
 <20190108200959.1686520-1-arnd@arndb.de>
In-Reply-To: <20190108200959.1686520-1-arnd@arndb.de>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 8 Jan 2019 13:29:09 -0800
Message-ID: <CABeXuvpprn_AXF0ama9CsHyZ1yb8FuUH25MXauLzHyahxr+Vwg@mail.gmail.com>
Subject: Re: [PATCH] socket: move compat timeout handling into sock.c
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Networking <netdev@vger.kernel.org>, Helge Deller <deller@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
 cluster-devel <cluster-devel@redhat.com>, ccaulfie@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 8, 2019 at 12:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is a cleanup to prepare for the addition of 64-bit time_t
> in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
> unnecessarily complex and error-prone, moving it all into the
> main setsockopt()/getsockopt() implementation requires half
> as much code and is easier to extend.
>
> 32-bit user space can now use old_timeval32 on both 32-bit
> and 64-bit machines, while 64-bit code can use
> __old_kernel_timeval.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This will make the other series so much nicer. Thank you.

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
