Return-Path: <leisun124@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id 035C167A3B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 05:28:53 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so945516wxd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Nov 2006 10:28:51 -0800 (PST)
Message-ID: <f9a7e7a80611241028x26b7c119t9cc3916d29400485@mail.gmail.com>
Date: Fri, 24 Nov 2006 13:28:51 -0500
From: "Lei Sun" <leisun124@gmail.com>
To: "Dan Malek" <dan@embeddedalley.com>
Subject: Re: MMU issue on mpc8270
In-Reply-To: <D43917F8-B0F1-4F6A-A5BA-1C72B569D9DA@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f9a7e7a80611232013o74fc2c43y7ee10835e4839fcf@mail.gmail.com>
	<D43917F8-B0F1-4F6A-A5BA-1C72B569D9DA@embeddedalley.com>
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

Thanks for the reply.

I sure did put console=ttyS0,57600 as the command line.  I am afraid I
am not able to fix the debugger problem in short time because I am
using codewarrior + USB TAP, which i think it's not working well after
MMU turned on.

Would you care to explain why the kernel use BAT and Paging mode at
the same time in mapin_ram() function? which one take precedence ?
I wonder if xmon would work on 82xx, it appears to be for 8xx only.
got some error message when trying to compile it with the option set.

Thanks
lei


On 11/24/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On Nov 23, 2006, at 11:13 PM, Lei Sun wrote:
>
> > Hi all:
> >     While trying to bring up the kernel-2.4.30, my debugger failed to
> > show memory content after MMU is turned on.
>
> Sounds like a debugger configuration problem.
>
> > ...  So I added some debug
> > serial_putc() function copied from u-boot. (since u-boot has
> > intialized the UART).
>
> You don't need to do this.  There is sufficient and working
> early serial debug in the kernel that is started as early
> as possible.
>
> > ....  The code did printed out the debug message
> > untill it reached "mapin_ram()" function.  To be precise, in
> > map_page() funcion, after pte_alloc() , serial_putc() doesn't work
> > anymore.
>
> There are times during the kernel initialization
> when all of the MMU mapping is being configured,
> that you have to be cognisant of the mapping
> changes.  Early mappings disappear in favor of
> more "operational" ones, so the serial port mapping
> is going to change as well.  The call to pte_alloc()
> is irrelevant, except that it affects the MMU configuration
> and likely removes the old mappings.
>
> The 82xx boot up initialization works fine, and
> is completely generic to any board at this point.
>
> > Rigth now, my kernel does seems to be running, but i just couldn't see
> > anything on the serial console,
>
> Fix your debugger configuration so it works in
> this environment, or use xmon or early serial
> debug options that are built into the kernel.
>
> > .... I have examined the serial console
> > portion of the code for many times, couldn't seems any thing wrong.
>
> Have you selected the proper kernel configuration
> or passed the proper console= parameter to the
> kernel?
>
> Thanks.
>
>        -- Dan
>
>
