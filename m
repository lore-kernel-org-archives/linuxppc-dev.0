Return-Path: <nlv11891@natlab.research.philips.com>
Message-ID: <002901c52ba9$02dad390$9c9c9182@ddns.htc.nl.philips.com>
From: "S. van Beek" <nlv11891@natlab.research.philips.com>
To: "Peter Ryser" <Peter.Ryser@xilinx.com>,
	"S. van Beek" <nlv11891@natlab.research.philips.com>
References: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
	<4239A41E.7040200@xilinx.com>
	<001501c52b0a$0ee36ca0$9c9c9182@ddns.htc.nl.philips.com>
	<4239C6AE.3050803@xilinx.com>
Date: Fri, 18 Mar 2005 11:55:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff672
	board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We've booted the first kernel on the hardware with Flash, and that works
fine. So the hardware doesn't seem to be the problem.
We have a JTAG port, debugging and viewing the log_buf address after the
crash just gave us 8 zero's so no usefull hints there..
The kernel probably crashes before it can write anything to that buffer, or
before its initialized?

I'll also include the output we get here, maybe its helpfull:

loaded at:     00400000 004A11E0
board data at: 0049E138 0049E150
relocated to:  004052D4 004052EC
zimage at:     0040589F 0049D91C
avail ram:     004A2000 02000000

Linux/PPC load: root=/dev/nfs rw ip=on
Uncompressing Linux...done.
Now booting the kernel

And then it halts..

Any other suggestions would be welcome :)

Regards
Sander

----- Original Message ----- 
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
To: "S. van Beek" <nlv11891@prle>
Cc: <Linuxppc-embedded@ozlabs.org>
Sent: Thursday 17 March 2005 19:04
Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff672
board


> Also try to boot the first Linux kernel (the one without the Flash
> support) on the EDK design with Flash support. It will help narrow down
> the problem to the HW or the SW.
>
> - Peter
>
>
> S. van Beek wrote:
>
> >>How did you add the Flash (EMC) peripheral? Did you use the Base System
> >>Builder to generate your hardware?
> >>
> >>
> >
> >Yes, we started a new project using the base system builder with the same
> >options as the previous (working) project and flash, so the address range
> >should be ok. I'll check tomorrow, right now its time to go home ;)
> >
> >Regards,
> >Sander
> >
> >----- Original Message ----- 
> >From: "Peter Ryser" <Peter.Ryser@xilinx.com>
> >To: "S. van Beek" <nlv11891@prle>
> >Cc: <Linuxppc-embedded@ozlabs.org>
> >Sent: Thursday 17 March 2005 16:37
> >Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro
ff672
> >board
> >
> >
> >
> >
> >>How did you add the Flash (EMC) peripheral? Did you use the Base System
> >>Builder to generate your hardware?
> >>
> >>If you configure the hardware manually and use the OPB EMC make sure
> >>that you add the address range to the PLB2OPB bridge.
> >>
> >>- Peter
> >>
> >>
> >>S. van Beek wrote:
> >>
> >>
> >>
> >>>Hello there,
> >>>
> >>>This is our first post on this list, hi all!
> >>>We're two Dutch students working with a Virtex-II pro ff672 board from
> >>>Memec with the Communications 2 module. We've compiled a simple kernel
> >>>wich comes with MontaVista Linux 3.1 (2.4.20) with ethernet and a
> >>>serial port. It mounts its root filesystem over NFS and everything
> >>>seems to work nicely. The next step we wanted to make was
> >>>adding support for the Flash on the com board. We added the IP to the
> >>>hardware and loaded the new bitstream in the FPGA. Next thing, we
> >>>enabled support for MTD devices in the kernel. After that, the kernel
> >>>did not seem to boot anymore. It stopped at the message 'Now booting
> >>>the kernel'. So we read some documentation about debugging. We
> >>>recompiled this kernel with the -g -ggdb options and removed the -O
> >>>(optimalization) flag. Then we did not even see the ppc boot loader
> >>>messages anymore when trying to boot. So we tried to compile the first
> >>>kernel (with only serial and ethernet support) -wich worked fine
> >>>before- with debugging and it gave us the same result.. no output at
> >>>
> >>>
> >all.
> >
> >
> >>>Can anyone give us some hints on what we can try more to find out what
> >>>is going wrong?
> >>>
> >>>Regards,
> >>>Sander van Beek
> >>>Daniel van Os
> >>>
>
>>>------------------------------------------------------------------------
> >>>
> >>>_______________________________________________
> >>>Linuxppc-embedded mailing list
> >>>Linuxppc-embedded@ozlabs.org
> >>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>
> >>>
> >>>
> >>
> >>
> >>
> >
> >
> >
> >
> >
> >
>
>
>
>
