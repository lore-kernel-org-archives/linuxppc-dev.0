Date: Tue, 15 Aug 2000 09:51:45 +0200 (MEST)
From: "M.Stein" <matthias@gom.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: problems with ioremap
Message-ID: <Pine.LNX.4.10.10008150949280.2215-100000@bilbo.gom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello!

I'm responsible for the device driver, supporting the frame grabbers of
Imaging Technology Inc. under linux.

Till now only x86 platforms are tested, but we try to port also to ppc
platforms.

The driver compiles without warnings, but the real testing causes an error
with ioremap (I think).

I read from the PCI-config space (BADR0/1/2) the addresses of two register
(0/1) and one memory area (2):

Jun 30 11:23:06 kaos kernel: itifg[0I]: ICR Register Set at: 0x80080000.
Jun 30 11:23:06 kaos kernel: itifg[0I]: CR Register Set  at: 0x80800000.
Jun 30 11:23:06 kaos kernel: itifg[0I]: On Board Memory  at: 0x80400000.

The remapping of this areas with ioremap(_nocache) gives the following
result:

Jun 30 11:23:06 kaos kernel: itifg[0I]: Remapping (ICR) at: 0x80080000.
Jun 30 11:23:06 kaos kernel: itifg[0I]:             offset: 0x0.
Jun 30 11:23:06 kaos kernel: itifg[0I]:                   : [1 page(s)].
Jun 30 11:23:06 kaos kernel: itifg[0I]: Remapping (CR)  at: 0xcd060000.
Jun 30 11:23:06 kaos kernel: itifg[0I]:             offset: 0x0.
Jun 30 11:23:06 kaos kernel: itifg[0I]:                   : [1024
page(s)].
Jun 30 11:23:06 kaos kernel: itifg[0I]: Remapping (BM)  at: 0xcd461000.
Jun 30 11:23:06 kaos kernel: itifg[0I]:                   : [1024
page(s)].

Have anyone an idea, why the ICR value is the same after remapping. Can
this be an error (because any later register access failes)?

                                        Kind Regards

					M.Stein

Machine description:

Mac G4 400MHz / 128Mb RAM / 100MHz front side bus
3 x 64bit/33MHz (grabber is the only card plugged in)
kernel 2.2.14 (SuSe 6.4)

-------------------------------------------------------------------------------
GOM mbH                                                 Tel.: ++49 531/3804-330
Gesellschaft fuer optische Messtechnik                  Fax.: ++49 531/3804-333
Rebenring 33                                            Mail: M.Stein@gom.com
38106 Braunschweig GERMANY                              http://www.gom.com
-------------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
