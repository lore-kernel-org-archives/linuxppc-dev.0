Message-ID: <384548C4.1E9ADDAF@muenchen.europe.mcd.mot.com>
Date: Wed, 01 Dec 1999 17:11:48 +0100
From: Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PPC Compiler Problem?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Given the following lines of C, I'd expect that the 4th argument
is placed into register 6 and 7. As the assembler listing tells,
register 6 is omitted and the argument goes into r7/r8.

I have seen this with egcs-2.91.66 and with a version conmpiled
from gcc-2.95.2-2a.

----------------------------------------------------
extern int foo(long, long, long, long long, long);

doo()
{
   int result; 

   result = foo( 11, 12, 13, 14, 15 );
}
----------------------------------------------------
        .file   "z.c"
gcc2_compiled.:
        .section        ".text"
        .align 2
        .globl doo
        .type    doo,@function
doo:
        stwu 1,-32(1)
        mflr 0
        stw 31,28(1)
        stw 0,36(1)
        mr 31,1
        li 3,11
        li 4,12
        li 5,13
        li 7,0
        li 8,14
        li 9,15
        bl foo
        mr 0,3
        stw 0,8(31)
.L1:
        lwz 11,0(1)
        lwz 0,4(11)
        mtlr 0
        lwz 31,-4(11)
        mr 1,11
        blr
.Lfe1:
        .size    doo,.Lfe1-doo
        .ident  "GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"

-- 
Regards,
   Alois

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
