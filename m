Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qj2QT5dfDzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2016 02:50:53 +1000 (AEST)
Received: by mail-wm0-x22a.google.com with SMTP id 191so45040082wmq.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 Apr 2016 09:50:53 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: clock_gettime.2: _COARSE clocks are not always faster...
Date: Sat, 09 Apr 2016 18:50:47 +0200
Message-ID: <87k2k67ml4.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael

The other day, I was curious how the vdso was implemented on ppc, and I
noted that neither ppc32 or ppc64 handle the _COARSE versions of
CLOCK_{REALTIME,MONOTONIC} in the vdso, so they fall back to an actual
syscall. And sure enough, measuring CLOCK_MONOTONIC
vs. CLOCK_MONOTONIC_COARSE shows that the latter has three times as much
overhead as the former.

Whether it's worth adding a note to the man page is up to you.

Best,
Rasmus
