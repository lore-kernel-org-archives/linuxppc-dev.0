Message-ID: <877aabc40408240724500bb006@mail.gmail.com>
Date: Tue, 24 Aug 2004 19:54:18 +0530
From: Amit Shah <shahamit@gmail.com>
Reply-To: Amit Shah <shahamit@gmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RFI doesn't branch off?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have a strange issue with a custom board running a 750GX on a
Marvell 64360 bridge. I transferred control to the uImage via u-boot
(which I had to modify for my board-specific UART and SDRAM inits,
also disabling PCI).

Using the UART that's initialized by u-boot, I put some putchar()s in
head.S to figure out where the kernel was freezing. It seems 'rfi' in
mmu_off doesn't jump off to '__after_mmu_off' as expected. I also put
some pattern into SDRAM before an after mmu_off. I just see the
pattern (via a PCI interface) put before mmu_off.

The contents of SRR0 correctly point to __after_mmu_off just before
the 'rfi'. However, the 'rfi' documentation says the value of SRR0 is
concatenated with '0x0b00'. I don't think this should be done.
Anyways, since this code is supposed to work, I'm not sure why it
isn't working.

Can any u-boot initializations be causing this? I guess not, I've not
touched any CPU-specific settings in u-boot.

Can anyone give me some pointers?

Thanks,
Amit.
--
Amit Shah
http://amitshah.nav.to/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
