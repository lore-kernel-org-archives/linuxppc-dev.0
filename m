From: Alan Mimms <alan@packetengines.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: WARNING OFF TOPIC SLIGHTLY: 8xx MMU w/8MB pages
Date: Mon, 17 Jan 2000 14:59:35 -0800
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00011715164502.03037@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

If you are only interested in Linux on 8xx PPC, please ignore this message.  I
am having a problem building up MMU tables for 8MB pages on a NON-Linux system
running on an 850.  I hope someone on this list can help (PLEASE!).

The system works fine but is "slow".  I look into this and find that my DTLB
miss exception handler is running a LOT (50k exceptions/sec!).  Seems the TLB
is never matching.  I have the MMU set up for all mappings to be 8MB pages to
map 32MB of RAM and a few I/O devices.  There are slightly more than 8 PTEs
that are in use in the system so I can't statically load up the TLB and get on
with life - I have to handle the DTLB misses.  But I don't use the 8xx
documentation's specified page table structure since I have a very flat
logical==physical mapping.  I'm simply using the MMU to flag cacheable vs
noncacheable spaces, really.

The MD_CTR is set to 0.  I don't have TWAM or PPCS on.  This is a wide-open no
protection kind of system, so I can get away with very little actual MMU bells
and whistles.

I tried using the MD_CAM and MD_RAMn registers to debug this.  These seem to
read back the values I have stored via the MD_RPN, MD_TWC and MD_RPN register
EXCEPT that when I read back I get a value for the MD_CAM.PS field of 110
rather than the 111 which is the documented 8MB page size value.  The doc even
says that values other than those listed (000, 001, 011, 111) are "reserved". 
The value I am setting in the MD_TWC.PS field (which is oddly a two bit
encoding for page size) is 11, which is documented as the 8MB page size value.

The TLB entries are all being written with ASID of zero, which is the value in
CASID so these can't be the reason for the mismatch.

Here's a sample of what I am doing:

M$reg md_ctr=700
!!! look at TLB entry #7

M$reg md_epn=00200 md_twc=0d md_rpn=009f5
!!! write entry with
!!!  MD_EPN: EPN=0 EV=1 ASID=0
!!!  MD_TWC: APG=0 G=0 PS=11 (8MB) V=1
!!!  MD_RPN: RPN=0 PP={supvR/W, PowerPC, Change, all subpages valid},
!!!          SPS=0 (wrong?) SH=1 CI=0 V=1

M$reg md_ctr=700
!!! Reset to look at TLB entry #7

$cam
  reg md_ctr=00000700
  reg md_dbcam=00000fd0
  reg md_dbram0=00000de0
  reg md_dbram1=00007fff

!!! This shows I am looking at entry #7,
!!! and the MD_CAM: EPN=0 SPVF=1111 PS=110 (!) SH=1 ASID=0
!!! (MD_CAM is called MD_DBCAM for some reason on the HP debugging box I use).

Note that the above MD_CAM shows a PS of 110 which is RESERVED according to the
MPC850 documentation.

What am I doing wrong?  Is there more info one would need to be able to answer
this question?

PLEASE HELP.

Thanks very much.
a
 -- 
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
