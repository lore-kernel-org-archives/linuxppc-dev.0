Date: Thu, 20 Nov 2003 18:36:49 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440gx ethernet lockup
Message-ID: <20031121023649.GA5602@gate.ebshome.net>
References: <20031121015449.28462.qmail@web40911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031121015449.28462.qmail@web40911.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 20, 2003 at 05:54:49PM -0800, Brian Kuschak wrote:
>
> Is anyone actively working with ethernet on the 440GX?
>  I'm seeing TX lockups when stressing the 10/100 EMAC
> with heavy NFS traffic:
>
> find /nfs_mnt -type f |xargs grep blahblahblah
>
> This is the only way I can make it happen, but it does
> happen quickly.
>
> The 'get_next_packet' bit is set but never clears.
> The EMAC_ISR doesn't have any unusual errors (except
> for some deferrals).  The 'dead_bit' is _not_
> asserted.  The MAL channels are enabled, and so is the
> EMAC.  No TXDE interrupts have occurred.  The BD ring
> is filled with packets ready to send.  The same code
> on a 440GP works fine.  This version of the CPU (PVR
> 0x51b21851) is supposed to have all the EMAC-related
> errata fixed, but this smells like a silicon bug to
> me.

What kernel version? What board? Eval or your custom one?
If the custom one, did you try your test on eval?

How long does it usually take to get into lock up state?

I've just ran your "find" cmd for 10 minutes on our 440GX board
without any problems.

What clock mode are you using (533/152, 500/166 or smth else)?
Do you have L2C enabled? If yes, please check L2C0_SR for parity
errors (we have some problems with several our 440GX boards).

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
