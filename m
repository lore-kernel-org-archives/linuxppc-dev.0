Message-ID: <3B747194.1D2AD47C@mvista.com>
Date: Fri, 10 Aug 2001 16:43:16 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: new to  "__asm__ "  macro...
References: <20010810230707.2131.qmail@web20002.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Raghava Raju wrote:
>
> hi
>
>    I want some basic insights into assembly level code
> emmbedded in C language.Following is the code of

You can find a description of this at

  http://www.objsw.com/docs/gcc_89.html#SEC89


> PowerPc ambedded in C languagge:
>
> unsigned long old,mask, *p;
>
>         __asm__ __volatile__(SMP_WMB "\
> 1:      lwarx   %0,0,%3
>         andc    %0,%0,%2
>         stwcx   %0,0,%3
>         bne     1b"
>         SMP_MB
>         : "=&r" (old), "=m" (*p)
>         : "r" (mask), "r" (p), "m" (*p)
>         : "cc");
>
>         1) what does these things denote: __volatile__,
> SMP_WMB, SMP_MB, "r","=&r","=m","cc",1: .
>
>         2) Is it that %0,%2,%3 denote addresses of old,mask,p
> respectively.
>
>         3) Say if it is PowerPc then how should I
> access registers r1,r2 etc, that is what is the exact
> syntax.
>
>         4) I think in power PC we can't access
> directly the contents of memory, but we should
> give addresses of memory in registers then use
> registers in instructions to access memory. But in
> above example he is using %3 in lwarx command
> accessing that memory directly. Is my interpretation
> of above instructions wrong.
>
>         5) Some people use "memory" in place of "cc" ,
> like I want to know what are these things.
>
>         6) Finally I want to write a simple programme
> to write the contents of a local variable "xyz" into
> register r33, then store the contents of r33 into
> local variable "abc". Kindly would u give me a sample
> code of doing it.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
