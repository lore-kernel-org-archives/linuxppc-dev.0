Subject: Re: IBM 440GP 36-bit addressing
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <001501c24ab5$daee9500$faffa8c0@VISHWANATH>
References: <001501c24ab5$daee9500$faffa8c0@VISHWANATH>
Content-Type: text/plain
Date: 23 Aug 2002 10:00:23 -0500
Message-Id: <1030114823.8559.37.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-08-23 at 10:00, Vishwanath wrote:
>
> I am new to PPC Linux. I am working on IBM 440 GP board. I am using
> MontaVista Linux source code. I didn't understand how 36-bit addressing is
> taken care in this code. If an application has to access the a memory
> location in SDRAM of 440 GP or its internal peripheral registers, whether it
> has to pass 36-bit address or normal 32-bit address.

It's a 36-bit real address space, but 32-bit effective (aka "virtual").
Applications, which run entirely in effective address space, have no
reason to think about such things and require no modification.

The kernel has to care about the real address space, mostly when you
want to ioremap (all the on-chip peripheral addresses are higher than
4GB as I recall) a 36-bit real address to a 32-bit effective address so
you can use it in the kernel (which also runs in effective mode).

-Hollis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
