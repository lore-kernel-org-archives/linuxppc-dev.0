Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Barker Michael-r43496" <Michael.D.Barker@motorola.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 11 Oct 2002 09:28:06 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLEEAJFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3DA5A858.50802@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan

> Joakim Tjernlund wrote:
>
>  > .... The driver(i2c-algo-8xx.c) that
> > comes with the kernel has other severe bugs(memory corruption etc.) as well.
>
> Just toggle the bits in software.  I never saw an application where the I2C
> controller provided a performance advantage.  It's lots of software to execute,
> along with all of the interrupt handling and stuff, so you just spend lots of
> overhead not making any other progress.

I2C speed is not very important to me, but freeing up the CPU to do other things is. If
there are just a few bytes data to read/write it probably does not matter, but if you
read/write I2C memories(>128 bytes) it will matter and the I2C controller will make
a difference. One could also adjust the i2c-algo-8xx.c to busy wait for small reads/writes
instead of using interrupts if the interrupt handling overhead is significant.

Anyway I have fixed the bugs in i2c-algo-8xx.c driver and it's working great for me
so I think I will stick with it for the time being.

  Thanks

       Jocke

>
> Make sure you carefully analyze the entire system performance advantages.
> Using the controller assitance just because it is there isn't always the
> proper solution.  Same is true for the SPI.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
