Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3BCD9FA4.57626142@comdev.cc>
Date: Wed, 17 Oct 2001 08:11:32 -0700
From: Adam Wozniak <adam.wozniak@comdev.cc>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 8260 FCC ethernet timeout
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I occassionally and randomly get ethernet transmit timeouts.
I'm using an 8260, with ethernet on FCC 3, kernel 2.4.4.
I added code to print the fccp and intctl registers when
this happens, but I still don't see the problem:


NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
fccp============================
fccp->fcc_gfmr          2000003C
fccp->fcc_fpsmr         14200080
fccp->fcc_ftodr             1420
fccp->fcc_fdsr              D555
fccp->fcc_fcce              0000
fccp->fcc_fccm              001A
fccp->fcc_fccs                00
fccp->fcc_ftirr_phy[0]        00
fccp->fcc_ftirr_phy[1]        00
fccp->fcc_ftirr_phy[2]        00
fccp->fcc_ftirr_phy[3]        00
================================
intctl=====================
intctl->ic_sicr        0000
intctl->ic_sivec   00000000
intctl->ic_sipnrh  00000000
intctl->ic_sipnrl  00000000
intctl->ic_siprr   05309770
intctl->ic_scprrh  05309770
intctl->ic_scprrl  05309770
intctl->ic_simrh   00000000
intctl->ic_simrl   20001801
intctl->ic_siexr   00000000
===========================

 Ring data dump: cur_tx c0163318 (full) cur_rx c0163208.
 Tx @base c0163308 :
1c00 0042 03d44cbe
1c00 05ea 0311985e
3c00 007c 0335a85e
1c00 0067 0311905e
1c00 0055 0335a05e
1c00 0052 0335a85e
1c00 0042 03d44ebe
1c00 006b 0300885e
bc00 0042 03d44dbe
1c00 004e 033b585e
1c00 0043 033b585e
1c00 0043 033b585e
1c00 0043 033b585e
1c00 0043 033b585e
1c00 0043 033b585e
3c00 0043 033b585e
 Rx @base c0163208 :
9c00 015a 03d43000
9c00 005c 03d43800
9c00 015a 03d42000
9c00 015d 03d42800
9c00 015a 03d41000
9c00 015a 03d41800
9c00 015a 03d40000
9c00 015a 03d40800
9c00 010b 03d3f000
9c00 015a 03d3f800
9c00 015d 03d3e000
9c00 015a 03d3e800
9c00 015a 03d3d000
9c00 015a 03d3d800
9c00 015a 03d3c000
9c00 015a 03d3c800
9c00 015d 03d3b000
9c00 015a 03d3b800
9c00 015a 03d3a000
9c00 015a 03d3a800
9c00 015a 03d39000
9c00 015a 03d39800
9c00 015d 03d38000
9c00 015a 03d38800
9c00 015a 03d37000
9c00 015a 03d37800
9c00 015a 03d36000
9c00 01f5 03d36800
9c00 01f2 03d35000
9c00 015a 03d35800
9c00 015d 03d34000
bc00 015a 03d34800

--
Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
