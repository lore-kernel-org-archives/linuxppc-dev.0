Message-ID: <036601c47acb$e9e0cc70$30c8a8c0@zorans>
From: "Zoran Stojsavljevic" <zoransto@dkts.co.yu>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>,
	<linux-atm-general@lists.sourceforge.net>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <1075117282.1504.17.camel@zambia.cambridgebroadband.com>
Subject: MPHY supported in mpc8260sar
Date: Thu, 5 Aug 2004 11:09:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello to all,

I finally achieved multiphy mpc8260sar (with some limitations).
The driver is able to support 8 PHYs (one PHY per unique priority).
The driver is developed out of Peter's McCormick single PHY version.

For some unknow reason I could NOT achieve MPHY support with
only one priority (for example highest PRIority 0). In order to make
MPHY to work correctly I assigned a unique priority per PHY. With
8 PHYs the mapping looks like: PHY0/PRIO0, PHY1/PRIO1...
PHY7/PRIO7, eg. PHYx/PRIOx, where x is in range [0..7]!

The another limitation is that I did NOT fix the VP range, eg. I am using
only VP0 (one VP) with different VCs, where least three (3) significant
bits of each VC assume the selected PHY. In other words, I am using
8 nas interfaces, and VCs (decimal radix) from 40 (0x28) to 47 (0x2F),
where VC 40 is attached to PHY0, VC 41 to PHY1... VC47 to PHY7.
While issuing ATM xmit command I am deriving least three significant
bits of currently processed VC and I'm putting them to the
COMM_INFO words (offset 0x86, field PHY#), described in section
30.14 of MPC8260 PowerQUICC II Family Reference Manual
(Revision 1, date 05/2003).

If you all find this info of (some) interest, I can do the patch (against
latest
version in CVS) so we can store this limited edition of the MPHY version
under the mpc8260sar driver project.

Best Regards,
Zoran Stojsavljevic
DKTS Pupin Telecom
zoransto@dkts.co.yu

----- Original Message -----
From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Sent: Monday, January 26, 2004 1:41 PM
Subject: Announcement: MPHY now supported in mpc860sar

> Just a quick note to say that multi-phy is now supported by the
> mpc860sar ATM driver, thanks to a patch by Rodolfo Giometti.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
