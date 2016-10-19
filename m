Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szP8s0KWqzDt33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 18:44:29 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 128so1733729pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 00:44:28 -0700 (PDT)
Date: Wed, 19 Oct 2016 18:44:22 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/7] build updates
Message-ID: <20161019184422.50f4d08b@roar.ozlabs.ibm.com>
In-Reply-To: <20161019031600.17933-1-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Oct 2016 14:15:53 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> [*] Building allyesconfig still requires KALLSYMS_EXTRA_PASS=1, which
>     I'm yet to look into.

Oh, it's because the kallsyms payload increases kernel image size and that
causes more linker stubs to be generated, which have symbols, which go into
kallsyms... What a nightmare.

We can use --no-emit-stub-syms, but it's kind of nice to have names for
things.

Thanks,
Nick
