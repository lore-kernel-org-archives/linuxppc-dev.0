Date: Wed, 13 Oct 1999 10:06:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Bob Doyle <doyle@primenet.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC function returning long long
In-Reply-To: <38041087.62AB190@primenet.com>
Message-ID: <Pine.HPX.4.10.9910130940210.7415-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 13 Oct 1999, Bob Doyle wrote:

> 
> I was playing with the inline assembler and the ppc
> timebase facility and created the following function -
> 
> unsigned long long get_timebase(void) {
>         unsigned long tbu;
>         unsigned long tbl;
>         unsigned long junk;
>         __asm__ __volatile__ ("
> 1:      mftbu   %2
>         mftb    %1
>         mftbu   %0
>         cmpw    %0,%2
>         bne     1b"
>         : "=r" (tbu), "=r" (tbl), "=r" (junk));
>         return ((unsigned long long)tbu << 32) | tbl;
> }

Rather write: 
unsigned long long get_timebase(void) {
        unsigned long long retval;
        unsigned long junk;
        __asm__ __volatile__ ("
1:      mftbu   %1
        mftb    %0+1
        mftbu   %0
        cmpw    %0,%1
        bne     1b"
        : "=r" (retval), "=r" (junk));
        return retval;
}

which generates on my machine (with optimization of course): 
Disassembly of section .text:

00000000 <get_timebase>:
   0:   7c 0d 42 e6     mftbu   r0
   4:   7c 8c 42 e6     mftb    r4
   8:   7c 6d 42 e6     mftbu   r3
   c:   7c 03 00 00     cmpw    r3,r0
  10:   40 82 ff f0     bne     0 <get_timebase>
  14:   4e 80 00 20     blr


Note: as you see you can access the second register of a 64 bit value with
%n+1. At this point I'd rather declarre the function inline...

> I assume it is because gcc is struggling with the code
> in the return statement.

Indeed. 64 bit integer handling is currently poor on PPC (except PPC64 of
course).

> Is there a better way to write the return statement?
> 
> Is there a register constraint for a long long register
> (like the "A" constraint for the x86 which returns the
> 64 bit data in edx:eax)?

No, because for 64 bit values, gcc always allocates a register pair
Rn/Rn+1. That why you can use the %n+1 trick. Register numbering on Intel
is a mess, the HW order atually is eax,ecx,edx,ebx,esp,ebp,esi,edi from
the register encoding and the pusha/popa instruction (but then it is
completely different for 16 bit adressing modes). And for 8 bit registers
it is al,cl,dl,bl,ah,ch,dh,bh.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
