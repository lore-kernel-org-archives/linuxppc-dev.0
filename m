Message-ID: <3E46BF7E.3080408@embeddededge.com>
Date: Sun, 09 Feb 2003 15:52:14 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] 8xx_io/uart.c
References: <IGEFJKJNHJDCBKALBJLLCEBAFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Early printk's will call it too.

They shouldn't.  All printk's prior to serial device initialization
are queued in the log buffer.  After the serial device is initialized,
the debug console is configured and only at that time will the printk
information flow through the driver.  Anything queued up to that point
is blasted out the driver.  There are lots of console drivers that
will fail if Linux chooses to change this behavior.

> Now, why do you do the same thing just a few lines up if it wasn't needed?

It is needed there.  These same functions support xmon and kgdb.  In order
to do that the serial port is used in three different phases.  One, as it
was configured by the boot rom/loader, two, by an early serial initialization
before general memory management and buffering is available, and finally
after the driver has been completely initialized.  None of this is needed
to simply support the Linux console.  This has all been discussed too many
times before....

> How about checking your own facts and provide an accurate analysis before
> bitching at me for trying to help out?

All I asked is you somehow show it is broken, and that something has
been fixed before we start patching things.  If there is really something
wrong with it, I would like to know what that is and how it is triggered.

> I tested my how much I had increase them until I didn't lose any chars.
> I don't think this has anything to do with HW flow control. The
> smc runs out of BD's when trying to echo back the chars.

Then, someone upstream isn't watching return values from these functions
when the driver indicates there isn't space to output the characters.
It isn't the responsibility of the serial driver to provide sufficient
queueing for an arbitrary output request.  The depth of the fifo on the 8xx
is much deeper than most silicon uarts, and if that isn't enough I suspect
something outside of this driver is amiss (or interfaces have changed and
this driver wasn't updated).

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
