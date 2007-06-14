Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 5E8F5DDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jun 2007 03:13:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Status of MPC5200B FEC driver ?
Date: Thu, 14 Jun 2007 17:13:24 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01FFF50D@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01FFF4F9@is-hdq-exchange.marel.net>
References: <DD39B5C3F4963040ADC9768BE7E430CB01FFF4F9@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Daniel Schnell" <daniel.schnell@marel.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hmm,

If I initiate first a ping from within U-Boot and then boot Linux via =
IDE, the FEC works.

Seems that some initialization is missing inside the Linux MPC5200 FEC =
driver ?


Best regards,

Daniel.


-----Original Message-----
From: linuxppc-embedded-bounces+daniel.schnell=3Dmarel.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+daniel.schnell=3Dmarel.com@ozlabs.org] =
On Behalf Of Daniel Schnell
Sent: 14. j=FAn=ED 2007 16:50
To: linuxppc-embedded@ozlabs.org
Subject: Status of MPC5200B FEC driver ?

Hi,

I have problems with the MPC5200B fec driver.

On my custom board I can successfully boot/mount via NFS. I use a 2.6.20 =
kernel patched with all kind of things from Pengutronix Phytec MPC5200b =
tiny and patches IO collected from teh mailing list, like -rt, ata, fec, =
bestcomm (from Secretlab), etc. When activating the realtime scheduling, =
I undeterministically get errors like:

=3D=3D=3D=3D
FEC_IEVENT_RFIFO_ERROR (00020000)
NETDEV WATCHDOG: eth0: transmit timed out NETDEV WATCHDOG: eth0:
transmit timed out NETDEV WATCHDOG: eth0: transmit timed out NETDEV
WATCHDOG: eth0: transmit timed out
printk: 7 messages suppressed.
FEC_IEVENT_RFIFO_ERROR (00020000)
NETDEV WATCHDOG: eth0: transmit timed out NETDEV WATCHDOG: eth0:
transmit timed out ...
=3D=3D=3D=3D
The device doesn't work after these.

Thomas Gleixner meant, this could have to do with the driver not beeing =
SMP safe, which would be a problem under -RT, similar to the problems he =
had with ibm_emac once. I can confirm when disabling -RT and enabling =
normal Linux scheduling things go to the better side again.

However if I boot via IDE I can not access eth0.  Cmd ifconfig gives =
normal values as configured from the u-boot cmd line:
=3D=3D=3D
eth0      Link encap:Ethernet  HWaddr 00:E0:EE:00:28:0D
          inet addr:10.100.99.251  Bcast:10.100.255.255 Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:133 Base address:0x3000 =3D=3D=3D

A ifdown eth0 cmd gives the output:
=3D=3D=3D
fec_close: queues didn't drain
=3D=3D=3D

Which somehow sounds odd.

Ifup eth0 cmd tells me:
=3D=3D=3D
eth0: link down
=3D=3D=3D

Output from ping is sth. like network unreachable, which I can somehow =
understand if the above cmds do not work.


Trying to bring me up-to-date as described in =
http://www.246tnt.com/mpc52xx/ to see where my patchset differs from the =
latest, doesn't work, for the least of executing git clone on =
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git=20

I get errors like:

=3D=3D=3D=3D
...
error: Couldn't get
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/re
fs/tags/v2.6.11 for tags/v2.6.11
The requested URL returned error: 404
error: Could not interpret tags/v2.6.11 as something to pull =
=3D=3D=3D=3D

So I am somewhat stuck, but maybe anybody has a better idea how to get =
the latest MPC5200B support or some ideas about the ethernet problems ?


Best regards,

Daniel Schnell.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
