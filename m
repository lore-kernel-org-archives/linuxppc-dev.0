From: Subodh Nijsure <subodh@best.com>
Message-Id: <200107110235.TAA02964@shell9.ba.best.com>
Subject: Read write to ioremap_nocache are still cached?
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 10 Jul 2001 19:35:45 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have mapped memory area using ioremap_nocache() and what I observered
through logica analyzer is when I do simple word read or write there are
multiple read/write cycles happening on  the same address.

Code looks something like this --

	printk("Write reset word to PLD and read new stauts\n");
	pld_base = ioremap_nocache( physical_pld_address );
	*(pld_base + 0x8) = 0xA;
	newStatus = *(pld_base + 0x4);
	printk("Status word is %X \n",newStatus);

If I just move this code to by bootrom read/writes happen exactly
as I expect,  but when I move this code to kernel I see multiple
 read and writes. What could be the reason? Note this routine is
not called multiple times.

/Subodh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
