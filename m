Date: Wed, 17 Sep 2003 11:33:37 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <IGEFJKJNHJDCBKALBJLLEEFHFPAA.joakim.tjernlund@lumentis.se>
To: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>
Cc: Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEFNFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> OK, here is my attempt to fix the 8xx uart driver. With this
> patch I can no longer break the console from user space. Against fairly recent
> linuxppc_devel snapshot. Please comment/apply.
>
> Summary:
>
>  - uses local_irq_save()/local_irq_restore() around tx_cur accesses.
>    I haved tried to minimize the time between local_irq_save() and local_irq_restore()
>
>  - Fixed a bug around copy_from_user() in rs_8xx_write().
>
>  - my_console_write() is still buggy. It takes a little more effort to fix
>    this function. It should be fixed since a spurious printk can screw/lock your console.

I am taking a stab at my_console_write() as well. I have something that works well
for me, but i am unsure if I have broken KGDB/XMON support. In my new my_console_write()
I must know the length of the TX buffer in the TXBD. The TX buffer length when the console
is fully operational is TX_BUF_SIZE. Before that, in serial_console_setup, the length
is 4 bytes. But what is the TX buffer length before serial_console_setup has run(that's
when KGB/XMON is active)?

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
