Subject: Linux Kernel Porting  in PPC405GPr
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFF7149A9F.93AD1B92-ON65256CF7.0028C780@lntinfotech.com>
From: "Alexander J" <Alexander.J@lntinfotech.com>
Date: Fri, 28 Mar 2003 13:11:49 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have a PPC 405GPr target board loaded with the customized PPCboot 1.1.5.
Now i am trying
to load the linux kernel into the target but unsuccessful. Could anyone pl
help?

The following is the procedure which i have followed.

.(a)  Downloaded the Linux-2.4.18 from the net (No support for the built-in
network card)
(b)
(c)   The following changes are done in the main make file existing in the
linux folder
      a.    Changed the architecture as ARCH :- ppc
      b.    Changed the cross compiler as CROSS COMPILE = powerpc-linux-
(d)   make menuconfig
(e)   make dep
(f)   make clean
(g)   make zImage. It created the image as zImage
(h)   Added the header to image using mkimage (mkimage -n xx -O linux - A
ppc -a 0000 -e 0000 -d xx ) as described  in the BSP.
(i)   Downloaded the image using the PPC monitor program tftpboot to the
default location 0x1000000
          => tftp 1000000 vmlinux
          miiphy_read: addr[0x0] reg[0x1]
          read err 3
          a2: read: EMAC_STACR=0xffffc001, i=2
          miiphy_read: addr[0x0] reg[0x5]
          read err 3
          a2: read: EMAC_STACR=0xffffc005, i=2
          PHY speed1 read failed, assuming 10bT
          miiphy_read: addr[0x0] reg[0x5]
          read err 3
          a2: read: EMAC_STACR=0xffffc005, i=2
          PHY duplex read failed, assuming half duplex
          ENET Speed is 10 Mbps - HALF duplex connection
          ARP broadcast 1
          TFTP from server 107.108.204.207; our IP address is
          107.108.204.104
          Filename 'vmlinux'.
          Load address: 0x1000000
          Loading:
          #################################################################

          #################################################################
              ###########################
          done
          Bytes transferred = 802132 (c3d54 hex)

(j)   run the command bootm 1000000, It printed the following
          => bootm 1000000
           ## Booting image at 01000000 ...
          Image Name:   kernel_image
          Created:      2003-03-03  13:39:09 UTC
          Image Type:   PowerPC Linux Kernel Image (uncompressed)
          Data Size:    802068 Bytes = 783 kB = 0 MB
          Load Address: 00000000
          Entry Point:  00000000
          Verifying Checksum ... OK
          Loading Kernel Image ... OK

(k)   After this, the PPC target system hangs forever.


Any ideas or suggestions?

Thanks in advance.
Alex j


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
