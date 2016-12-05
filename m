Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tX5D23rc3zDvkR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 11:26:42 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tX5D15YWbz9t1h
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2016 11:26:41 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so14573288pga.2
 for <linuxppc-dev@ozlabs.org>; Sun, 04 Dec 2016 16:26:41 -0800 (PST)
Date: Mon, 5 Dec 2016 11:26:26 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, amodra@gmail.com,
 nickc@redhat.com
Subject: Re: [PATCH v2] powerpc/boot: Request no dynamic linker for boot
 wrapper
Message-ID: <20161205112626.12c41c3e@roar.ozlabs.ibm.com>
In-Reply-To: <1480763188-20224-1-git-send-email-mpe@ellerman.id.au>
References: <1480763188-20224-1-git-send-email-mpe@ellerman.id.au>
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

On Sat,  3 Dec 2016 22:06:28 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> 
> The boot wrapper performs its own relocations and does not require
> PT_INTERP segment. However currently we don't tell the linker that.
> 
> Prior to binutils 2.28 that works OK. But since binutils commit
> 1a9ccd70f9a7 ("Fix the linker so that it will not silently generate ELF
> binaries with invalid program headers. Fix readelf to report such
> invalid binaries.") binutils tries to create a program header segment
> due to PT_INTERP, and the link fails because there is no space for it:
> 
>   ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
>   ld: final link failed: Bad value
> 
> So tell the linker not to do that, by passing --no-dynamic-linker.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Drop dependency on ld-version.sh and massage change log]

Thanks for fixing that up, it looks good.

Thanks,
Nick
