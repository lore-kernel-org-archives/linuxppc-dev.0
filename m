Message-ID: <3C0E48D2.6000409@acm.org>
Date: Wed, 05 Dec 2001 10:18:26 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

>
> I've done
>
> -#define RELOC(x)       (*PTRRELOC(&(x)))
> +#define RELOC(x)       (*({ typeof(x) * __ptr  = PTRRELOC(&(x));
> __asm__ ("" : "=r" (__ptr) : "0" (__ptr)); __ptr;}))
>
> a while ago in
> <http://source.mvista.com/pipermail/linuxppc-commit/2001-September/000729.html>,
> seems nobody applied it so far.

Ok.  It needs to be propped.

>
>
>> * In drivers/video/aty/atyfb_base.c, there were some "const __init"
>> declarations, which are not allowed.
>
>
> Ah, I see, I only saw this problem in aty128fb. I'll add the fix to
> the linuxconsole CVS for 2.5.x.

What about 2.4?  I'm sure people will want to compile 2.4 with gcc 3.x.

>
>
>> * In include/linux/sunrpc/clnt.h, I removed a bogus function declaration
>> which was messing up inlining.
>
>
> I guess this is 3.1 specific? I don't remember problems with 3.0.x.

Probably.  I've seen some other problems with GCC being fairly picky
about declarations, and I think it's fairly new.  But the declaration
both wrong and unnecessary.

>
>
> What about the FAT filesystem? Is gcc-3.1 now able to correctly
> optimize the 64bit signed divide by const into a ASHIFT+fixup?

Nope.  I was going to ask about that one.  Do you have a GCC PR on this?

-Corey


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
