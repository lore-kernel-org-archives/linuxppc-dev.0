Message-Id: <200006152144.XAA00755@piglet.grunz.lu>
Date: Thu, 15 Jun 2000 23:44:00 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: FW: [linux-usb] D-Link DSB-500 Adapter probs
To: randy.dunlap@intel.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F0545CD70@orsmsx31.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Get (or tell the user to) my PCI patches at:

http://www.cpu.lu/~mlan/linux/dev/pci.html

Alternatively, if this is a 2.3/2.4 kernel, get the maintainer of the
USB code to call enable_device() in his PCI detection code.

Michel

On  13 Jun, this message from Dunlap, Randy echoed through cyberspace:
>
> Hi,
>
> A Linux USB user reported this PCI IRQ assignment
> problem.  Martin Mares suggested that I send this
> to you.
>
> Any suggestions or fixes that you can recommend?
>
> Thanks,
> Randy
>
> PS: Please cc me on replies.
>
> -----Original Message-----
> From: Dunlap, Randy [mailto:randy.dunlap@intel.com]
> Sent: Sunday, June 11, 2000 12:48 PM
> To: 'Peter R. Wood'; linux-usb@suse.com
> Cc: rio500-devel@lists.sourceforge.net; 'mj@suse.cz'
> Subject: RE: [linux-usb] D-Link DSB-500 Adapter probs
>
>
> I/O space on the UHCI controller is not enabled.
> See below.
>
> Hi Martin-  Any ideas/suggestions about this?
>
>
>> From: Peter R. Wood [mailto:pwood@gordon.edu]
>>
>> Hello,
>>
>> I am having troubles with a D-Link DSB-500 USB adapter card,
>> specifically
>> with using a Diamond Rio 500. I'm emailing these lists on the
>> suggestion
>> of Keith Clayton from the rio500-linux team.
>>
>> I have a UMAX SuperMac J700/1800 (PowerMac clone) with a PCI
>> bus, and a
>> fairly standard PowerMac motherboard.  I am currently running LinuxPPC
>> 2000, with kernel 2.2.16 downloaded from ftp.kernel.org, and the USB
>> 2.3.99 to 2.2.14+ backport patched in. I have compiled the kernel with
>> usbcore, usb-uhci (not the alternate uhci), and rio500 modules.
>>
>> My problem comes when I try to connect to my Rio using the
>> rio500 utils. I
>> first try rio_format, but I get the message:
>>
>> ---
>> Could not open /dev/usb/rio500: Device or resource busy
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> I haven't figured out the root source/cause of this, but
> the problem is below.
>
>> Verify that the rio module is loadad and your Rio is
>> connected and powered up.
>> ---
>> I've verified that I have the correct node created for the rio in
>> /dev/usb:
>>
>> crw-rw-rw-    1 root     root     180,  64 Jun 11 01:25
>> /dev/usb/rio500
>>
>> Here are some informational messages from the kernel, and
>> from lspci -v:
>>
>> in dmesg, the kernel reports the following when I load the modules:
>>
>> usb.c: registered new driver usbdevfs
>> usb.c: registered new driver hub
>> usb-uhci.c: $Revision: 1.228 $ time 01:46:10 Jun 11 2000
>> usb-uhci.c: High bandwidth mode enabled
>> usb-uhci.c: USB UHCI at I/O 0x1000, IRQ 1
>> usb-uhci.c: Detected 2 ports
>> usb.c: new USB bus registered, assigned bus number 1
>> usb-uhci.c: USBCMD_HCRESET timed out!  ********************************[1]
>> usb.c: USB new device connect, assigned device number 1
>> hub.c: USB hub found
>> hub.c: 2 ports detected
>> usb.c: registered new driver rio500
>> rio500.c: USB Rio support registered.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> [1] This shouldn't happen.
>
>> lspci -vv tells me about the controller:
>>
>> 01:00.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev
>> 04) (prog-if 00 [UHCI])
>> 	Subsystem: Unknown device 0925:1234
>> 	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> I/O- means that I/O space is not enabled in the Command register.
> My system shows "I/O+".
> Also see 6 (of lspci) lines below where it says "[disabled]".
>
> This is a problem with PCI resource assignment.
>
>
>> ParErr- Stepping+ SERR- FastB2B-
>> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR+ <PERR-
>> 	Latency: 32, cache line size 08
>> 	Interrupt: pin A routed to IRQ 1
>> 	Region 4: I/O ports at 1000 [disabled]
>>
>> I am unfortunately unable to test whether this card works under MacOS
>> since I do not have access to a new enough version of the
>> MacOS. I know
>> that the Rio is working fine, since I connected to it using its
>> including cable on another Mac (B&W G3 w/built in USB) via
>> MacOS and the
>> RioPort software. I was able to get the status and send some
>> mp3 files to it.
>>
>> If anyone has suggestions, I'd be grateful. Let me know if there's any
>> other information about my setup (hardware/software) that I could give
>> you.
>
> ~~Randy
>
>


-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
