Date: Tue, 10 Sep 2002 21:07:40 -0700
From: curt brune <curt@acm.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting on embedded planet RPX_LITE-DW (823e)
Message-ID: <20020911040740.GA19578@lenin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020910065712.2B2EBFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Success!!  It boots!

Thanks to all the people who pointed this out:

> > Does anyone know a reason for the 0x10000 offset?  Can you point
    me to
>
> It seems you are loading a file in ELF format. 0x10000  is  64  kB
    -
> this  size  of  the ELF file header. In the Pre-PPCBoot times when we
> still used this  bootstrap  loader  method  for  booting  we  alsways
> stipped  this  header  - this saves 64 kB (more than 10% of the  image
> size!) in flash:
>
>       dd if=zImage of=zImage.raw bs=64k skip=1
>

Regarding my hanging problem -- this was board specific.  My board has
a watchdog timer, which was enabled.  After disabling this via the
"SYPCR" config parameter it just worked.  Great.  Good feeling.

It even netboots.  Great.

For what it's worth I'm running kernel 2.4.18 patched with
ppc-patch-2.4.18.gz from kernel.org .  For the toolchain I'm using the
ELDK.  No other patches.

Now the real big fun begins.

Cheers,
Curt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
