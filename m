Subject: Re: IBM 440GP 36-bit addressing
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Vishwanath <vishwanath@mistralsoftware.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <001101c24b3c$ae0cca70$faffa8c0@VISHWANATH>
References: <001501c24ab5$daee9500$faffa8c0@VISHWANATH>
	<1030114823.8559.37.camel@granite.austin.ibm.com>
	<001101c24b3c$ae0cca70$faffa8c0@VISHWANATH>
Content-Type: text/plain
Date: 26 Aug 2002 10:48:27 -0500
Message-Id: <1030376908.1348.73.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2002-08-24 at 02:05, Vishwanath wrote:
>
> By going through the code, I understood that ioremap64() is used for mapping
> the 36-bit real address onto 32-bit effective address space. How this
> mapping information is conveyed to user applications ?

I don't understand the question. Do you mean "how does userspace know
what the kernel has ioremapped"? I don't think it does.

Do you mean "how can userspace map in a 36-bit real address"? The usual
(32-bit) way is to mmap(/dev/mem). I don't know if that will work with
36-bit addresses.

> If I am writing assembly instructions to access 440GP registers, do I have
> to pass 36-bit real address or 32-bit effective address ?

Do you mean a memory-mapped register, i.e. an on-chip peripheral like
the UART? If so, that's what we've been talking about. You must map the
36-bit real address into your 32-bit effective address space, then
access the effective address.

> Physical address map of 440GP provides information only about Real
> addresses.  How can I convert these real addresses onto effective addresses
> ? Do I have to write a TLB entry regarding my addresses ?

Exactly, that's what I mean by "mapping".

Of course, some TLB entries may already have been set up for you by the
kernel or firmware. Whatever the case, you need to make sure there is a
TLB entry in place.

-Hollis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
