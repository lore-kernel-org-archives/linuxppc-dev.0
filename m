Date: Fri, 24 Jan 2003 16:34:46 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Making only part of memory DMA-able [CONFIG_DISCONTIGMEM?]
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5E0FB922-2FB1-11D7-9939-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to get my PrPMC800's running as NON-MONARCHS, but I have
problems with DMA memory. Since the system is a NON-MONARCH, it has to be
satisfied with whatever PCI-window is given to it by the PCI-monarch (which
is not a Linux system).

The simple solution to this is to tweak the 'zones_size' array passed to
'free_area_init' to only make as much memory DMA-able as is given by the
PCI-monarch, unfortunately this only works if the PCI-window is bigger than
'1<<(PAGE_SHIFT+MAX_ORDER-1)' (due to alignment requirements in 'page_alloc.
c'), and even then the DMA-able area will be less than optimal, since the
DMA adresses starts at low addresses, and thus are filled with kernel pages,
  which does not need to be DMA-able.

Is there anybody working on DISCONTIGOUS memory allocation for PowerPC's,
that could shed some light on what should be done? A lot of memory
management seems to be specialized for CONFIG_440, which further clutters
my vision...

Regards

Anders Blomdell

------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
