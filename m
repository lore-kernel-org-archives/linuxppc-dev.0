Date: Thu, 7 Jan 1999 14:37:18 +0100
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        debian-powerpc@lists.debian.org, linux-pmac@samba.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Bogus interrupts: test fix
Message-Id: <19990107143718.019579@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've updated the 2.2-pre4 test kernel on my web page, it contains a test
fix for the bogus interrupt problem. Please try it and give me feedback.
Also, do not worry about the "lost interrupts" counter I added to
/proc/interrupts, they are not really "lost" but I would be interested in
knowing how much of them you get with ordinary use of the system.

The "fix" looks like this:

void __pmac pmac_mask_and_ack_irq(int irq_nr)
{
	unsigned long bit = 1UL << (irq_nr & 0x1f);
	int i = irq_nr >> 5;

	if ((unsigned)irq_nr >= max_irqs)
		return;
	/*spin_lock(&irq_controller_lock);*/

	clear_bit(irq_nr, cached_irq_mask);
	if (test_and_clear_bit(irq_nr, lost_interrupts))
		atomic_dec(&n_lost_interrupts);
	out_le32(&pmac_irq_hw[i]->ack, bit);
	out_le32(&pmac_irq_hw[i]->enable, cached_irq_mask[i]);
	out_le32(&pmac_irq_hw[i]->ack, bit);
	do {
		/* make sure ack gets to controller before we enable interrupts */
		sync();
	} while(in_le32(&pmac_irq_hw[i]->flag) & bit);

	/*spin_unlock(&irq_controller_lock);*/
	/*if ( irq_controller_lock.lock )
	  panic("irq controller lock still held in mask and ack\n");*/
}

Note that the sync() may now be useless. I don't have anymore bogus
interrupts on the PowerBook for now but I usually have very few of them
anyway. I'm more interested by results from people with a real problem
(io slowdown due to lots of them).

I'll post this kernel on an ftp site later today too.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
