Date: Mon, 19 Mar 2001 18:29:16 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: losing interrupts - printk is bad
In-Reply-To: <3AB63E12.6D38973E@esd-electronics.com>
Message-ID: <Pine.HPX.4.10.10103191822450.13151-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Mar 2001, Matthias Fuchs wrote:

>
> Hi,
>
> I got a nice problem: I am working on an embedded PPC board (IBM405CR)
> with a serial console (115200 baud). While I was testing some new driver
> code, I made a lot of prink debugging output - as we all like to do :-)
> My problem is, that I always lose some bytes on an other serial port. I
> found out that printk waits until the complete format string is send
> through the console. That takes about 5 ms for 40 bytes. During this
> time printk blocks the interrupts !!! That means some incomming data on
> the other serial port can be (and is) lost. This is a very strange
> problem.
>
> Well first would be glad to get a good workaround. Well, a 'klogd -c 1'
> turn off all the debuggin and printk is much faster, but I need the
> debugging output.
>
> Second, could anybody explain t ome, what klogd is doing ? It would be
> glad to get klogd read all the debugging output from the kernel and
> output the data from user space (well buffered and not blocking the
> whole system). It seems that klogd cannot do that, am I right ?

Do you have a nettwork (Ethernet interface) ? I get all my debugging
output in /var/log/messages on another system with properly configured
syslogd. Of course, if has to go through userspace but once you've got
your driver stable enough , it should not be a problem.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
