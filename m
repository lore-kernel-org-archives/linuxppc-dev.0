Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15]) by ozlabs.org (Postfix) with ESMTP id E28AC67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 02:32:59 +1100 (EST)
Message-ID: <456EF9AA.1010101@computing.dundee.ac.uk>
Date: Thu, 30 Nov 2006 15:32:58 +0000
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Sharon Feldman <sharonf@scopus.net>,  linuxppc-embedded@ozlabs.org
Subject: Re: Kernel Panic During Linux Boot on ML405
References: <8506C3905ED0764F889ADEB33E3A9E8062CF5D@MAIA.scopus.net>
In-Reply-To: <8506C3905ED0764F889ADEB33E3A9E8062CF5D@MAIA.scopus.net>
Content-Type: text/plain; charset=windows-1255; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sharon Feldman wrote:
> Make Sure That when you generate the bsp you need to specify the drivers you wish to generate bsp for in the software platform settings
> in "OS and Libraries" Tab you should click on the connected peripherial and add the peripherials you wish to generated bsp for, also you must specify a driver for them in the "DRIVERS" TAB, otherwise you will not beable to add them.
>   
That was exactly my problem.  I do feel pretty stupid, but I just 
assumed that when I selected mvl as the OS the EDK would assume that I'd 
quite like it to support my peripherals.  I've learnt my lesson over 
that one.  Sorry for bothering people.

However, now I have new problem, this time at shutdown.  I get the 
following messages:

The system is going down NOW !!
Sending SIGTERM to all processes.
Xilinx OS Independent Code XAssert: xuartlite.c:195
Code may crash due to unhandled errors.
gs: gs_close: bad port count; tty->count is 1, port count is 3
System halted.
System Halted

The assert at xuartlite.c:195 is:
XASSERT_NONVOID(((signed)NumBytes) >= 0);
during XUartLite_Send.  This checks to see if the number of bytes 
forming the send request is greater than zero (quite reasonably I 
feel).  The "gs" appears to relate to generic_serial and comes from 
gs_close in generic_serial.c  I don't understand any more than that.  
Does anyone have any ideas where to start looking?

Thanks,
-- Peter
