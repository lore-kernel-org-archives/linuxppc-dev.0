From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: After add CONFIG_MODULES,it works noting?
Date: Tue, 8 May 2001 19:33:37 +0900
Message-ID: <OMENKEONFDLIGLHPFALBMEOLCCAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <3AF75886.01661@bjapp2>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Maybe we can write programe controling simple hardware in user space not in kernel sapce.About KGDB ,does it need more device? Thanks.

-> KGDB uses just console for display printk output on target. After selecting KGDB support on kernel configuration, place breakpoint() where you want to begin debugging. Even in module you can use it. (I can't remember whether you should export breakpoint symbol.) Notice that you should place breakpoint after console initialized.
GDB in host will communicate with target with the serial target used for console.

	I still don't konw why after uncompressing kernel,it works noting.
But when I remove CONFIG_MODULES from config file,it works well again.

-> Actually, I don't know why it hangs. But how about checking whether the symbols in no use are exported?

When
arch/ppc/mbxboot/head.s give the control to init/main.c ,it will
display LINUX_BANNER information,but it do noting,I think serial port must
works well.My bootloader is pSOS's.

-> if it hangs just after transmit on serial port, these banner may not displayed. If you want to check kernel executes that command, how about use test LED?



 ==============================================
  Kwansuk Kim
  Engineer, NeoWave Inc.
  Tel   +82-31-380-4927    Fax +82-31-380-4747
  E-mail: kskim@neowave.co.kr
==============================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
