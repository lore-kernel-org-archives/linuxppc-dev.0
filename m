Date: Tue, 13 Jun 2000 13:13:26 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX hang (tlbia)
In-Reply-To: <Pine.LNX.4.21.0006090548410.18644-100000@gemini.home.net>
Message-ID: <Pine.LNX.4.21.0006131300470.24794-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 9 Jun 2000, Jamie Guinan wrote:
>
> Hi,
>
> I've been playing with the mpc8xx-2.2.13.tgz kernel on a MBX/821
> board.
>
> ... I've been trying to get the board to boot
> without help from EPPCBug.  I borrowed some init code from eCos...
> ... but it hangs in arch/ppc/kernel/head.S at
>
> 	tlbia			/* Invalidate all TLB entries */

Just for future reference in the list archives, I got my bootloader
to work.  It turns out that eCos uses the MMU to map cacheable and
non-cacheable regions.  They have a function hal_map_memory()
which seems roughly analogous to ioremap().  Anyway, by simply
commenting out the parts of their 8xx init stuff which sets up
the MMU and TLBs, I can boot Linux and the tlbia falls through
without a hitch, and I get my shell prompt a few seconds later.
Joy...

-Jamie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
