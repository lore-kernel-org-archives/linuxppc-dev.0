Return-Path: <mlcreech@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 5AB0BB70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Nov 2010 09:29:12 +1100 (EST)
Received: by wwj40 with SMTP id 40so7747936wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 02 Nov 2010 15:29:09 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 2 Nov 2010 18:29:08 -0400
Message-ID: <AANLkTi=-ZAL-to4qZ0vA20L589fMQm89E9mH9WWOvX0c@mail.gmail.com>
Subject: Gianfar TCP checksumming broken in 2.6.35+
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

An upgrade from 2.6.34 to 2.6.35 caused networking to stop working on
my MPC8313-based board.  It turned out that TCP checksums were
invalid, so I dug through the .35 changelog to try and isolate the
reason.  The change "tcp: Set CHECKSUM_UNNECESSARY in
tcp_init_nondata_skb" seems to be the specific one that causes
breakage - if I revert this one-liner, things work again:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2e8e18ef52e7dd1af0a3bd1f7d990a1d0b249586

However, I also noticed that one of my boards was broken while a newer
prototype (which is very similar, hardware-wise) was not.  It turns
out they're using 2 different revisions of silicon, so the broken
board still has a 1.0 version microcontroller.

Therefore I'm guessing (just a hunch) that the root cause of the
problem is MPC8313 errata eTSEC12:

========
eTSEC12: Tx IP and TCP/UDP Checksum Generation not supported for some Tx FCB
         offsets
Description:
	If the Tx FCB (Frame Control Block) 32-byte offset is 0x19, 0x1A, 0x1B,
	0x1C, 0x1D, 0x1E or 0x1F, IP and TCP/UDP header checksum generation do
	not function properly. The checksum value may be inserted in the wrong
	location or not inserted at all.
	IP and TCP/UDP header checksum generation is not supported in LINUX
	and other systems in which headers are prepended to pre-aligned packet
	data, or where the alignment of the Tx FCB cannot be controlled.
	This behavior applies to pseudo-header checksum insertion as well as
	checksum generation.
Workaround:
	Align Tx FCB to a 16 or 32-byte boundary.
	If the alignment of TxFCB is not controllable, set TCTRL[TUCSEN]=0 and
	TCTRL[IPCSEN]=0 to disable IP and TCP/UDP header checksum generation.
Fix plan:
	Fixed in Rev 2.0
========

This appears to have been working previously, but doesn't work any
more.  I'm not familiar enough with Dave's checksum/sk_buff changes to
figure out whether this errata is to blame, though, or how I should
fix it if it is.  Presumably there's some alignment magic needed in
the sk_buff or gfar_add_fcb() to make sure that the microcontroller is
happy with the FCB offset?

Any tip on how I can solve this, or at least verify that this errata
is at fault?  Thanks in advance

-- 
Matthew L. Creech
