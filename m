Return-Path: <nicolae.rosia.oss@gmail.com>
Received: from mail-it0-x22b.google.com (mail-it0-x22b.google.com
 [IPv6:2607:f8b0:4001:c0b::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYXRR1j6vzDqkj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 00:57:07 +1000 (AEST)
Received: by mail-it0-x22b.google.com with SMTP id g126so58961630ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 07:57:07 -0700 (PDT)
MIME-Version: 1.0
From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Date: Thu, 25 May 2017 17:57:03 +0300
Message-ID: <CAKP5S=3NMzfEDdLsd6_FCNTH6o7_Qz2D6qFwx1WOdc-x2Xi0rA@mail.gmail.com>
Subject: timer_create affinity
To: linux-rt-users@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm working on a real-time application using POSIX timers running on a
QorIQ PowerPC platform with a 4.1 PREEMPT RT kernel and I'm trying to
understand whether the following can happen:
1. A thread with a core affinity #0 creates a timer which will invoke
a callback.
2. The kernel will setup the timer using a local timer running on a
different core, core #1
3. The ISR will fire, and could be dispatched by core #2
4. The scheduler will run the callback on core #3.

Is there a way to make sure this whole chain will be executed on a
single core, the core of the caller?

Best regards,
Nicolae Rosia
