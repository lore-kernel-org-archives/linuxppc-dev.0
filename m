Message-ID: <3891E609.298E1F8A@sgi.com>
Date: Fri, 28 Jan 2000 12:55:05 -0600
From: Mike Wolf <mwolf@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: booting sequence for embedded kernels
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I'm new to kernel development and I have some questions regarding
running linux on the IBM-403.  I have gotten the 2.3.39 kernel and
Grant Erickson's patches.  When I attempt to boot the board just hangs.
I'm using bootp and tftp to load.  I see the following and have some
questions

I see an ARP/RARP exchange followed by a bootp request reply.  Then tftp
kicks in and downloads the file.  The board reports that the entry point
is 0x200000.

>From now on I see nothing coming over the serial line and on the
workstation
the snoop is showing the workstation sending an RARP that should be
picked
up by the board.

My questions.

1)  How is the serial console specified?  When configuring the kernel
for
    compilation I answered y to CONFIG_SERIAL_CONSOLE.  In
arch/ppc/treeboot/
    main.c, I set the boot command line [static char *cmdline =
"console=ttyS0,
    9600].  I noticed that in init/main.c in the start_kernel routine
that
    a printk of the banner is done.  I'm not seeing this banner, so
where
    do I start debugging?

2)  Where does the kernel start setting up the network interface?  I
assume
    this is why I'm seeing an arp/rarp exhange after the tftp completes.

3)  What is the general sequence of a typical bootp?
    a) run bootp to find out image to load
    b) run tftp to download and load into memory
    c) jump to start location and start executing?

    Is a,b,c the general step or is there more.

Sorry if these are obvious questions, I've looked on the net and in some
linux kernel books and have not found the answers.

The board is an IBM 403 and I'm using IBM's rom monitor to load the
image.
The workstation is a Sun sparc station 5 running solaris 2.7.

--
Mike Wolf
Cray Research
655-F Lone Oak Drive, Eagan, MN 55121
mwolf@cray.com          (651)683-5313

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
