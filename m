Message-ID: <003b01c2d09b$77863e70$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLCEBAFKAA.joakim.tjernlund@lumentis.se> <3E46BF7E.3080408@embeddededge.com>
Subject: Re: [PATCH] 8xx_io/uart.c
Date: Mon, 10 Feb 2003 01:29:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Early printk's will call it too.
>
> They shouldn't.  All printk's prior to serial device initialization
> are queued in the log buffer.  After the serial device is initialized,
> the debug console is configured and only at that time will the printk
> information flow through the driver.  Anything queued up to that point
> is blasted out the driver.  There are lots of console drivers that
> will fail if Linux chooses to change this behavior.

Still the first half of the printk's has the if expression true, then it switch
to false for the remaing one's and stayed there during boot up.
This is how I tested it:
remove the *cp = 13 line and add:
if ((uint)(bdp->cbd_bufaddr) > (uint)IMAP_ADDR){
   cp = (u_char *)(bdp->cbd_bufaddr);
   *cp = 64;
} else {
   cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
  *cp = 65;
}
Then just watch the a normal boot.
>
> > Now, why do you do the same thing just a few lines up if it wasn't needed?
>
> It is needed there.  These same functions support xmon and kgdb.  In order
> to do that the serial port is used in three different phases.  One, as it
> was configured by the boot rom/loader, two, by an early serial initialization
> before general memory management and buffering is available, and finally
> after the driver has been completely initialized.  None of this is needed
> to simply support the Linux console.  This has all been discussed too many
> times before....

I don't buy that it is needed only in one place but not the other.
Either none of them is needed or both. After a little investigation it looks like
none of them is needed, but I need to test that first to be sure.

These comments are also in there:
/*
 * We need to gracefully shut down the transmitter, disable
 * interrupts, then send our bytes out.
 */
and
/*
 * Finally, Wait for transmitter & holding register to empty
 *  and restore the IER
 */
and yet there is no sign of trying to do any of that.
Once user space gets going won't printk's from the kernel risk confusing
the real serial driver since interrupts are active?
This driver is not very easy to understand.

Also, the last 'if(info)' is rendundant. 'info' will never be NULL.
>
> > How about checking your own facts and provide an accurate analysis before
> > bitching at me for trying to help out?
>
> All I asked is you somehow show it is broken, and that something has
> been fixed before we start patching things.  If there is really something
> wrong with it, I would like to know what that is and how it is triggered.

OK, I was a little harsh, but your answer wasn't helping me much

>
> > I tested my how much I had increase them until I didn't lose any chars.
> > I don't think this has anything to do with HW flow control. The
> > smc runs out of BD's when trying to echo back the chars.
>
> Then, someone upstream isn't watching return values from these functions
> when the driver indicates there isn't space to output the characters.
> It isn't the responsibility of the serial driver to provide sufficient
> queueing for an arbitrary output request.  The depth of the fifo on the 8xx
> is much deeper than most silicon uarts, and if that isn't enough I suspect
> something outside of this driver is amiss (or interfaces have changed and
> this driver wasn't updated).

Yes, Paul Ruhland has found a bug in drivers/char/n_tty.c that explains
some of the problems I have seen.

   Jocke
PS.
    Could you please also comment on the enet.c driver patch I sent.
>
> Thanks.
>
> -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
