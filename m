Message-ID: <3EFC7DE4.8080402@bluewin.ch>
Date: Fri, 27 Jun 2003 19:24:52 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Driver on Linux
References: <D96E2AFA0DF3D211B139009027454948034CBE5D@helios.gnv.tcc.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 06/27/2003 07:10 PM Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
> Hi.
>
> I am working on a PPC860.
>
> I have developped two drivers.
>
> The driver 2 needs to use functions that are in driver 1.
> driver 1 is /dev/visu.
>
> I thought I could make fd=open("/dev/visu", 0) in init of the driver 2 but I
> get ooops.

For file access within the kernel see for example:

  http://www.fenrus.demon.nl/kernel.html

> I also need to make

> I also need to make something like ioctl(fd, IO_Special... )but the function
> ioctl is unknown in the kernel.
>
> What is the right way to work when you need to do that ?

Using file access in the kernel is usually a bad thing. I think it's
easier and more straightforward to provide a small set of exported
kernel functions which the second (driver) module can use.

Hope it helps.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
