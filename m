Date: Sat, 22 Mar 2003 19:15:58 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Ludovico Cavedon <lumaca82@inwind.it>
Subject: open_pic.c compilation error (fwd)
Message-ID: <Pine.GSO.4.21.0303221915310.8894-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


---------- Forwarded message ----------
Date: Sat, 22 Mar 2003 17:00:23 +0100
From: Ludovico Cavedon <lumaca82@inwind.it>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: open_pic.c compilation error

Hi.

I have just tried to compile linux 2.4.20 behn kernel on a new-world
iMac and found that ppc/open_pic.c has a compilation problem:

openpic_setup_lock is defined this way:
>>>
#if defined(CONFIG_SMP) || defined(CONFIG_PMAC_PBOOK)
static spinlock_t openpic_setup_lock = SPIN_LOCK_UNLOCKED;
#endif
<<<

but if CONFIG_SMP nor CONFIG_PMAC_PBOOK are defined, but CONFIG_ALL_PPC
is, openpic_sleep_save_intrs fails to compile:
>>>
#ifdef CONFIG_ALL_PPC
[...]
void __pmac
openpic_sleep_save_intrs(void)
{
	[...]
        spin_lock_irqsave(&openpic_setup_lock, flags);
<<<

I'm not sending a patch becouse I don't have the knoledge to know where
it has to be modified.

Bye,
Ludovico Cavedon


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
