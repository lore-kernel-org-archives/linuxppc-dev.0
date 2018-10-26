Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C3ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 21:48:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7802075D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 21:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W+CivsH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7802075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hd056kcMzF3JK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 08:48:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W+CivsH4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="W+CivsH4"; dkim-atps=neutral
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hcxR5TsSzF3Hv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 08:45:43 +1100 (AEDT)
Received: by mail-lj1-x22f.google.com with SMTP id p1-v6so2468331ljg.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aGFKdQPgiE1MPxeixj4qbzUqAmUsO63g2fKWKdkHi1w=;
 b=W+CivsH44GwxQVN0+5G4EmaRbIhCBK30+b9Zlf7IOLQkK6IFzj9ENP+unVPhfPenrC
 VeWFxmfWwuEGenfsh4x6Ae6supEjQk01JQyHljNIiFaFJPGog/8hA0vgcfvofodccr3z
 WGKyGikKoZFVF5yye/16SVVkRXO2kgXzvPj98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aGFKdQPgiE1MPxeixj4qbzUqAmUsO63g2fKWKdkHi1w=;
 b=d9j2P3RB6oDTqpdL5O+CjgCzDEcx1nMVxWpNGIPt0DlXYCyLbnDzIAG486qNFjPs8Z
 wSnRI5FzNUnXCBlcXyfTk/K7lBZ/HiVUxkwn2xvdDLAYSJHqdvbvWbQRxCdJfzIzXwIW
 lYC2rbPSY6Cz7Gq17aznw7MPY9dcJBSTi0DWDPD9ZvWcLlXU5jWwOK0n4Bhr1tIaChSn
 m0ef4+6BKQdQ9W14fHHDt76l+qAxS8v5iYB3/ly50nqf2XgAdmg+MN9rHOAKtBA9Lq30
 zONi5UlQ++6dWdnXo3Ztf/i3DaSDU3O9KjF7X61dI4m4c9G0rVNQ1yHKg83EkQoOzmkh
 9gCg==
X-Gm-Message-State: AGRZ1gLAi6ehr9AlfHK9DcfW4AS593qCDYILxTCwzJcsAWglhl+dd5VW
 Q8yNEyV0DY5LJJcdW88xvuJnAoZ8/pfISA==
X-Google-Smtp-Source: AJdET5fdkMJl+Yir9uUTfTQszRnMWuTXYiW+kGYLDFpkGCuQECY6XCzs/EOqsRn9tuB3QIzYhQhOAA==
X-Received: by 2002:a2e:197:: with SMTP id
 f23-v6mr3471481lji.144.1540590339883; 
 Fri, 26 Oct 2018 14:45:39 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com.
 [209.85.208.169])
 by smtp.gmail.com with ESMTPSA id g3-v6sm1616327lfj.3.2018.10.26.14.45.39
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Oct 2018 14:45:39 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id g26-v6so1204936lja.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 14:45:39 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr3374876ljh.59.1540589932213; 
 Fri, 26 Oct 2018 14:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <87ftwssg7m.fsf@concordia.ellerman.id.au>
In-Reply-To: <87ftwssg7m.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Oct 2018 14:38:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8hOhDQR61+R2w0YbOnXAmfvWWSvyN9pMsNU8MFF6wvw@mail.gmail.com>
Message-ID: <CAHk-=wj8hOhDQR61+R2w0YbOnXAmfvWWSvyN9pMsNU8MFF6wvw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-1 tag
To: mpe@ellerman.id.au
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
Cc: ego@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com, daniel.vetter@ffwll.ch,
 fbarrat@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 yamada.masahiro@socionext.com, mwb@linux.vnet.ibm.com, oohall@gmail.com,
 leitao@debian.org, aravinda@linux.vnet.ibm.com, rashmica.g@gmail.com,
 breno.leitao@gmail.com, robh@kernel.org, mikey@neuling.org,
 aneesh.kumar@linux.ibm.com, b.zolnierkie@samsung.com, yuehaibing@huawei.com,
 fthain@telegraphics.com.au, geert@linux-m68k.org, joel@jms.id.au,
 sjitindarsingh@gmail.com, nfont@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, dan.carpenter@oracle.com,
 Arnd Bergmann <arnd@arndb.de>, amodra@gmail.com, mhairgrove@nvidia.com,
 Nick Piggin <npiggin@gmail.com>, pvorel@suse.cz, anton@samba.org,
 dan.j.williams@intel.com, zhongjiang@huawei.com, hbathini@linux.ibm.com,
 dja@axtens.net, msuchanek@suse.de, geoff@infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 sbobroff@linux.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 ldufour@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 11:42 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Please pull powerpc updates for 4.20:

Pulled,

                       Linus
