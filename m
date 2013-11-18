Return-Path: <walken@google.com>
Received: from mail-qc0-x236.google.com (mail-qc0-x236.google.com
 [IPv6:2607:f8b0:400d:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B2192C007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 14:57:54 +1100 (EST)
Received: by mail-qc0-f182.google.com with SMTP id n7so3516442qcx.41
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2013 19:57:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131118145528.2329a1ab@kryten>
References: <20131118145528.2329a1ab@kryten>
Date: Sun, 17 Nov 2013 19:57:50 -0800
Message-ID: <CANN689HHohC9wv8YuenJfVJ4fXzXrtgJt3YX9rX1Ani0Yqhxxg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: ppc64 address space capped at 32TB, mmap
 randomisation disabled
From: Michel Lespinasse <walken@google.com>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 17, 2013 at 7:55 PM, Anton Blanchard <anton@samba.org> wrote:
>
> Commit fba2369e6ceb (mm: use vm_unmapped_area() on powerpc architecture)
> has a bug in slice_scan_available() where we compare an unsigned long
> (high_slices) against a shifted int. As a result, comparisons against
> the top 32 bits of high_slices (representing the top 32TB) always
> returns 0 and the top of our mmap region is clamped at 32TB
>
> This also breaks mmap randomisation since the randomised address is
> always up near the top of the address space and it gets clamped down
> to 32TB.
>
> Cc: stable@vger.kernel.org # v3.10+
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 3e99c14..7ce9cf3 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -258,7 +258,7 @@ static bool slice_scan_available(unsigned long addr,
>                 slice = GET_HIGH_SLICE_INDEX(addr);
>                 *boundary_addr = (slice + end) ?
>                         ((slice + end) << SLICE_HIGH_SHIFT) : SLICE_LOW_TOP;
> -               return !!(available.high_slices & (1u << slice));
> +               return !!(available.high_slices & (1ul << slice));
>         }
>  }
>

Good catch, sorry about that...

Acked-by: Michel Lespinasse <walken@google.com>

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
