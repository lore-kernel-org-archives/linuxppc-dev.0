Date: Fri, 6 Dec 2002 08:59:09 -0700
From: Matt Porter <porter@cox.net>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
Message-ID: <20021206085909.B17918@home.com>
References: <3DF0A4D9.4030603@intracom.gr> <IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLCEJFFIAA.joakim.tjernlund@lumentis.se>; from joakim.tjernlund@lumentis.se on Fri, Dec 06, 2002 at 03:25:48PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 06, 2002 at 03:25:48PM +0100, Joakim Tjernlund wrote:
> If you implement the performance improvement I suggested earlier, I don't think
> you need them. Another thing with consistent_xxx() is that you can not use
> __pa() and __va() on addresses returned by the consistent_alloc et. al.

Um, well if you are doing a consistent_alloc() then surely you are
keeping the dma_handle around which is your physical address.  If you
want the kernel virtual address then you can apply __va to that.  So,
you have the cache inhibited mapping in vmalloc space returned to you,
the physical address provided in dma_handle, and a kernel virtual address
that can be trivially generated.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
