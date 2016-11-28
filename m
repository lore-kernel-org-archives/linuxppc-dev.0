Return-Path: <amodra@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRrC73TGBzDt3H
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:26:11 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so11634214pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 18:26:11 -0800 (PST)
Date: Mon, 28 Nov 2016 12:56:04 +1030
From: Alan Modra <amodra@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, Nick Clifton <nickc@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
Message-ID: <20161128022604.GE26291@bubble.grove.modra.org>
References: <20161128014226.7656-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161128014226.7656-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 12:42:26PM +1100, Nicholas Piggin wrote:
> The boot wrapper performs its own relocations and does not require
> PT_INTERP segment.

OK, so the kernel change is quite reasonable in isolation, but see
below.

> Without this option, binutils 2.28 and newer tries to create a program
> header segment due to PT_INTERP, and the link fails because there is no
> space for it.
> 
>    A recent binutils commit:
>    https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1a9ccd70f9a75dc6b48d340059f28ef3550c107b
>    has broken kernel builds:

So this change added space for another header, it seems.  I suspect
that was accidental, particularly since there was no mention of
get_program_header_size in the ChangeLog entry.

-- 
Alan Modra
Australia Development Lab, IBM
