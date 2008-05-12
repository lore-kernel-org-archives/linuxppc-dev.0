Return-Path: <sanalvk@centillium.com>
Received: from ns2.centillium.com (mxout.centillium.com [12.47.55.9])
	by ozlabs.org (Postfix) with ESMTP id 5BDE6DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 00:33:57 +1000 (EST)
Message-ID: <48285544.7040908@centillium.com>
Date: Mon, 12 May 2008 20:03:40 +0530
From: Sanal Kumar V K <sanalvk@centillium.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Running a section of code from internal memory
References: <4822E5CE.3090701@centillium.com>
	<20080508153315.GC18740@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080508153315.GC18740@ld0162-tx32.am.freescale.net>
Content-Type: text/html; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks a lot Scott for replying.<br>
<br>
The attribute section is working, but one problem: the compiler is
automatically assigning address for the section and ld returns error is
I try to assign the address for this section in a linker script:<br>
<br>
Following is the disassembly when I don't specify an address for the
same section name in the linker script:<br>
Disassembly of section .l2_scratch:<br>
<br>
004ae820 &lt;.l2_scratch&gt;:<br>
&nbsp; 4ae820:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3c1c0fb9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lui&nbsp;&nbsp;&nbsp;&nbsp; gp,0xfb9<br>
&nbsp; 4ae824:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 279c1d90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; gp,gp,7568<br>
&nbsp; 4ae828:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0399e021&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addu&nbsp;&nbsp;&nbsp; gp,gp,t9<br>
&nbsp; 4ae82c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 27bdffd0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; sp,sp,-48<br>
&nbsp; 4ae830:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; afbf0028&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra,40(sp)<br>
&nbsp; 4ae834:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; afbe0024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s8,36(sp)<br>
&nbsp; 4ae838:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------<br>
&nbsp; <br>
<br>
And the section shows:<br>
Idx Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File off&nbsp; Algn<br>
&nbsp; 0 .reginfo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000018&nbsp; 00400094&nbsp; 00400094&nbsp; 00000094&nbsp; 2**2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTENTS, ALLOC, LOAD, READONLY, DATA,
LINK_ONCE_SAME_SIZE<br>
&nbsp; 1 .init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000088&nbsp; 004000ac&nbsp; 004000ac&nbsp; 000000ac&nbsp; 2**2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTENTS, ALLOC, LOAD, READONLY, CODE<br>
&nbsp; 2 .text&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 000ae6e0&nbsp; 00400140&nbsp; 00400140&nbsp; 00000140&nbsp; 2**4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTENTS, ALLOC, LOAD, READONLY, CODE<br>
&nbsp; 3 .l2_scratch&nbsp;&nbsp; 000004f0&nbsp; 004ae820&nbsp; 004ae820&nbsp; 000ae820&nbsp; 2**2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTENTS, ALLOC, LOAD, READONLY, CODE<br>
&nbsp; 4 -----&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------<br>
<br>
<br>
Now if I make the following entry in the linker script, <br>
&nbsp; /* define L2 scratch here */<br>
&nbsp; . = 0x9FC16800;<br>
&nbsp; .l2_scratch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : { *(.l2_scratch) }<br>
<br>
it says "collect2: ld returned 1 exit status".<br>
<br>
Is there any way I can assign address for the section used in attribute?<br>
<br>
Thanks and regards,<br>
Sanal<br>
<br>
Scott Wood wrote:
<blockquote
 cite="mid:20080508153315.GC18740@ld0162-tx32.am.freescale.net"
 type="cite">
  <pre wrap="">On Thu, May 08, 2008 at 05:06:46PM +0530, Sanal Kumar V K wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">A small part of the code needs to run from the on-chip "L2 scratch" for
getting optimum performance. I would really appreciate if some could
give me some pointers regarding the following questions:

1. Is #pragma section supported by gcc.
The compiler prints this warning "ignoring #pragma section" and the
pragma is ignored indicating that it is not supported. Is there any way
I can get the pragma working for gcc or any alternative?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
__attribute__((section("section name")))

-Scott


  </pre>
</blockquote>
</body>
</html>
