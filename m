Message-Id: <200006251813.UAA00680@piglet.grunz.lu>
Date: Sun, 25 Jun 2000 20:13:46 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: ide_delay_50ms() freezing on PPC?
To: linuxppc-dev@lists.linuxppc.org, andre@linux-ide.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

The latest 2.4.0 kernels don't boot on my machine anymore. They just
freeze in detecting the Promise Ultra66 IDE controller, specifically in
ide_delay_50ms(). Here is the code:

void ide_delay_50ms (void)
{
#ifndef CONFIG_BLK_DEV_IDECS
        unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
        while (0 < (signed long)(timeout - jiffies));
#else
        __set_current_state(TASK_UNINTERRUPTIBLE);
        schedule_timeout(HZ/20);
#endif /* CONFIG_BLK_DEV_IDECS */
}

CONFIG_BLK_DEV_IDECS is support for PCMCIA IDE devices, which is not
configured in my kernel. So that function hangs if using the 'manual'
delay. Everything is OK if I force it to use schedule_timeout(), which
by the way was always the case until a few kernels ago.

So, why does the 'manual' way hang? (I suppose interrupts are not
disabled at this point, are they?)

And why can we only use schedule_timeout() if compiling with
CONFIG_BLK_DEV_IDECS?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
