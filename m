Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
 [209.85.210.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 03A41B6F84
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 03:15:53 +1100 (EST)
Received: by iaeo4 with SMTP id o4so192520iae.15
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 09:15:50 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <AD39F4F8-E9C0-4090-9AEA-644F82DD328B@kernel.crashing.org>
References: <1318430145-19898-1-git-send-email-galak@kernel.crashing.org>
 <20111012153229.GB21852@local>
 <AD39F4F8-E9C0-4090-9AEA-644F82DD328B@kernel.crashing.org>
Date: Wed, 12 Oct 2011 18:15:49 +0200
Message-ID: <CAMuHMdU1rHDvZEknNqKLHyBmJ26kH7SJtxsOZmOysrSzg6bz4g@mail.gmail.com>
Subject: Re: [PATCH] uio: Support 36-bit physical addresses on 32-bit systems
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, "Hans J. Koch" <hjk@hansjkoch.de>,
 Kai Jiang <Kai.Jiang@freescale.com>, gregkh@suse.de,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 18:07, Kumar Gala <galak@kernel.crashing.org> wrote=
:
> On Oct 12, 2011, at 10:32 AM, Hans J. Koch wrote:
>> On Wed, Oct 12, 2011 at 09:35:45AM -0500, Kumar Gala wrote:
>>> From: Kai Jiang <Kai.Jiang@freescale.com>
>>>
>>> To support >32-bit physical addresses for UIO_MEM_PHYS type we need to
>>> extend the width of 'addr' in struct uio_mem. =C2=A0Numerous platforms =
like
>>> embedded PPC, ARM, and X86 have support for systems with larger physica=
l
>>> address than logical.
>>>
>>> Since 'addr' may contain a physical, logical, or virtual address the
>>> easiest solution is to just change the type to 'unsigned long long'
>>> regardless of which type is utilized.
>>
>> No. There's phys_addr_t for that purpose, defined in include/linux/types=
.h.
>> Please use that.
>
> Do we believe phys_addr_t is always greater than or equal to size need fo=
r logical & virtual addresses?

Yes:

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

config PHYS_ADDR_T_64BIT
        def_bool 64BIT || ARCH_PHYS_ADDR_T_64BIT

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
