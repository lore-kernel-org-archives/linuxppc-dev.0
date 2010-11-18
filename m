Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CDDD2B7170
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 04:05:52 +1100 (EST)
Date: Thu, 18 Nov 2010 09:06:15 -0800 (PST)
Message-Id: <20101118.090615.71123752.davem@davemloft.net>
To: mlcreech@gmail.com
Subject: Re: Gianfar TCP checksumming broken in 2.6.35+
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTi=-ZAL-to4qZ0vA20L589fMQm89E9mH9WWOvX0c@mail.gmail.com>
References: <AANLkTi=-ZAL-to4qZ0vA20L589fMQm89E9mH9WWOvX0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew L. Creech" <mlcreech@gmail.com>
Date: Tue, 2 Nov 2010 18:29:08 -0400

> An upgrade from 2.6.34 to 2.6.35 caused networking to stop working on
> my MPC8313-based board.  It turned out that TCP checksums were
> invalid, so I dug through the .35 changelog to try and isolate the
> reason.  The change "tcp: Set CHECKSUM_UNNECESSARY in
> tcp_init_nondata_skb" seems to be the specific one that causes
> breakage - if I revert this one-liner, things work again:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2e8e18ef52e7dd1af0a3bd1f7d990a1d0b249586
> 
> However, I also noticed that one of my boards was broken while a newer
> prototype (which is very similar, hardware-wise) was not.  It turns
> out they're using 2 different revisions of silicon, so the broken
> board still has a 1.0 version microcontroller.
> 
> Therefore I'm guessing (just a hunch) that the root cause of the
> problem is MPC8313 errata eTSEC12:
> 
> ========
> eTSEC12: Tx IP and TCP/UDP Checksum Generation not supported for some Tx FCB
>          offsets
> Description:
> 	If the Tx FCB (Frame Control Block) 32-byte offset is 0x19, 0x1A, 0x1B,
> 	0x1C, 0x1D, 0x1E or 0x1F, IP and TCP/UDP header checksum generation do
> 	not function properly. The checksum value may be inserted in the wrong
> 	location or not inserted at all.
> 	IP and TCP/UDP header checksum generation is not supported in LINUX
> 	and other systems in which headers are prepended to pre-aligned packet
> 	data, or where the alignment of the Tx FCB cannot be controlled.
> 	This behavior applies to pseudo-header checksum insertion as well as
> 	checksum generation.
> Workaround:
> 	Align Tx FCB to a 16 or 32-byte boundary.
> 	If the alignment of TxFCB is not controllable, set TCTRL[TUCSEN]=0 and
> 	TCTRL[IPCSEN]=0 to disable IP and TCP/UDP header checksum generation.
> Fix plan:
> 	Fixed in Rev 2.0
> ========
> 
> This appears to have been working previously, but doesn't work any
> more.  I'm not familiar enough with Dave's checksum/sk_buff changes to
> figure out whether this errata is to blame, though, or how I should
> fix it if it is.  Presumably there's some alignment magic needed in
> the sk_buff or gfar_add_fcb() to make sure that the microcontroller is
> happy with the FCB offset?
> 
> Any tip on how I can solve this, or at least verify that this errata
> is at fault?  Thanks in advance

Can someone please follow up Matthew to get this bug resolved?  It has
been sitting around for a long time.

I suspect the gianfar driver, for these chip revisions, will need to
do a software checksum when the offset matches the criteria mentioned
in the errata above.
