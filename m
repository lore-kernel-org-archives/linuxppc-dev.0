Message-Id: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com>
Date: Wed, 05 Dec 2001 13:55:38 +0100
To: Corey Minyard <minyard@acm.org>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: Changes to PPC Linux required for GCC 3.1
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3C0CF638.1030204@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:13 04.12.2001, Corey Minyard wrote:
>I've been working on getting Linux PPC running on GCC 3.1, and I'm
>sending it from my Mac whose operating system was just compiled with a
>current GCC 3.1 tree (Hurray!)
>
>I've had to patch the kernel a little, there were a few violations and
>some problems with interactions with optimizations.  I had to do the
>following:
>
>* In include/asm-ppc/prom.h, the calculations for the relocations were
>offseting a large constant with a string.  This results in bogus
>optimizations in GCC, and a comment in GCC seems to say that you
>shouldn't do this.  I've fixed it by calling a function to do the
>calculation.  I've posted something on the GCC newsgroup about this,
>too, we'll see what they say.

I've done

-#define RELOC(x)       (*PTRRELOC(&(x)))
+#define RELOC(x)       (*({ typeof(x) * __ptr  = PTRRELOC(&(x)); __asm__
("" : "=r" (__ptr) : "0" (__ptr)); __ptr;}))

a while ago in
<http://source.mvista.com/pipermail/linuxppc-commit/2001-September/000729.html>,
seems nobody applied it so far.

>* In drivers/video/aty/atyfb_base.c, there were some "const __init"
>declarations, which are not allowed.

Ah, I see, I only saw this problem in aty128fb. I'll add the fix to the
linuxconsole CVS for 2.5.x.

>* In include/linux/sunrpc/clnt.h, I removed a bogus function declaration
>which was messing up inlining.

I guess this is 3.1 specific? I don't remember problems with 3.0.x.

What about the FAT filesystem? Is gcc-3.1 now able to correctly optimize
the 64bit signed divide by const into a ASHIFT+fixup?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
