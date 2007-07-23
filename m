Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD322DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 01:37:32 +1000 (EST)
Message-ID: <46A4CB29.9080705@billgatliff.com>
Date: Mon, 23 Jul 2007 10:37:13 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Bill Gatliff <bgat@billgatliff.com>,  gdb@sourceware.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: Gdbserver syscall clobber
References: <469B922D.3050701@billgatliff.com>
	<20070716155348.GA5281@caradoc.them.org>
	<469E550E.5080905@billgatliff.com>
	<20070718183143.GA25324@caradoc.them.org>
In-Reply-To: <20070718183143.GA25324@caradoc.them.org>
Content-Type: multipart/alternative;
	boundary="------------000609060503080909060902"
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
--------------000609060503080909060902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Jacobowitz wrote:
> On Wed, Jul 18, 2007 at 12:59:42PM -0500, Bill Gatliff wrote:
>   
>> Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
>> lately), but it looks to me like the kernel is setting bit 0 in CR0
>> (oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0
>> (bnslr+) bit 3 a.k.a. SO.  Or maybe the other way around, I'm not sure
>> after reading Sections 1.2 and 2.1 of the Programming Environments manual.
>>     
>
> It's not checking for restart here - userspace isn't supposed to have to.
> It's probably checking for error.  Check for the bit of kernel code
> that's supposed to back you up two instructions.
>
>   

I don't see it in this kernel.  What I see is this after the call to the 
syscall handler:

    li    r10,-_LAST_ERRNO
    cmpl    0,r3,r10
    blt    30f
    neg    r3,r3
    cmpi    0,r3,ERESTARTNOHAND
    bne    22f
    li    r3,EINTR
22:    lwz    r10,_CCR(r1)    /* Set SO bit in CR */
    oris    r10,r10,0x1000
    stw    r10,_CCR(r1)
30:    stw    r3,GPR3(r1)    /* Update return value */
    b    ret_from_except
66:    li    r3,ENOSYS
    b    22b


?

-- 
Bill Gatliff
bgat@billgatliff.com


--------------000609060503080909060902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Daniel Jacobowitz wrote:
<blockquote cite="mid20070718183143.GA25324@caradoc.them.org"
 type="cite">
  <pre wrap="">On Wed, Jul 18, 2007 at 12:59:42PM -0500, Bill Gatliff wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
lately), but it looks to me like the kernel is setting bit 0 in CR0
(oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0
(bnslr+) bit 3 a.k.a. SO.  Or maybe the other way around, I'm not sure
after reading Sections 1.2 and 2.1 of the Programming Environments manual.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It's not checking for restart here - userspace isn't supposed to have to.
It's probably checking for error.  Check for the bit of kernel code
that's supposed to back you up two instructions.

  </pre>
</blockquote>
<br>
I don't see it in this kernel.&nbsp; What I see is this after the call to
the syscall handler:<br>
<br>
<tt>&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp; r10,-_LAST_ERRNO<br>
&nbsp;&nbsp;&nbsp; cmpl&nbsp;&nbsp;&nbsp; 0,r3,r10<br>
&nbsp;&nbsp;&nbsp; blt&nbsp;&nbsp;&nbsp; 30f<br>
&nbsp;&nbsp;&nbsp; neg&nbsp;&nbsp;&nbsp; r3,r3<br>
&nbsp;&nbsp;&nbsp; cmpi&nbsp;&nbsp;&nbsp; 0,r3,ERESTARTNOHAND<br>
&nbsp;&nbsp;&nbsp; bne&nbsp;&nbsp;&nbsp; 22f<br>
&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp; r3,EINTR<br>
22:&nbsp;&nbsp;&nbsp; lwz&nbsp;&nbsp;&nbsp; r10,_CCR(r1)&nbsp;&nbsp;&nbsp; /* Set SO bit in CR */<br>
&nbsp;&nbsp;&nbsp; oris&nbsp;&nbsp;&nbsp; r10,r10,0x1000<br>
&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp; r10,_CCR(r1)<br>
30:&nbsp;&nbsp;&nbsp; stw&nbsp;&nbsp;&nbsp; r3,GPR3(r1)&nbsp;&nbsp;&nbsp; /* Update return value */<br>
&nbsp;&nbsp;&nbsp; b&nbsp;&nbsp;&nbsp; ret_from_except<br>
66:&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp; r3,ENOSYS<br>
&nbsp;&nbsp;&nbsp; b&nbsp;&nbsp;&nbsp; 22b<br>
</tt><br>
<br>
?<br>
<br>
<pre class="moz-signature" cols="80">-- 
Bill Gatliff
<a class="moz-txt-link-abbreviated" href="mailto:bgat@billgatliff.com">bgat@billgatliff.com</a>
</pre>
</body>
</html>

--------------000609060503080909060902--
