Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-gh0-f170.google.com (mail-gh0-f170.google.com
 [209.85.160.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA196B6FCB
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 18:02:51 +1000 (EST)
Received: by ghbg2 with SMTP id g2so4999112ghb.15
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 01:02:49 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20120620035951.GC5623@linux-sh.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620035951.GC5623@linux-sh.org>
Date: Wed, 20 Jun 2012 10:02:48 +0200
Message-ID: <CAMuHMdUmNgBsvVUGsfwKgVq2CfCnOje_4ZUSoig=vSbhN4vSJA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset=UTF-8
Cc: Chris Zankel <chris@zankel.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2012 at 5:59 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Jun 17, 2012 at 09:56:59PM +0200, Geert Uytterhoeven wrote:
>> On Sun, Jun 17, 2012 at 9:46 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > JFYI, when comparing v3.5-rc3 to v3.5-rc2[3], the summaries are:
>> > ??- build errors: +235/-10
>>
>> Truckloads of powerpc "Unrecognized opcode" breakage, and
>>
> That was my fault, should be fixed up by 2603efa31a.
>
>> =C2=A0 + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implic=
it
>> declaration of function 'pci_iomap'
>> [-Werror=3Dimplicit-function-declaration]: =C2=A0=3D> 90:3
>> =C2=A0 + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implic=
it
>> declaration of function 'pci_iounmap'
>> [-Werror=3Dimplicit-function-declaration]: =C2=A0=3D> 142:2
>>
> Not sure about this one, it should find everything alright via:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0linux/io.h -> asm/io.h -> asm-generic/iomap.h =
-> asm-generic/pci_iomap.h
>
> in the case that PCI is enabled. None of allyesconfig/modconfig enable
> PCI for me though, so I'm unsure of how you got in to this configuration
> to begin with?

These were xtensa, not sh.

The ones above ("error: expected expression before 'do'") were sh.

>> =C2=A0 + error: "__ashrdi3" [fs/ntfs/ntfs.ko] undefined!: =C2=A0=3D> N/A
>> =C2=A0 + error: "__lshrdi3" [fs/ntfs/ntfs.ko] undefined!: =C2=A0=3D> N/A
>>
>> sh4/landisk_defconfig
>>
>> =C2=A0 + error: "__ashrdi3" [fs/xfs/xfs.ko] undefined!: =C2=A0=3D> N/A
>> =C2=A0 + error: "__lshrdi3" [drivers/mtd/mtd.ko] undefined!: =C2=A0=3D> =
N/A
>> =C2=A0 + error: "__lshrdi3" [fs/xfs/xfs.ko] undefined!: =C2=A0=3D> N/A
>>
> These seem to be the same issue on both platforms, EXPORT_SYMBOL()
> doesn't work from lib-y. While it's straightforward to fix, I'm not able
> to reproduce __lshrdi3/__ashrdi3 references in any of the above, which
> compiler are you using?

http://kisskb.ellerman.id.au/kisskb/buildresult/6543287/ says
sh4-linux-gcc (GCC) 4.6.3

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
