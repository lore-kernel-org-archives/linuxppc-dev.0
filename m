To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] ethtool support to 8260 fcc ethernet driver (and other stuff)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-3130395040"
Date: Mon, 11 Nov 2002 14:55:35 +1100
Message-ID: <431.1036986935@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_-3130395040
Content-Type: text/plain; charset=us-ascii

This patch does the following:

1. adds support for a "/proc/bus/mii/fccN" file that displays the contents of
   all MII PHY registers

2. adds support for the generic MII interface available in drivers/net/mii.c

3. adds support for the ioctls used by the ethtool program

4. changes statistics recording so that FIFO Overrun errors are accumulated in
   rx_fifo_errors instead of rx_crc_errors and Late Collision errors are
   accumulated in rx_over_errors instead of rx_frame_errors - this means that
   all the possible errors from the 8260 fcc have their own counter

5. fixes comments such as /* CONFIG_FEC_... */ to be /* CONFIG_FCC_... */

6. fixes a bug in the DM9131 PHY support where the wrong value for link status
   was being seen because the bit in the status register is marked as "latch low"
   which means if it goes low (e.g. you pull out the TP cable), it will stay that
   way until the register is read - I simply always read the register twice now
   to ensure that the current link status is seen (not the latched status).
   Other PHY driver writers should beware of this.

7. fix a printk which had "fec: ..." to output "fccN: ..." instead

8. the fcc driver version is tagged as containing these changes by appending
   " (mjj)" after the version number (which is still 0.3). People will probably
   want to leave this one out, or else bump the version number to 0.4 instead.
   (I did this so I could tell which of our boards here had the fixes).

9. set and clear the LPB (local protect bit) bit in the FCC PSMR in tandem with
   setting and clearing the FDE (full duplex enable) bit - if LPB is not set, the
   receiver is blocked while transmitting - on my board this resulted in very low
   throughput on input to the board (e.g. ftp to the board and PUT a file).
   I found this fix in a message to the list, and it solved by problem, but the
   official 2_4_devel sources still doesn't have it. Sorry, I don't have the
   reference at hand - but a search on the list should pick it up pretty quick
   (so the right person gets credit for the fix).

The main advantage of this patch is that you can compile and use the "ethtool"
program on 8260 linuxppc. This allows you to control the fcc ethernet operating
mode (e.g. 10/100, half/full duplex, auto-negotiation or not). I should point
out that because of number 6 above, the need for ethtool for me went away so I
haven't tested these changes much, other than confirming that ethtool runs and
calls the ioctls properly - but someone might be interested in the code anyway.

Note that this requires a patch to drivers/net/Makefile so that mii.c is compiled
if CONFIG_FCC_GENERIC_MII is enabled - obviously this violates the rule that
non-ppc specific files shouldn't be touched, but it is essential to the patch.

Have fun. Cheers!
								Murrray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/



--==_Exmh_-3130395040
Content-Type: application/x-gzip ; name="6_fcc_ether_ethtool.gz"
Content-Description: 6_fcc_ether_ethtool.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="6_FCC_ET.GZ"

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

--==_Exmh_-3130395040--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
