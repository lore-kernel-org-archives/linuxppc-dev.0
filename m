Return-Path: <martin@hinner.info>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CD642C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 03:15:41 +1000 (EST)
Received: by mail-vc0-f180.google.com with SMTP id gf11so1201530vcb.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 10:15:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPVwjkzkuw4cbo9YxnsskdoAda-k+Gb5sdVEJiZTVAD1nR5OOg@mail.gmail.com>
References: <CAPVwjkzkuw4cbo9YxnsskdoAda-k+Gb5sdVEJiZTVAD1nR5OOg@mail.gmail.com>
Date: Sat, 24 Aug 2013 19:15:37 +0200
Message-ID: <CAPVwjkyPKo0SmoEkJttzz0fXrTcyuv7K1nuhOzW9CdGXD+t7_A@mail.gmail.com>
Subject: Re: Loading kernel on MPC86x
From: Martin Hinner <martin@hinner.info>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello again,

  just a quick update: I have spent some more time on this and now I
can boot into kernel (it works even with initramfs and simple assembly
HelloWorld, so it's time to compile userland now). The problem was
that kernel must be at location 0. Another problem was that interrupts
got re-enabled during execution of my bootloader (I am doing some
syscalls -> goes  to Cisco rom), otherwise it crashed randomly. And
finally it seems that stack must be < 8M. After this kernel boots.

Anyway, I would still appreciate clarification on vmlinux:__start
entry conditions:

- must be loaded at 0 (but why arch/powerpc/boot/main.c has option to
allocate space for kernel at nonzero addr ?)
- stack? Does it really have to be < 8M ?
- interrupts disabled (really ;-) )
- MSR.PR=0/LE=0/EE=0, but what other bits (RI? IP=0? ME?)
- IMMR 0xff000000
- and of course correct entry arguments in registers

anything else?

I am also curious why CONFIG_PPC_EARLY_DEBUG_CPM uses
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR as pointer to transmit SMC buffer and
not address of CPM/SCM parameter RAM ? TX buffer address can be read
from SMC parameter RAM. Wouldn't this solution be more portable? At
least this way I do it when I take over console from Cisco
startup/rommon.

Martin
