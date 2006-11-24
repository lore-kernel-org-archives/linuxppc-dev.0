Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 1D96867A5E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 02:11:54 +1100 (EST)
In-Reply-To: <f9a7e7a80611232013o74fc2c43y7ee10835e4839fcf@mail.gmail.com>
References: <f9a7e7a80611232013o74fc2c43y7ee10835e4839fcf@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D43917F8-B0F1-4F6A-A5BA-1C72B569D9DA@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: MMU issue on mpc8270
Date: Fri, 24 Nov 2006 10:11:55 -0500
To: "Lei Sun" <leisun124@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 23, 2006, at 11:13 PM, Lei Sun wrote:

> Hi all:
>     While trying to bring up the kernel-2.4.30, my debugger failed to
> show memory content after MMU is turned on.

Sounds like a debugger configuration problem.

> ...  So I added some debug
> serial_putc() function copied from u-boot. (since u-boot has
> intialized the UART).

You don't need to do this.  There is sufficient and working
early serial debug in the kernel that is started as early
as possible.

> ....  The code did printed out the debug message
> untill it reached "mapin_ram()" function.  To be precise, in
> map_page() funcion, after pte_alloc() , serial_putc() doesn't work
> anymore.

There are times during the kernel initialization
when all of the MMU mapping is being configured,
that you have to be cognisant of the mapping
changes.  Early mappings disappear in favor of
more "operational" ones, so the serial port mapping
is going to change as well.  The call to pte_alloc()
is irrelevant, except that it affects the MMU configuration
and likely removes the old mappings.

The 82xx boot up initialization works fine, and
is completely generic to any board at this point.

> Rigth now, my kernel does seems to be running, but i just couldn't see
> anything on the serial console,

Fix your debugger configuration so it works in
this environment, or use xmon or early serial
debug options that are built into the kernel.

> .... I have examined the serial console
> portion of the code for many times, couldn't seems any thing wrong.

Have you selected the proper kernel configuration
or passed the proper console= parameter to the
kernel?

Thanks.

	-- Dan
