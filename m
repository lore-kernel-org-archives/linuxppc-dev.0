In-Reply-To: <Pine.HPX.4.10.10001211317100.18916-100000@gra-ux1.iram.es>
Date: Fri, 21 Jan 2000 15:06:03 +0100
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Message-Id: <20000121150603.015148@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 21, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>- write,
>- eieio,
>- read,
>- isync to make sure that the read has reached the registers and is not in
>a load pending queue or whatever which can be quite deep especially if the
>processor does never need the result of the read...

Indeed. Some time ago, I fixed the pmac-pic mask/unmask routines this way:

 - setup new mask in cached_mask (variable)
 - write_mask(cached_mask)
 - do {
 -   sync();
 - } while (read_mask() != cached_mask)

Note that both read_mask and write_mask will do eieio.

I beleive the sync could be replaced by an isync, I'm just not 100% sure
of the SMP behaviour but the mask/unmask routines should be fully
synchronized anyway. (And they are called with EE off).

Without this fix, we occasionally had bogus interrupts coming from the
IDE and possibly other rare problems.

I added a smiliar fix to the openpic code in my recent kernels too.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
