Message-Id: <5.1.0.14.2.20021001100707.02dbfb50@mail.attbi.com>
Date: Tue, 01 Oct 2002 10:07:15 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Location for Linux kernel module support files
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim,

At 07:33 AM 10/1/2002, you wrote:

>David Gibson wrote:
>
>>On Mon, Sep 30, 2002 at 11:46:22AM -0400, Tim Moloney wrote:
>>
>>>I have written a device driver (module) that needs a configuration
>>>file.  Where is the standard place to put such files?
>>
>>There isn't.  Device drivers, being part of the kernel, should not be
>>reading random files from the user's file system.  If the driver needs
>>configuration, the normal method is for userland scripts (either
>>startup or hotplug) to issue commands to poke the configuration into
>>the driver at runtime.
>>
>>>I originally put it in the same directory as the .o file but
>>>'depmod -a' complains that it's not an ELF file.
>
>The file the device driver needs is an FPGA program file that
>- is data that I don't want compiled into the driver wasting space
>- will initially be specified when the driver is loaded via rc script
>- that can be reloaded by a program to customize it for a particular
>   application
>
>I know that this isn't a a typical situation and I have only seen one
>other device driver like this.  It is a 1553 driver that creates a
>/usr/lib/<module_name> directory for its configuration file.  Is there
>a better location?

For similar situation (I also need to load FPGA on our custom board) I just
coded
a simple "char" device (e.g. /dev/fpga).
User mode program or simple script writes into this device and
the driver sends this data to the PLD chip.

For debugging I use something like
     # cp fpga.bin /dev/fpga

With this design driver itself doesn't have any knowledge about particular
location of
the FPGA program.

Thanks,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
