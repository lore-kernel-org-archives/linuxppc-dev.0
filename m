Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E7C12C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 21:46:20 +1100 (EST)
Received: by mail-ie0-f182.google.com with SMTP id k14so6347582iea.27
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 02:46:17 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <51201276.8020104@mail.ru>
References: <1360365046.495584377@f356.mail.ru> <511F652F.4090508@mail.ru>
 <51201276.8020104@mail.ru>
Date: Sun, 17 Feb 2013 09:53:30 +0100
Message-ID: <CAMuHMdUTQWpQH=UaHc=iZPiJrry7_VqOjtm7bX+jW6r3vOge8A@mail.gmail.com>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Phileas,

On Sun, Feb 17, 2013 at 12:12 AM, Phileas Fogg <phileas-fogg@mail.ru> wrote:
> I found new clues about the problem.
>
> Normally the device tree memory segment is allocated at the top of the boot
> memory region. The boot memory size on the PS3 console is 128MB.
>
>
> root@ps3-linux:~# kexec -l loader.ps3
> segment[0].mem:0x131d000 memsz:262144
> segment[1].mem:0x135d000 memsz:36864
> segment[2].mem:0x7fff000 memsz:4096
>
> And the device tree is located at address 0x7fff000, it's the last page of
> the boot memory.
>
> I changed the kexec-tools and made it store the device tree just after the
> purgatory code which is located at address 0x135d000. Like here:
>
>
> root@ps3-linux:~# kexec -l loader.ps3
> segment[0].mem:0x131d000 memsz:262144
> segment[1].mem:0x135d000 memsz:36864
> segment[2].mem:0x1366000 memsz:4096   <---- new address of device tree
> segment
>
> And now the sha256 verification is always successful for the FreeBSD loader
> too.
> But still no idea what actually corrupts the device tree segment when it's
> located at the top of the boot memory region. And why it happens on Linux
> 3.7 and Linux 3.8 but not on Linux 3.3.8.

Have you looked at the actual data that ends up being written there?
It may give a clue...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
