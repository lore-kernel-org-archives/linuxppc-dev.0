Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA0C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 12:54:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6F86322C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 12:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B6F86322C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvNDG2t4Bz2ynD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 23:54:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T/DR0eAp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::531;
 helo=mail-ed1-x531.google.com; envelope-from=naresh.kamboju@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=T/DR0eAp; dkim-atps=neutral
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvNCT6BKkz2xBZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2021 23:53:39 +1100 (AEDT)
Received: by mail-ed1-x531.google.com with SMTP id e3so10716705edu.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2021 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=tjd4VyoW9NW6T5kIQb4to2GeaeVYYi1HCWWk5+jRO3M=;
 b=T/DR0eApHoS5O42B29slErSGs5yTs2iQzaCUVmiCL/MWeqEVL7fyOsFw0l9EXHHStX
 hLaephQYrbBA8oTTa2c2VYJwFWiMzlcq0J03ITv1MxKB6doDtNnZbzDay6VCgMneZ/db
 YZDm+i94S/Wj3WFeikFghU+LGjmct8tzx4+nv86BcvGwSQW7mNmaVEsmb0qpBAsrb0Io
 Ei9vlcMcKla9LnHKhj2Um0JP4y+vggE/9tIl/TfqFC3vg7JycNj4DXhczsilq916cAd8
 sqGXOmabkyjTlCrPS/giHyrl6bYjmaWZwv09lW2ZKvpo1jaNDCe+TC+d9UWrzRjegP6a
 B4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=tjd4VyoW9NW6T5kIQb4to2GeaeVYYi1HCWWk5+jRO3M=;
 b=aVGXaI+JZAiQm9fPhRW9uACeVnDqWVFitRHzsU3nKy3OmB02crzAPwpMhcSbhxsmI+
 WGKNLlWNHVTN4BFHqANVwm7fjqjO4G7LIiP3klAP4tc6z0+NxZ7nzBM0mFmuqKBp5TvK
 4VM2FvUvuEvBMgBfTX2H3UZUvwmK5jAKnEgk3wZtRWvpoqpZNVBJ1OOqW7rrxx5CUKIH
 nnA+EdnLZe78uBCQ7bc/iftDMVSkrZcSSHlb68zejjk/r8dc4rcTJdGP4QctCqVJiR9F
 yEE0mD9yF/aq2h1jrxh6aTornRciHbYNfe0ec3UmpLkyT5AIymep13NZ8eXjDYJWtnTC
 JOtA==
X-Gm-Message-State: AOAM533sb/lm8YvsoXKBZ7lf2ZFaxRaGtp5EZPPVUYuv6ovg80PD89Qe
 UUqL6i9VmCT/WA93bdHBW0mTPEyu0rTZJPH3gLftOCzsrn77Pw==
X-Google-Smtp-Source: ABdhPJyIPEvbpOSChRQrCUjBOzpZmybNAiQj96Lak7bYQSEl8ibPONfgBVQLGabi/9CTgkfEQ7Yh7eovvoGjPSM3f9k=
X-Received: by 2002:a17:907:9196:: with SMTP id
 bp22mr21036403ejb.69.1637153611322; 
 Wed, 17 Nov 2021 04:53:31 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Nov 2021 18:23:20 +0530
Message-ID: <CA+G9fYtgOTFJKhAeBJvo3TnmLeNKyrP6R=d3gW1CoSnr7xhyjQ@mail.gmail.com>
Subject: powerpc: pervasive.c:: error: unannotated fall-through between switch
 labels
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>, 
 Linux-Next Mailing List <linux-next@vger.kernel.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 lkft-triage@lists.linaro.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Regression found on ppc clang-nightly build.
Following build warnings / errors reported on linux next 20211117.

metadata:
    git_describe: next-20211117
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: fd96a4057bd0 (\"Add linux-next specific files for 20211117\")
    target_arch: ppc
    toolchain: clang-nightly

build error :
--------------
<stdin>:1559:2: warning: syscall futex_waitv not implemented [-W#warnings]
#warning syscall futex_waitv not implemented
 ^
1 warning generated.
arch/powerpc/platforms/cell/pervasive.c:81:2: error: unannotated
fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
        case SRR1_WAKEEE:
        ^
arch/powerpc/platforms/cell/pervasive.c:81:2: note: insert 'break;' to
avoid fall-through
        case SRR1_WAKEEE:
        ^
        break;
1 error generated.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/211sfsuxt3flikHFzRts8cFUwqe/build.log

build config:
-------------
https://builds.tuxbuild.com/211sfsuxt3flikHFzRts8cFUwqe/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch powerpc --toolchain
clang-nightly --kconfig defconfig LLVM_IAS=0

-- 
Linaro LKFT
https://lkft.linaro.org
