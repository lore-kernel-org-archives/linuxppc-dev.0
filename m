Message-ID: <38961D55.C544EB7A@netx4.com>
Date: Mon, 31 Jan 2000 18:40:05 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <3896AEAE.B261AAAD@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan John Simon wrote:

>     Board Data at: 001001C4 001001E0
>     relocated to:  00200100 0020011C
>     Boot args at:  00200000 00200200

> I'm a little concerned about the overlap of BootArgs and the relocated
> BoardData.  Does this seem right or wrong to anyone ?

No, that is the way it is supposed to work.  I doubled the
size of the boot arguments (it is only 256 bytes), and placed
the board information structure there.  I just didn't update
the messages to further describe what is going on.  This
information is really only useful when debugging the boot
code, and it seems to be working now.

The command line and board information structure must reside
within the first 8Mbytes, and it seemed somewhat logical to
me to just use the same buffer space.


> ....  It was suggested to me that the UPM was probably incorrect and
> that's why it fails with the caches enabled.


I was the one that probably suggested that.  If all of the
memory mapping is correct (IMMR > 0xd0000000, and such) this
is usually where I start looking, since the code is known to
operate on other platforms.


> ....  I have tried with 4 different UPM settings for a 25MHz bus
> with 60ns EDO DRAM.


Although others may be more talented, I have never been able
to program the UPM without the actual DRAM specifications,
schematics and a logic analyzer connected to the processor bus.
Guessing at UPM values is kind of like playing the lottery.


> ....  Is there anything else the kernel expects to be setup
> ?

Not much.  Obviously the DRAM must be configured because the
kernel is loaded there.  Beyond that it just reads the IMMR
and maps it.


> How can I tell where it is failing ?  I don't think I can use printk as
> the console is not setup yet.  Is this correct ?


Here is a hint.  Look at the symbol table from System.map and
convert the address of log_buf to a physical address (mask the
upper couple of bits).  Dump this area of memory, as all of the
printk() messages end up in this buffer before they are sent to
the console.


> Getting a little desperate now.


Are those ready-for-production boards looking any better yet :-)?
The world is passing you by........


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
