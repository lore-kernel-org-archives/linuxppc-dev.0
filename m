Message-ID: <001101c24b3c$ae0cca70$faffa8c0@VISHWANATH>
From: "Vishwanath" <vishwanath@mistralsoftware.com>
To: "Hollis Blanchard" <hollis@austin.ibm.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <001501c24ab5$daee9500$faffa8c0@VISHWANATH> <1030114823.8559.37.camel@granite.austin.ibm.com>
Subject: Re: IBM 440GP 36-bit addressing
Date: Sat, 24 Aug 2002 12:35:50 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

Thanks for your information. I have few more doubts.

By going through the code, I understood that ioremap64() is used for mapping
the 36-bit real address onto 32-bit effective address space. How this
mapping information is conveyed to user applications ?

If I am writing assembly instructions to access 440GP registers, do I have
to pass 36-bit real address or 32-bit effective address ?

Physical address map of 440GP provides information only about Real
addresses.  How can I convert these real addresses onto effective addresses
? Do I have to write a TLB entry regarding my addresses ?

Thanks and Regards,
Vishwa


----- Original Message -----
From: "Hollis Blanchard" <hollis@austin.ibm.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, August 23, 2002 8:30 PM
Subject: Re: IBM 440GP 36-bit addressing


>
> On Fri, 2002-08-23 at 10:00, Vishwanath wrote:
> >
> > I am new to PPC Linux. I am working on IBM 440 GP board. I am using
> > MontaVista Linux source code. I didn't understand how 36-bit addressing
is
> > taken care in this code. If an application has to access the a memory
> > location in SDRAM of 440 GP or its internal peripheral registers,
whether it
> > has to pass 36-bit address or normal 32-bit address.
>
> It's a 36-bit real address space, but 32-bit effective (aka "virtual").
> Applications, which run entirely in effective address space, have no
> reason to think about such things and require no modification.
>
> The kernel has to care about the real address space, mostly when you
> want to ioremap (all the on-chip peripheral addresses are higher than
> 4GB as I recall) a 36-bit real address to a 32-bit effective address so
> you can use it in the kernel (which also runs in effective mode).
>
> -Hollis
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
