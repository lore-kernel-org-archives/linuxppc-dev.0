Return-Path: <olof@lixom.net>
Received: from mail-qe0-f46.google.com (mail-qe0-f46.google.com
 [209.85.128.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2249B2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Dec 2013 08:05:12 +1100 (EST)
Received: by mail-qe0-f46.google.com with SMTP id a11so10350925qen.33
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 13:05:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1388264507-5100-1-git-send-email-olof@lixom.net>
References: <1388264507-5100-1-git-send-email-olof@lixom.net>
Date: Sat, 28 Dec 2013 13:05:08 -0800
Message-ID: <CAOesGMhHw-G-T7ZfNsVU92ftOucCNe9shNJtA7SWzqX=dQBQng@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix alignment of secondary cpu spin vars
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 28, 2013 at 1:01 PM, Olof Johansson <olof@lixom.net> wrote:
> Commit 5c0484e25ec0 ('powerpc: Endian safe trampoline') resulted in
> losing proper alignment of the spinlock variables used when booting
> secondary CPUs, causing some quite odd issues with failing to boot on
> PA Semi-based systems.
>
> This showed itself on ppc64_defconfig, but not on pasemi_defconfig,
> so it had gone unnoticed when I initially tested the LE patch set.
>
> Fix is to add explicit alignment instead of relying on good luck. :)
>
> Fixes: 5c0484e25ec0 ('powerpc: Endian safe trampoline')
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=67811
> Signed-off-by: Olof Johansson <olof@lixom.net>

Sigh, it's not this after all. I did a clean build with this applied
and still see failures. Something else is (also?) going on here.


-Olof
