Return-Path: <peterarbejde@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id E760067B66
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 19:06:22 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so2716361pyc
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 02:06:21 -0700 (PDT)
Message-ID: <36468a5c0610170206t79ff9318q67de66465bfa19d1@mail.gmail.com>
Date: Tue, 17 Oct 2006 11:06:20 +0200
From: "Peter N. Andreasen" <peterarbejde@gmail.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Linas Vepstas" <linas@austin.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: Linux on custom Xilinx board with PPC405 hangs on boot
In-Reply-To: <36468a5c0609210040o3f2fad38r7f6f9848ffa48ec8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060920235716.GV29167@austin.ibm.com>
	<995B09A8299C2C44B59866F6391D263516BFD2@zch01exm21.fsl.freescale.net>
	<36468a5c0609210040o3f2fad38r7f6f9848ffa48ec8@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/21/06, Peter N. Andreasen <peterarbejde@gmail.com> wrote:
> Liu, Linas, list
> Thanks a lot for the answers. It helped me to review the hardware configuration again.
> The problem was the definition of the Flash size.
> It turns out that the Xilinx generated header files define the size of the Flash. But the kernel also has a configuration option: Memory Technology Devices / Mapping Drivers for Chip Access / Physical Length of Chip Mapping
> My arch/ppc/platforms/xilinx_ocp/xparameters_ml300.h defines this as 4Mbyte, but the option in the kernel was set to 64 Mbyte (an extra 0 which I had not seen)

Hello list,
I have successfully booted the kernel, but the uartlite device seems
to give me a lot of headache. I am using Busybox v. 1.0 and made some
changes to the libb.h:
# define CURRENT_VC "/dev/ttl0"
# define VC_1 "/dev/ttl1"
# define VC_2 "/dev/ttl2"
# define VC_3 "/dev/ttl3"
# define VC_4 "/dev/ttl4"
# define VC_5 "/dev/ttl5"

#  define SC_0 "/dev/ttl0"
#  define SC_1 "/dev/ttl1"
#  define SC_FORMAT "/dev/ttl%d"
# define VC_FORMAT "/dev/ttl%d"

To make sure I get the correct device node I also changed this in
xuartllite_serial.h:
#define XULITE_MINOR_START	187
#define UARTLITE_TTY_NAME	"ttl"
#define UARTLITE_TTY_DEVFS_NAME	"ttl/%d"
#define UARTLITE_CU_NAME	"cul"
#define UARTLITE_CU_DEVFS_NAME	"cul/%d"
#define XULITE_MAJOR            204
#define XULITE_AUX_MAJOR        205

The system stops when init launches the busybox init process. This is
the message I get just after "Freeing unused kernel memory: 44k init"

First I got an assert() from the Xilinx Uartlite driver:
...
init started:  Bu
<2>Xilinx OS Independent Code XAssert:  xuartlite.c:194
Code may crash due to unhandled errors.
...
and the system stops.
The check made in the driver is for a 0 length string. If I change it
to ignore that, the console show this instead:
init started:  Bu
init started:  B
trying to run init_process
...
(the "trying to run init process" is a message I put in
run_init_process in init.c in the kernel, and the message it tries to
output is "init started: Busybox version 1.0 .....")

Now my question is:
What exactly are the device nodes I have to make in /dev/ on the
ramdisk on target? I made a ttl, ttl0, and tty  which have major
204/minor 187, and ttl1, ttl2 minor 188 and 189. I also
Hope someone can help me on this

Peter
