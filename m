In-Reply-To: <v01540b02b37673433b9a@[192.168.100.2]>
Date: Sun, 30 May 1999 12:50:22 +0200
To: bskrypny@MBnet.MB.CA, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: cuda and apm?
Message-Id: <19990530125022.018557@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, May 29, 1999,  <bskrypny@MBnet.MB.CA> wrote:

>1. Does via-cuda currently handle only adb requests or are other requests
>hidden in adb_request structure?

via_cuda handles adb requests and a bunch of cuda-specific requests, like
PowerOff, restart, RTC management, I2C access, etc...
since my last patches (I think around 2.2.7), all requests go thru a
single entry point (sorry, I don't have the exact name in mind and I
don't have the source now) in the ADB controller driver. Note that
PowerBooks don't use via-cuda but via-pmu, which is a different
microcontroller with more power management features. Some basic cuda
requests are emulated by the via-pmu driver however.

>2. Are there any Mac ROM routines that can be accessed to deal with cuda
>controller?

For the PMU (PowerBooks), it's called _PMgrOp (0xa085), and you pass a
pointer to a structure in A0 with the following layout:

#pragma options align=mac68k
struct pmu_params
{
	unsigned short	command;
	unsigned short	size;
	unsigned char*	buffer1;
	unsigned char*	buffer2;
};
#pragma options align=reset

(the pragmas mean 2-bytes alignement). I'm not On sure of the exact
layout, this is what I have seen after doing various experiments. buffer1
is apparently the input buffer.

There's another trap, _ADBOp (0xA07C) which is used to send ADB commands
independantly of the underlying controller. It's documented in Inside
Macintosh.

Finally, there's another trap which is more specific to Cuda (I _think_,
I'm really not sure with this one), and it is _EgretDispatch (0xA092).
Code that uses the I2C bus send Cuda commands via this trap (like Apple's
VDIG for example). I didn't test enough to find out the exact calling
convention for this one.

Note that those calls cannot be issues from linuxppc, they depend on
MacOS 68k emulator to be up and running.

>3. What are apm plans for linuxppc.

I don't know if there are any plans, but there are already some specific
things implemented:

 - I _think_ (check the source) that the idle task puts the processor
into DOZE mode. (Note: the Grackle bridge could be configured to follow
the processor in this mode)

 - On PowerBook, power on the serial ports and internal modem should be
switched off when not used.

 - On PowerBooks 3400 and first generation G3s (OHare based), sleep works
via special ioctl to /dev/pmu (via-pmu). There is a queue in the kernel
where various device drivers can register to get notified of
sleep/wakeup. New PowerBooks cannot sleep yet, some reverse-engineering
of MacOS ROM still need to be done. Basically, when the machine sleeps,
the CPU is turned off and is reset on wakeup. Some ROM code handles the
reset by testing a fixed memory location for a structure containing
context-resume informations. I have plans to try to figure out the layout
and address of this structure and eventually implement the necessary
support in Linux, but I don't have more infos about it so I have to
disassemble things, and this takes time.

>4. Where can I find technical description of cuda controller (I know at
>Apple, but I couldn't find anything better than a general description and a
>cursory mention in the context of PowerManager API ).

In the sources. Look at linuxppc, MkLinux, Darwin, netbsd-ppc, etc...

>I hope to do some work for apm (to get my feet wet :)

Great ! 

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
