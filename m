Date: Tue, 15 Dec 1998 15:48:20 -0600
From: Ted Whalen <tew@nwu.edu>
To: David Ray <daver@idiom.com>
Cc: linux-pmac@samba.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: Complete fix for PB 2400 16-bit video problem
Message-ID: <19981215154820.A2281@wish.psych.nwu.edu>
Reply-To: tew@nwu.edu
References: <v02140b08b299f56c55fd@[209.157.72.95]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v02140b08b299f56c55fd@[209.157.72.95]>; from David Ray on Sun, Dec 13, 1998 at 03:03:02PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Ray wrote:
> The new XF68_FBDev just released from the xfree86 site still fails in
> 16 bit mode. This is not a color balance problem, but something more
> serious. It looks like only half the screen is trying to be
> initialized while the bottom half still shows a "compressed" display
> of the console. After about a second, X fails and exits.

I had this problem too, and I realized that it was due to the
hard-coded video ram setting in chipsfb.c -- it assumes 468k of vram,
when in fact most machines have more.  To get around this, use the
following diff.

diff -r1.16 chipsfb.c
553c553
< 	p->fix.smem_len = 800 * 600;
---
> 	p->fix.smem_len = 1024 * 1024; /* 800 * 600 */

However, even with this fix -- which provides the 1mb of vram I so
richly deserve, the colors are screwy.

tew
-- 
             Is "Princess" your real name?
                Ted Whalen - tew@nwu.edu

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
