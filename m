Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 53C63679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 06:01:34 +1000 (EST)
In-Reply-To: <017001c6cb0e$1b81f440$a309a8c0@SZD823>
References: <017001c6cb0e$1b81f440$a309a8c0@SZD823>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <39F277C7-5AC0-41F8-A287-588D798DE970@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: MPC85xx u-boot definition
Date: Tue, 29 Aug 2006 15:01:30 -0500
To: enorm <enorm@126.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 28, 2006, at 8:54 PM, enorm wrote:

> Hi,
>   Some naive questions about u-boot for MPC85xx,  the definition of
> some macro in ppc_asm.tmpl. Can anyone there explain them to me  
> please?
>  1)   In GET_GOT(x) what does  " lwz r0,0b-1b(r14) ;" do? what does
> "0b-1b" stands for, or the meaning of the syntax? why move the content
> of the memory pointing by LR?
0b and 1b refer to the labels 0: and 1:.  The "b" means find the  
first instance of that label backward from the reference point.

> #define GET_GOT                                \
>         bl      1f              ;       \
>        .text   2               ;       \
> 0:     .long   .LCTOC1-1f      ;       \
>        .text                   ;       \
> 1:      mflr    r14             ;       \
>        lwz     r0,0b-1b(r14)   ;       \
>        add     r14,r0,r14      ;

One thing to note when looking at this code that might be confusing:  
The .text 2 directive says that the code after it should be put in  
subsection "2" of the .text section.  The default is 0 if this is not  
specified.  When you build, this code is no longer sequential -  
the .text 2 stuff will end up somewhere in the executable *after* the  
normal .text.

To illustrate, here's what you get if you compile just this code and  
dump it (I just #defined .LCTOC1 to be 0x1000 so it would compile):

00000000 <.text>:
    0:   48 00 00 05     bl      0x4
    4:   7d c8 02 a6     mflr    r14 << label 1: points here
    8:   80 0e 00 0c     lwz     r0,12(r14)
    c:   7d c0 72 14     add     r14,r0,r14
   10:   00 00 10 0c     .long 0x100c << label 0: points here

And what it does, line by line:

bl      0x4  /* LR now contains actual address we're running at */
mflr    r14  /* copy LR into r14 so we can use it */
lwz     r0,12(r14) /* Get the linker-generated value .LCTOC1-1f */
add     r14,r0,r14 /* Correct that value for where we're really  
running */

The whole point here is to be somewhat position-independent - we're  
calculating where things are rather than using the linker-generated  
values because we don't necessarily want to assume we're loaded and  
running at the link address.


>
> 2) In START_GOT,  any special meaning for the value 32768?
>  >> .LCTOC1=.+32768

So, I don't have the code for this, but if I had to guess..... That  
value is equivalent to 0x8000 hex. The GOT is usually accessed using  
a symbol that's in the middle of the GOT so you can use positive and  
negative indexes from that point to access data in the GOT.  The max  
size of an immediate value in ppc asm is 16 bits.  So this is the  
halfway point that gives you maximum access with a 16-bit immediate.

> 3) Syntax for GOT_ENTRY(NAME)  and GOT(NAME),  like    . - .LCTOC1  
> (line 57) and .text 2 (line 50)
> could not find then in the GNU douments (ld, as, gcc, glibc etc).
Most everything you need is in the gas manual at http://www.gnu.org/ 
software/binutils/manual/gas-2.9.1/html_mono/as.html. and in the C  
preprocessor documentation at http://gcc.gnu.org/onlinedocs/ 
gcc-2.95.3/cpp.html#SEC_Top.  If you're really interested in  
understanding this stuff, you should probably also dig up and read  
the PowerPC Processor ABI Supplement document as well.

Cheers,
B
