MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: Losing my console messages !!
Date: Mon, 5 Apr 2004 16:54:24 +0100
Message-ID: <85E6ED5B5EC32F439702305CC417E12D9E2A62@email.3il.fr>
From: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,
we can say that I am a newbie in Linux embedded application but the fact is that it is now my job.
I've search for 2 weeks a clue which could have helped me but no result.
So here is my problem: I have to port a Montavista LSP for cedar (board evaluation for the ppc npe405L on a different board which has also a npe405L.
I use a bootloader called bootrom which one dowload the zImage by ftp in ram. The filesystem is supposed to be mounted via NFS. The boot succeed on the original board (cedar). But when I try to boot it on my new board I have at the console the following messages:

Attached TCP/IP interface to ibmEmac0.
Attaching network interface lo0... done.
Loading...
 Reading data from host 9.100.123.254
start address cd82e8
block=ce92f4
block=d0943c
block=d29250
block=d4a4b4

Copying the board datas ...
loaded at:     00CD8308 00D63508
relocated to:  00400000 0048B200
board data at: 00488128 00488170
relocated to:  004054AC 004054F4
zimage at:     00405AA0 004875AF
avail ram:     0048C000 01000000

Linux/PPC load: console=ttyS0,38400 root=/dev/nfs ip=on rw
Uncompressing Linux...done.
Now booting the kernel

mcMCMkMkO8Z%M#QR.EM[XK!YUa~KMz8H.\I;SJCE,M<K.>+Y5H> E<+ °+ .++<U#UHT!Y.X5£<Ä_ +K
                                                                               \


>>> as you can see, the linux bootloader seems to be OK since I can get the "puts" messages of the bootloader. But after the register_console() function, all the messages in buffer are unreadable.
I noticed that on the ppcNPE405L, both UARTs can be clocked with an external clock (that's true with the cedar board) or can be internally clocked. On my new board, I haven't an external clock. Will it have an impact or Linux is able to automatically adapt its behavior??
Furthermore, the board-info that bootrom pass to linux is ok (I checked it with a puts test
//arch/ppc/platforms/ceder.h

typedef struct board_info {
	unsigned char	 bi_s_version[4];	/* Version of this structure */
	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
	unsigned char	 bi_enetaddr[2][6];	/* Local Ethernet MAC address */
	unsigned char	 bi_pci_mac[6];
	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
	unsigned int	 bi_pci_busfreq;	/* PCI speed in Hz */
} bd_t;

)

I noticed the presence of two "#define" which seem to be important but it's hard to me to understand how they really act:
include/asm-ppc/pc_serial.h -->   #define BASE_BAUD ( 1843200 / 16 )
arch/ppc/boot/common/ns16550.c--> #define SERIAL_BAUD	9600

Of course I've tried all the parameters on the console and none seems to be the one.
Thanks for helping me and feel free to tell me if you need further informations.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
