Date: Fri, 2 Apr 1999 17:22:01 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: VALETTE Eric <valette@crf.canon.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2306 problems dragging on
In-Reply-To: <m10T4gc-0000WXC@tri-yann.crf.canon.fr>
Message-ID: <Pine.SO4.4.05.9904021713190.23869-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Apr 1999, VALETTE Eric wrote:

> David> serial console gets flooded with two kinds of similar messages :
> 
> David> ``request_irq(): irq 4 handler c008dae8 name serial dev_id 0000`` and
> David> ``request_irq(): irq 4 handler c0000000 name <NULL> dev_id 0000``.
> 
> David> BTW, I'm using a /dev/console with major 5 minor 1. Inbetween those
> David> messages, I see some errors that seem to come from init. I have no update
> David> daemon, and bash cannot be loaded because it cannot find its libtermcap.
> David> When I manually make a link to libtermcap, there are no more errors,
> David> but also no more screen output at all.
>   
> David> Does anyone know how to get it correctly running ?
> 
> Fisrt I assumes that you are using a serial console to boot? If yes then
> change the /etc/inittab file to
> 
> 1:2345:respawn:/sbin/getty 38400 tty1 => 1:23:respawn:/sbin/getty -L ttyS0 9600 linux

 Thanks, that helped a bit. I'm using 

 1:23:respawn:/sbin/getty ttyS0 DT9600 vt220

 since I could not find any agetty (to use the -L option) in RH5.
 So, now the system boots like a real Linux machine, and I *finally* get
 a login prompt (Raw Hide 1.2.7). It says ``localhost login :''.
 Strange enough, when I type anything, the word 'login' appears on the
 next line, and then after a few secs, the login banner resets the screen.
 Also, backspace isn't working. It appears that I can walk through the
 screen. This seems just a simple terminal setting problem. But I don't
 see what's wrong. (BTW, I already added ``ttyS0'' to /etc/securetty).

 Regards,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"I want you to find happiness."
 - Marilyn Monroe in 'Gentlemen prefer Blondes'


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
