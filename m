Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 1563FB7D09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Mar 2010 12:42:43 +1100 (EST)
Received: from edison2.selinc.com (edison2.ad.selinc.com [10.100.0.115])
	by duster.selinc.com (8.14.3/8.14.3) with ESMTP id o2B1RUYB009547
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2010 17:27:30 -0800
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Need help with using the BDI2K to debug exception handlers
Message-ID: <OF0F68BA89.574E2B63-ON882576E3.00013E9C-882576E3.000802F5@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 10 Mar 2010 17:27:34 -0800
Content-Type: multipart/alternative;
	boundary="=_alternative 000802F5882576E3_="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 000802F5882576E3_=
Content-Type: text/plain; charset="US-ASCII"

Hi all,

Okay, I'm putting on my asbestos underwear and hoping I don't sound too 
stupid.  Here's my sitch: we're seeing an illegal instruction exception, 
but the tracks our diagnostic code we put into the kernel 
program_check_exception() function claims the instruction is perfectly 
good.  So I want to use the BDI to set a BP in the program exception and 
poke around at a HW level rather than a SW level that has gone through an 
unknown number of context switches.

Now I know that using the BDI in exceptions is hard to do for lots of 
reasons, first and foremost among them being the fact that the BDI uses 
SRR0/1 for it's own purposes.  I've been down this path before and know 
there's problems.  But what I'm seeing is even stranger than usual. 

I've replaced the program exception code in arch/powerpc/kernel/head_32.S 
with the following:

        . = 0x700
ProgramCheck:
        mtspr   SPRN_SPRG1,r9
        mtspr   SPRN_SPRG2,r10
        mtspr   SPRN_SPRG7,r3
        mfspr   r9,SPRN_SRR0
        mfspr   r10,SPRN_SRR1
        andis.  r3,r10,0x0008           /* is it an illegal instruction? 
*/
        beq     1f                      /* no so continue */
2:      xor     r3,r3,r3                        /* dummy instruction */
        b       2b                      /* loop forever */
1:      mfspr   r10,SPRN_SPRG2
        mfspr   r9,SPRN_SPRG1
        EXCEPTION_PROLOG;
        addi    r3,r1,STACK_FRAME_OVERHEAD;
        EXC_XFER_STD(0x700, program_check_exception);

(Before everyone flames me, yes I know there's a bug, I didn't restore r3 
before continuing to the program_check_exception; it's immaterial to the 
problem at hand because I don't really care if I ever successfully get 
into program_check_exception.)  The purpose of all this is to save SRR0/1 
into GPRs so the BDI doesn't whack them, check to see if the exception is 
being call because of an illegal instruction, continue on if not, and 
provide a place to hang a breakpoint if it is an illegal instruction.  So 
I load up this code, connect to the BDI, set a HW BP on the branch 
instruction following the line labeled '2', tell it to go and sit back to 
wait.

Eventually our problem occurs and the BDI says "TARGET: stopped" or some 
such, indicating it's hit the breakpoint.  This is where things get 
strange and I need help.  At this point the BDI output from the telnet 
session says the debug entry cause is <unknown 0> and the current PC is 
0x6fc, one instruction before the program exception.  When I dump the 
registers r9 and r10 contain nothing the even remotely resemble SRR0/1. 
The link register contains a valid _physical_ address (though I would 
expect it to contain a virtual address from the last 'bl' instruction) but 
when I dump the memory pointed to by LR it contains all zeros, not PPC 
machine code.  It looks like my code isn't even running even though it 
seems I've hit the breakpoint.  It's almost as if the BDI recognizes I'm 
entering an exception that I've set a BP in and halts just before 
executing the exception code.  I'm not sure I believe it, but that's how 
it appears.

Has anyone seen this or have any suggestion on how I can get the BDI to 
quit 'helping' me and just stop where I tell it to in an exception 
handler?

Thanks

Bruce
--=_alternative 000802F5882576E3_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi all,</font>
<br>
<br><font size=2 face="sans-serif">Okay, I'm putting on my asbestos underwear
and hoping I don't sound too stupid. &nbsp;Here's my sitch: we're seeing
an illegal instruction exception, but the tracks our diagnostic code we
put into the kernel program_check_exception() function claims the instruction
is perfectly good. &nbsp;So I want to use the BDI to set a BP in the program
exception and poke around at a HW level rather than a SW level that has
gone through an unknown number of context switches.</font>
<br>
<br><font size=2 face="sans-serif">Now I know that using the BDI in exceptions
is hard to do for lots of reasons, first and foremost among them being
the fact that the BDI uses SRR0/1 for it's own purposes. &nbsp;I've been
down this path before and know there's problems. &nbsp;But what I'm seeing
is even stranger than usual. </font>
<br>
<br><font size=2 face="sans-serif">I've replaced the program exception
code in arch/powerpc/kernel/head_32.S with the following:</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; .
= 0x700</font>
<br><font size=2 face="sans-serif">ProgramCheck:</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mtspr
&nbsp; &nbsp; &nbsp; &nbsp;SPRN_SPRG1,r9</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mtspr
&nbsp; &nbsp; &nbsp; &nbsp;SPRN_SPRG2,r10</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mtspr
&nbsp; &nbsp; &nbsp; &nbsp;SPRN_SPRG7,r3</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mfspr
&nbsp; &nbsp; &nbsp; &nbsp;r9,SPRN_SRR0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mfspr
&nbsp; &nbsp; &nbsp; &nbsp;r10,SPRN_SRR1</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; andis.
&nbsp; &nbsp; &nbsp; &nbsp;r3,r10,0x0008 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;/* is it an illegal instruction? */</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; beq
&nbsp; &nbsp; &nbsp; &nbsp;1f &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*
no so continue */</font>
<br><font size=2 face="sans-serif">2: &nbsp; &nbsp; &nbsp; &nbsp;xor
&nbsp; &nbsp; &nbsp; &nbsp;r3,r3,r3 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*
dummy instruction */</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; b
&nbsp; &nbsp; &nbsp; &nbsp;2b &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*
loop forever */</font>
<br><font size=2 face="sans-serif">1: &nbsp; &nbsp; &nbsp; &nbsp;mfspr
&nbsp; &nbsp; &nbsp; &nbsp;r10,SPRN_SPRG2</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; mfspr
&nbsp; &nbsp; &nbsp; &nbsp;r9,SPRN_SPRG1</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; EXCEPTION_PROLOG;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; addi
&nbsp; &nbsp; &nbsp; &nbsp;r3,r1,STACK_FRAME_OVERHEAD;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; EXC_XFER_STD(0x700,
program_check_exception);</font>
<br>
<br><font size=2 face="sans-serif">(Before everyone flames me, yes I know
there's a bug, I didn't restore r3 before continuing to the program_check_exception;
it's immaterial to the problem at hand because I don't really care if I
ever successfully get into program_check_exception.) &nbsp;The purpose
of all this is to save SRR0/1 into GPRs so the BDI doesn't whack them,
check to see if the exception is being call because of an illegal instruction,
continue on if not, and provide a place to hang a breakpoint if it is an
illegal instruction. &nbsp;So I load up this code, connect to the BDI,
set a HW BP on the branch instruction following the line labeled '2', tell
it to go and sit back to wait.</font>
<br>
<br><font size=2 face="sans-serif">Eventually our problem occurs and the
BDI says &quot;TARGET: stopped&quot; or some such, indicating it's hit
the breakpoint. &nbsp;This is where things get strange and I need help.
&nbsp;At this point the BDI output from the telnet session says the debug
entry cause is &lt;unknown 0&gt; and the current PC is 0x6fc, one instruction
before the program exception. &nbsp;When I dump the registers r9 and r10
contain nothing the even remotely resemble SRR0/1. &nbsp;The link register
contains a valid _physical_ address (though I would expect it to contain
a virtual address from the last 'bl' instruction) but when I dump the memory
pointed to by LR it contains all zeros, not PPC machine code. &nbsp;It
looks like my code isn't even running even though it seems I've hit the
breakpoint. &nbsp;It's almost as if the BDI recognizes I'm entering an
exception that I've set a BP in and halts just before executing the exception
code. &nbsp;I'm not sure I believe it, but that's how it appears.</font>
<br>
<br><font size=2 face="sans-serif">Has anyone seen this or have any suggestion
on how I can get the BDI to quit 'helping' me and just stop where I tell
it to in an exception handler?</font>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br>
<br><font size=2 face="sans-serif">Bruce</font>
--=_alternative 000802F5882576E3_=--
