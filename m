Message-ID: <3D99F21B.5090408@mrsl.com>
Date: Tue, 01 Oct 2002 15:06:03 -0400
From: Tim Moloney <moloney@mrsl.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: Eugene Surovegin <ebs@innocent.com>, geert@linux-m68k.org
Subject: Re: Location for Linux kernel module support files
References: <5.1.0.14.2.20021001100707.02dbfb50@mail.attbi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Moloney wrote:

> The file the device driver needs is an FPGA program file that
> - is data that I don't want compiled into the driver wasting space
> - will initially be specified when the driver is loaded via rc script
> - that can be reloaded by a program to customize it for a particular
>   application
>
> I know that this isn't a a typical situation and I have only seen one
> other device driver like this.  It is a 1553 driver that creates a
> /usr/lib/<module_name> directory for its configuration file.  Is there
> a better location?

Eugene Surovegin wrote:

> For similar situation (I also need to load FPGA on our custom board) I just
> coded
> a simple "char" device (e.g. /dev/fpga).
> User mode program or simple script writes into this device and
> the driver sends this data to the PLD chip.
>
> For debugging I use something like
>     # cp fpga.bin /dev/fpga
>
> With this design driver itself doesn't have any knowledge about particular
> location of
> the FPGA program.

Geert Uytterhoeven wrote:

 > So your kernel driver should create a /proc entry where the rc script
 > can write the FPGA program file to after insmod.
 >
 > If the FPGA program file is to be reloaded by the application, it can
 > just write the new data to the same /proc entry.

I do something like this now but neither of these answer *where* to put
the file that is being copied to the /proc entry.

I want to distribute a standard FPGA program file with the module and
have it loaded at system boot time.  I can create an rc script to copy
this file to the /proc entry.  I can package the module, rc script, and
FPGA file in an RPM.  I just need to determine a reasonable location for
the FPGA file (since I know where to put the module and rc script).

The custom FPGA files can be distributed with their respective
applications and can be packaged in RPMs.

Perhaps there is no good answer to this.  I thought that this situation
happened enough that people had found a reasonable location for support
files.

--
Tim Moloney
ManTech Real-time Systems Laboratory
2015 Cattlemen Road                             \     /
Sarasota, FL  34232                     .________\(O)/________.
(941) 377-6775 x208                        '  '  O(.)O  '  '

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
