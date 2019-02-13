Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7DCC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 20:04:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B9B21902
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 20:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AwWM04jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B9B21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4409V12kSTzDqW8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 07:04:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="AwWM04jo"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4409SJ5xXBzDqPC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 07:03:12 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id f5so2726732lfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e28LJ4tt7oVJKO7CgbJcVFBqC5tv55Rtb2nhIFWhcsA=;
 b=AwWM04joRrT5vs+hjoL9MmG7srLew3Te9ugMC75SXqOI/2uV0za5cgm9bc8pb8XXGn
 se+TPfIJUY4NYMOtH8GC9BwVPJFWIuFFqH0OPPPOg2Y/B3SCjVdMR3D9A7rLFl1GaaPs
 yUQL8R/8syuf+rS2mMXEgR8kDwmOiG+bDS59I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e28LJ4tt7oVJKO7CgbJcVFBqC5tv55Rtb2nhIFWhcsA=;
 b=OOuaTHF7nzzkrePxhG9IJ1wDAGvDEBvF4+W56ihGSmQBlGwuOZ/rildrpIM4EOfVAO
 MZziQxd0nt84++GvlCBkns7oQVBP1IJ7B+A9XGFHoanC5/vPK+olJylhLw/9lx/sf7UT
 YVwjhTMYNtOqlqdVALrI7TwR5wtaYW6f9I0ief3+u1iAcI9zZUfi+6Bk/3ZaNId85vly
 2YHXx7+zXig4R6JDvTNCqJRx9/3l0vkFPfeqCD25jPe3qTKlAPibC03sQSnll32WFUeO
 lIwLNl4RzaKsdIZSwz9A1ezU6LCT72hmAjQ959HjnHo0l7pTDocsR38x9jgJG6IHgWC2
 qJrw==
X-Gm-Message-State: AHQUAubLI7fukiGsGM2WJn7EqL5d6f5AOwXOUok1vAOBXGkz6LEamIPx
 7aAuSKANVLRXzPH4Px9gHn1sDwi7fx8=
X-Google-Smtp-Source: AHgI3IZg7+D4GY7XTbxvXaFU1dmA/JhxXWaRPCSyQYRRegc60R6aJJjEm2urqZi8/qsQ6Jhdd8zXSw==
X-Received: by 2002:ac2:562b:: with SMTP id b11mr1384505lff.85.1550088188491; 
 Wed, 13 Feb 2019 12:03:08 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id v11sm45441lfb.46.2019.02.13.12.03.08
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 12:03:08 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id z20so2113208ljj.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 12:03:08 -0800 (PST)
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr1404666ljk.105.1550087814152; 
 Wed, 13 Feb 2019 11:56:54 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian>
In-Reply-To: <20190213091936.GA22829@shao2-debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Feb 2019 11:56:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Chen Rong <rong.a.chen@intel.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 "IngoMolnar@shao2-debian" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ok, those test robot reports are hard to read, but trying to distill it dow=
n:

On Wed, Feb 13, 2019 at 1:19 AM Chen Rong <rong.a.chen@intel.com> wrote:
>
>          %stddev     %change         %stddev
>              \          |                \
>     196250 =C2=B1  8%     -64.1%      70494        will-it-scale.per_thre=
ad_ops

That's the original 64% regression..

And then with the patch set:

>          %stddev      change         %stddev
>              \          |                \
>      71190             180%     199232 =C2=B1  4%  will-it-scale.per_thre=
ad_ops

looks like it's back up where it used to be.

So I guess we have numbers for the regression now. Thanks.

And that closes my biggest question for the new model, and with the
new organization that gets ird of the arch-specific asm separately
first and makes it a bit more legible that way, I guess I'll just Ack
the whole series.

             Linus
