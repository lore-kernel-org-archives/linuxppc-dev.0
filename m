Message-ID: <369F2600.4525430D@siemens.at>
Date: Fri, 15 Jan 1999 12:26:56 +0100
From: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: FADS823 - the neverending story
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm still struggling around to get my FADS823 board start any kind of
/bin/sh or /sbin/init, but without any success. Today I tried the
tarball Dan posted in the end of December (with only minor
modifications), but again - no success.

I tried using initrd (with Dan's root file system mbxroot.tar.gz) and
rootnfs, but none of these configurations started up an initial shell.

The kernel itself is idle and obviously reschedules process 1 again and
again, but this seems kind of stuck after executing SET_PAGE_DIR :-(

Since there is an increasing number of success stories for embedded 8xx
boards, I more and more suspect the FADS itself and my CPU MPC823 rev.0
causing my problems. Unfortunately I'm still waiting for my upgrade
CPU's from Motorola I ordered before Xmas.

Now I wonder which CPU revision Dan used in his successful port for the
823-based Bright Star Engineering ip-Engine board.

BTW, one of the major problems I had, is adapting the CPU's internal
register structure. Since the MPC823 only supports one SCC, but an
addition USB, Video, etc there is only a minimal subset (like SCC2,
SMC1, SMC2) that can be used within the immap_t structure, which is
definitely derived from MPC860. So why don't we use seperate typdefs
(e.g. immap860_t, immap823_t,..) and #define'ing them properly (#define
immap_t immap860_t)? Another question is, why can't we use mpc860.h,
mpc823.h by Motorola? Are there any copyright problems?

What I liked in Dan' tarball, is distinguishing the 8xx CPUs by
CONFIG_MPC860, CONFIG_MPC823, ... and the boards via CONFIG_MBX,
CONFIG_RPXLITE, ... I'll try to follow this for any specific changes I
make ;-)

-- Helmut

*********************************************************
* Helmut Buchsbaum               * Siemens AG Austria   *
* Tel:   ++43-1-1707-36686       * EZE PN 5             *
* Fax:   ++43-1-1707-55169       * Erdberger Laende 26  *
*                                * A-1030 Vienna/Europe *
*********************************************************
* mailto:Helmut.Buchsbaum@siemens.at                    *
*        buc@eze22.siemens.co.at                        *
*********************************************************

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
