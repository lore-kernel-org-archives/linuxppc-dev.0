Message-ID: <3DD868BC.7090402@iram.es>
Date: Mon, 18 Nov 2002 05:12:44 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Tim Seufert <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
References: <FA8676EA-FA77-11D6-AE66-003065F22EAA@mindspring.com> <001701c28e91$8ab64b80$0200a8c0@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:
>>On Sunday, November 17, 2002, at 07:17  AM, Joakim Tjernlund wrote:
>>
>>
>>>>CTR and the instructions which operate on it
>>>>(such as bdnz) were put into the PPC architecture mainly as an
>>>>optimization opportunity for loops where the loop variable is not used
>>>>inside the loop body.
>>>
>>>loop variable not USED or loop variable not MODIFIED?
>>
>>Not used.  CTR cannot be specified as the source or destination of most
>>instructions.  In order to access its contents you have to use special
>>instructions that move between it and a normal general purpose register.
>
>
> OK, so how about if I modify the crc32 loop:
>
> unsigned char * end = data +len;
> while(data < end) {
>         result = (result << 8 | *data++) ^ crctab[result >> 24];
> }
>
> will that be possible to optimze in with something similar as bdnz also?

I don't know if even bleeding edge gcc can do it, basically you can always
use bdnz as soon as you can compute the iteration count before entering
the loop. The problem is that equivalent source code constructs do not
always result in exactly equivalent internal representation in GCC. The
transforms which are attempted depend on the exact version of GCC and
the optimization level.

In the example code you give, the variable 'end' is absolutely useless and
forces the compiler to do more simplifications (essentially eliminating
end and using end-data as a loop index if it wants to use bdnz). Making
life more complex for the compiler is never a good idea...

I'd rather write it as:

int i;
for(i=0; i< len; i++) {
	result=...data++...;
}

when i is not modified in the loop. I'm almost sure that recent gcc will
end up using a bdnz instruction in this simple case.

This said, it is probably very hard to optimize this loop since
the load from crctab and the dependencies between iterations
introduce quite a few delays.

0:
lbzu
scratch,*data,1
	rlwinm	tmp,result,10,0x3fc
	slwi	result,result,8
	lwzx	tmp,crctab,tmp
	or	result,result,scratch
	xor	result,result,tmp
	bdnz	0b

is probably the best you can get. The worst path which limits iteration
rate is rlwinm+lwz+xor, which will be 4 or 5 clock cycles typically.

I'm not sure that gcc will use an lbzu for reading the byte array. It may
help to explicitly decrement data before the loop and then use *++data
which better matches the operation of lbzu (I know that post-increment
being worse than pre-increment was true for some versions of gcc, but I
don't know exactly which).

Finally a truly clever compiler which knows its PPC assembly should be
able  to notice that one instruction can be saved since (result<<8|*data)
can be replaced by a bit field insert:

0:
lbzu
scratch,*data,1
	rlwinm	tmp,result,10,0x3fc
	lwzx	tmp,crctab,tmp
	rlwimi	scratch,result,8,0xffffff00
	xor	result,scratch,tmp
	bdnz	0b

but this would not help the critical path of the loop.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
