Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80368DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jul 2007 05:42:15 +1000 (EST)
Message-ID: <469E50EF.8000901@billgatliff.com>
Date: Wed, 18 Jul 2007 12:42:07 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: gdb@sourceware.org,  linuxppc-embedded@ozlabs.org
Subject: Re: Gdbserver syscall clobber
References: <469B922D.3050701@billgatliff.com>
	<20070716155348.GA5281@caradoc.them.org>
In-Reply-To: <20070716155348.GA5281@caradoc.them.org>
Content-Type: multipart/alternative;
	boundary="------------090703060407010509050508"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090703060407010509050508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Jacobowitz wrote:
> On Mon, Jul 16, 2007 at 10:43:41AM -0500, Bill Gatliff wrote:
>   
>> recv(4, 0x7ffffd60, 1, 0)               = ? ERESTARTSYS (To be restarted)
>> --- SIGIO (I/O possible) @ 0 (0) ---
>> syscall_4294966784(0xa, 0x7ffffd34, 0x1, 0, 0x1008a3c7, 0x1008b5a3, 0x1008b5a4, 
>>     
>
> That's -512, a.k.a. the errno value used by syscall restarting.  I'd
> say your glibc does not obey the restartable syscall convention used
> by your kernel, and when it tries to restart the syscall the errno
> value is not being replaced by the syscall number.  Check the assembly
> for recv.
>
>   

Very good catch!  Thanks soooo much.  Here's the code, from my libc.a:

00000000 <__libc_recv>:
   0:   94 21 ff d0     stwu    r1,-48(r1)
   4:   90 61 00 14     stw     r3,20(r1)
   8:   90 81 00 18     stw     r4,24(r1)
   c:   90 a1 00 1c     stw     r5,28(r1)
  10:   90 c1 00 20     stw     r6,32(r1)
  14:   81 42 00 0c     lwz     r10,12(r2)
  18:   2c 0a 00 00     cmpwi   r10,0
  1c:   40 82 00 20     bne-    3c <__libc_recv+0x3c>
  20:   38 60 00 0a     li      r3,10
  24:   38 81 00 14     addi    r4,r1,20
  28:   38 00 00 66     li      r0,102
  2c:   44 00 00 02     sc
  30:   38 21 00 30     addi    r1,r1,48
  34:   4c a3 00 20     bnslr+
  38:   48 00 00 00     b       38 <__libc_recv+0x38>

Again, this is 603e on linux-2.4.16 glibc-2.2.5 gcc-2.95.3.  (Odd, I 
can't seem to find this function in a statically-linked gdbserver, nor 
any reference to it in the gdbserver-6.5 source code).

On the kernel side:

_GLOBAL(DoSyscall)
...
        blrl                    /* Call handler */
        .globl  ret_from_syscall_1
ret_from_syscall_1:
20:     stw     r3,RESULT(r1)   /* Save result */
        li      r10,-_LAST_ERRNO
        cmpl    0,r3,r10
        blt     30f
        neg     r3,r3
        cmpi    0,r3,ERESTARTNOHAND
        bne     22f
        li      r3,EINTR
22:     lwz     r10,_CCR(r1)    /* Set SO bit in CR */
        oris    r10,r10,0x1000
        stw     r10,_CCR(r1)
30:     stw     r3,GPR3(r1)     /* Update return value */
        b       ret_from_except
...
ret_from_except:
...
        lwz     r3,_CCR(r1)
...
        mtcrf   0xFF,r3
...
        RFI


Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM 
lately), but it looks to me like the kernel is setting bit 0 in CR0 
(oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0 
(bnslr+) bit 3 a.k.a. SO.  Or maybe the other way around, I'm not sure 
after reading Sections 1.2 and 2.1 of the Programming Environments manual.

Or am I misinterpreting something?  I must be, this is well-trodden code 
I'm thinking...

The readchar() in gdbserver's remote-utils.c just calls read() on the 
file descriptor for the socket.  Still trying to track that code down...



b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


--------------090703060407010509050508
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Daniel Jacobowitz wrote:
<blockquote cite="mid20070716155348.GA5281@caradoc.them.org" type="cite">
  <pre wrap="">On Mon, Jul 16, 2007 at 10:43:41AM -0500, Bill Gatliff wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">recv(4, 0x7ffffd60, 1, 0)               = ? ERESTARTSYS (To be restarted)
--- SIGIO (I/O possible) @ 0 (0) ---
syscall_4294966784(0xa, 0x7ffffd34, 0x1, 0, 0x1008a3c7, 0x1008b5a3, 0x1008b5a4, 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That's -512, a.k.a. the errno value used by syscall restarting.  I'd
say your glibc does not obey the restartable syscall convention used
by your kernel, and when it tries to restart the syscall the errno
value is not being replaced by the syscall number.  Check the assembly
for recv.

  </pre>
</blockquote>
<br>
Very good catch!&nbsp; Thanks soooo much.&nbsp; Here's the code, from my libc.a:<br>
<br>
<tt>00000000 &lt;__libc_recv&gt;:<br>
&nbsp;&nbsp; 0:&nbsp;&nbsp; 94 21 ff d0&nbsp;&nbsp;&nbsp;&nbsp; stwu&nbsp;&nbsp;&nbsp; r1,-48(r1)<br>
&nbsp;&nbsp; 4:&nbsp;&nbsp; 90 61 00 14&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r3,20(r1)<br>
&nbsp;&nbsp; 8:&nbsp;&nbsp; 90 81 00 18&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r4,24(r1)<br>
&nbsp;&nbsp; c:&nbsp;&nbsp; 90 a1 00 1c&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r5,28(r1)<br>
&nbsp; 10:&nbsp;&nbsp; 90 c1 00 20&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r6,32(r1)<br>
&nbsp; 14:&nbsp;&nbsp; 81 42 00 0c&nbsp;&nbsp;&nbsp;&nbsp; lwz&nbsp;&nbsp;&nbsp;&nbsp; r10,12(r2)<br>
&nbsp; 18:&nbsp;&nbsp; 2c 0a 00 00&nbsp;&nbsp;&nbsp;&nbsp; cmpwi&nbsp;&nbsp; r10,0<br>
&nbsp; 1c:&nbsp;&nbsp; 40 82 00 20&nbsp;&nbsp;&nbsp;&nbsp; bne-&nbsp;&nbsp;&nbsp; 3c &lt;__libc_recv+0x3c&gt;<br>
&nbsp; 20:&nbsp;&nbsp; 38 60 00 0a&nbsp;&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r3,10<br>
&nbsp; 24:&nbsp;&nbsp; 38 81 00 14&nbsp;&nbsp;&nbsp;&nbsp; addi&nbsp;&nbsp;&nbsp; r4,r1,20<br>
&nbsp; 28:&nbsp;&nbsp; 38 00 00 66&nbsp;&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r0,102<br>
&nbsp; 2c:&nbsp;&nbsp; 44 00 00 02&nbsp;&nbsp;&nbsp;&nbsp; sc<br>
&nbsp; 30:&nbsp;&nbsp; 38 21 00 30&nbsp;&nbsp;&nbsp;&nbsp; addi&nbsp;&nbsp;&nbsp; r1,r1,48<br>
&nbsp; 34:&nbsp;&nbsp; 4c a3 00 20&nbsp;&nbsp;&nbsp;&nbsp; bnslr+<br>
&nbsp; 38:&nbsp;&nbsp; 48 00 00 00&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38 &lt;__libc_recv+0x38&gt;<br>
</tt><br>
Again, this is 603e on linux-2.4.16 glibc-2.2.5 gcc-2.95.3.&nbsp; (Odd, I
can't seem to find this function in a statically-linked gdbserver, nor
any reference to it in the gdbserver-6.5 source code).<br>
<br>
On the kernel side:<br>
<br>
<tt>_GLOBAL(DoSyscall)<br>
...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Call handler */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .globl&nbsp; ret_from_syscall_1<br>
ret_from_syscall_1:<br>
20:&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r3,RESULT(r1)&nbsp;&nbsp; /* Save result */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r10,-_LAST_ERRNO<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmpl&nbsp;&nbsp;&nbsp; 0,r3,r10<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blt&nbsp;&nbsp;&nbsp;&nbsp; 30f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; neg&nbsp;&nbsp;&nbsp;&nbsp; r3,r3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmpi&nbsp;&nbsp;&nbsp; 0,r3,ERESTARTNOHAND<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bne&nbsp;&nbsp;&nbsp;&nbsp; 22f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r3,EINTR<br>
22:&nbsp;&nbsp;&nbsp;&nbsp; lwz&nbsp;&nbsp;&nbsp;&nbsp; r10,_CCR(r1)&nbsp;&nbsp;&nbsp; /* Set SO bit in CR */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; oris&nbsp;&nbsp;&nbsp; r10,r10,0x1000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r10,_CCR(r1)<br>
30:&nbsp;&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp;&nbsp; r3,GPR3(r1)&nbsp;&nbsp;&nbsp;&nbsp; /* Update return value */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_from_except<br>
...<br>
ret_from_except:<br>
...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lwz&nbsp;&nbsp;&nbsp;&nbsp; r3,_CCR(r1)<br>
...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtcrf&nbsp;&nbsp; 0xFF,r3<br>
...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFI<br>
</tt><br>
<br>
Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
lately), but it looks to me like the kernel is setting bit 0 in CR0
(oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0
(bnslr+) bit 3 a.k.a. SO.&nbsp; Or maybe the other way around, I'm not sure
after reading Sections 1.2 and 2.1 of the Programming Environments
manual.<br>
<br>
Or am I misinterpreting something?&nbsp; I must be, this is well-trodden
code I'm thinking...<br>
<br>
The readchar() in gdbserver's remote-utils.c just calls read() on the
file descriptor for the socket.&nbsp; Still trying to track that code down...<br>
<br>
<br>
<br>
b.g.<br>
<pre class="moz-signature" cols="80">-- 
Bill Gatliff
<a class="moz-txt-link-abbreviated" href="mailto:bgat@billgatliff.com">bgat@billgatliff.com</a>
</pre>
</body>
</html>

--------------090703060407010509050508--
