Subject: Re: how to compile linux modules
To: "ysmsun" <youshouming@163.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <OF09758596.F9C3EDF6-ON86256DFD.00572941-86256DFD.005A49E7@us.ibm.com>
From: Ryan Arnold <ryanarn@us.ibm.com>
Date: Mon, 15 Dec 2003 10:26:10 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alright, I'll try to help.

First of all I'm not sure what type of system you are on but I'll write
this email assuming that you are on a 64 bit POWER architecture machine.

Question: Is your driver being built for 2.4 or for 2.6 or both?  If you
are building for 2.6 there are some extra steps you may need to take when
setting up the driver initialization code.  Please check out
"http://lwn.net/Articles/driver-porting/" for tips on porting drivers to
2.6.

Question:  Is this going to be a kernel module that you want built out of
the kernel tree?  For the sake of this email I'll assume that it is.

The first thing you need to do is  to make sure that you add a line like to
the Makefile in the directory where the file will reside.  For instance for
the console driver called hvc_console you'll see the following line in
drivers/char/Makefile:

obj-$(CONFIG_HVC_CONSOLE)       += hvc_console.o

If you want the kernel's make system to allow you to enable the driver as a
built in driver or a module you need add an entry to the device directory's
Kconfig file like the following is done to driver/char/Kconfig for
hvc_console.

config HVC_CONSOLE
        bool "pSeries Hypervisor Virtual Console support"
        depends on PPC_PSERIES
        help
          pSeries machines when partitioned support a hypervisor virtual
          console. This driver allows each pSeries partition to have a
console
          which is accessed via the HMC.

You'll notice that "bool" precedes the label for the device driver.  Using
"bool" in this place will allow the driver to be selected as only compiled
in or not configured.  If you want the third option of "module" then you
need to replace "bool" with "tristate" for your own device.

To build you may have to use a cross compiler.  Please make sure you have a
working toolchain and compiler on your build machine.  You can check out
linuxppc64.org for information on attaining these.

Next, do the following from the base kernel directory:

make mrproper
make menuconfig
make CROSS_COMPILE=powerpc64-linux- -j4
make modules CROSS_COMPILE=powerpc64-linux- -j4

Once you run "make" it will build your driver into a .o and when you run
"make modules" it will make a .ko for you kernel module.  This .ko will be
located in the driver directory where you created the file.  Now when you
put this module on a system make sure the system is running the kernel that
you built it against to avoid issues with missing symbols.

Put the kernel on the system, reboot, put on the .ko and insmod <your
driver>.ko.

In order to insert, build, and execute module operations for 2.6 your
system may need the new module utilities installed.  You can get these from
"http://www.kernel.org/pub/linux/kernel/people/rusty/modules/".  You'll
know you need them if insmod complains about unrecognized symbols.

Ryan S. Arnold
IBM Linux Technology Center (LTC)
POWER Linux Virtual I/O
Rochester, Minnesota, USA
Dept. 8DNA
ryanarn@us.ibm.com




                      "ysmsun"
                      <youshouming@163.com>             To:       <linuxppc-dev@lists.linuxppc.org>
                      Sent by:                          cc:
                      owner-linuxppc-dev@lists.l        Subject:  how to compile linux modules
                      inuxppc.org


                      12/12/2003 10:37 PM







hello:
    now ,i must write some driver program module .but when i try some
module which is from some books ,it always don.t work well.I guess maybe
because of compiling command. When i try to read some MAKEFILE files to
get the compiling command ,i found it so complex .maybe someone could
give me some advice ,some expierence...wish your help thanks ....

previous happy christamas!!!!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
