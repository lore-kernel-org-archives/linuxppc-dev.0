From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Compiler Problem?
Date: Wed, 1 Dec 1999 11:27:12 -0500
Content-Type: text/plain
References: <384548C4.1E9ADDAF@muenchen.europe.mcd.mot.com>
In-Reply-To: <384548C4.1E9ADDAF@muenchen.europe.mcd.mot.com>
MIME-Version: 1.0
Message-Id: <99120111314801.17363@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The ABI says that long longs are passed in register pairs with the first
register of the pair to being an odd numbered register.

so r3 gets param 1
     r4 gets param 2
     r5 gets param 3

r6 is an even numbered register and can't be used as the first number of
register pair and therefore is skipped over
  
     r7 and r8 get param 4

Check out the sys ABI spec for ppc.  This is correct given the spec.

By the way, we have one of the more wierd specs I have ever seen.

And I have no idea why this is used unless there is a physical datapath
contraint in the cpu that prevents simultaneous loading of r6,r7 pairs but
allows simultaneous loading of r7,r8 pairs?

Does anyone know?

> I have seen this with egcs-2.91.66 and with a version conmpiled
> from gcc-2.95.2-2a.
> 
> ----------------------------------------------------
> extern int foo(long, long, long, long long, long);
> 
> doo()
> {
>    int result; 
> 
>    result = foo( 11, 12, 13, 14, 15 );
> }
> ----------------------------------------------------
>         .file   "z.c"
> gcc2_compiled.:
>         .section        ".text"
>         .align 2
>         .globl doo
>         .type    doo,@function
> doo:
>         stwu 1,-32(1)
>         mflr 0
>         stw 31,28(1)
>         stw 0,36(1)
>         mr 31,1
>         li 3,11
>         li 4,12
>         li 5,13
>         li 7,0
>         li 8,14
>         li 9,15
>         bl foo
>         mr 0,3
>         stw 0,8(31)
> .L1:
>          lwz 11,0(1)
>         lwz 0,4(11)
>         mtlr 0
>         lwz 31,-4(11)
>         mr 1,11
>         blr
> .Lfe1:
>          .size    doo,.Lfe1-doo
>         .ident  "GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"
> 
> -- 
> Regards,
>    Alois

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
