Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <s1110fc4.060@gateway.p-com.com>
Date: Wed, 04 Aug 2004 16:32:48 -0700
From: "Nivedita Pitre" <Nivedita.Pitre@p-com.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux booting problems in the IBM Bubinga Board
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using U-boot to boot linux kernel on the IBM Bubinga (405EP board). Using kernel version 2.6.7, which has a default config file for this board. Changed the board info structure to match u-boot's board information structure. Using the mkimage utility in u-boot to create a uImage, which I am downloading via tftpserver to u-boot. Uboot recognizes this image, and jumps into the kernel, after which the system hangs. The last message I see is uncompressing kernel -- OK. I read the manual for u-boot, which suggests modifying the board information structure, and I did that, still have the same problem. After this, I turned on kernel hacking in the config, the CONFIG_SERIAL_TEXT_DEBUG on. This allows me to see some progress on the serial port, the ppc_mach_dep calls output some messages. This tells me that code reaches in start_kernel, however, after console_init, the serial port dies. I assume this is because we initialize the serial port, and turn off early debug. I commented o
 u!
t this part, and enabled early debug messages to continue throughout the start_kernel routine. Also added my own debug messages. So far as I can see, the code goes through till the end of start_kernel without hanging. This makes me think this is a serial port problem in the kernel, but I cannot think what it is. I have configured the UART_TTYSO, SERIAL_CONSOLE, and 8250 drivers in the .config file, and so far as I can see, all the relevant .o files are created, so these drivers are getting compiled. Does anyone have any suggestions for debugging. I am setting up BDI200 to debug this problem. Let me know if there is something else that I am not doing right.

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
