Message-ID: <3D99B224.8050107@mrsl.com>
Date: Tue, 01 Oct 2002 10:33:08 -0400
From: Tim Moloney <moloney@mrsl.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Location for Linux kernel module support files
References: <3D9871CE.7010607@mrsl.com> <20021001003223.GJ10265@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Gibson wrote:

> On Mon, Sep 30, 2002 at 11:46:22AM -0400, Tim Moloney wrote:
>
>>I have written a device driver (module) that needs a configuration
>>file.  Where is the standard place to put such files?
>
> There isn't.  Device drivers, being part of the kernel, should not be
> reading random files from the user's file system.  If the driver needs
> configuration, the normal method is for userland scripts (either
> startup or hotplug) to issue commands to poke the configuration into
> the driver at runtime.
>
>>I originally put it in the same directory as the .o file but
>>'depmod -a' complains that it's not an ELF file.

The file the device driver needs is an FPGA program file that
- is data that I don't want compiled into the driver wasting space
- will initially be specified when the driver is loaded via rc script
- that can be reloaded by a program to customize it for a particular
   application

I know that this isn't a a typical situation and I have only seen one
other device driver like this.  It is a 1553 driver that creates a
/usr/lib/<module_name> directory for its configuration file.  Is there
a better location?

--
Tim Moloney
ManTech Real-time Systems Laboratory
2015 Cattlemen Road                             \     /
Sarasota, FL  34232                     .________\(O)/________.
(941) 377-6775 x208                        '  '  O(.)O  '  '

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
