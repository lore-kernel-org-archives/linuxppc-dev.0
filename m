Date: Wed, 13 Oct 1999 08:14:56 +0200
From: Christophe Lizzi <lizzi@csti.fr>
Message-Id: <199910130614.IAA29151@devl58>
To: linuxppc-dev@lists.linuxppc.org, doyle@primenet.com
Subject: Re: PowerPC function returning long long
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I was playing with the inline assembler and the ppc
> timebase facility and created the following function -

> Is there a better way to write the return statement?
> 
> Is there a register constraint for a long long register
> (like the "A" constraint for the x86 which returns the
> 64 bit data in edx:eax)?

64 bit values are returned in r3:r4.

I'm definitively not an asm guru, but the following code works:

/*
  from PowerPC Microprocessor Family: The Programming Environments,
       section 2.2: PowerPC VEA Register Set - Time Base,
       IBM Microelectronics - Motorola.
*/

unsigned long long timebase(void)
{
    asm( "isync" );   /* discard prefetched instructions */
    /* the loop ensures that a consistent pair of values is obtained */
    asm("loop:"     ); 
    asm("mftbu 3"   ); /* load r3 from TBU       */
    asm("mftb  4"   ); /* load r4 from TBL       */
    asm("mftbu 5"   ); /* load r5 from TBU       */
    asm("cmpw  5, 3"); /* compare r5 and r3      */
    asm("bne   loop"); /* loop if carry occured  */
}

--Christophe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
