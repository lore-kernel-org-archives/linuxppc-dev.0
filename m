Date: Tue, 15 Jul 2003 08:46:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Message-ID: <20030715154656.GQ1211@ip68-0-152-218.tc.ph.cox.net>
References: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 14, 2003 at 09:32:07PM -0700, Eugene Surovegin wrote:

> I think this is a known problem.

Yes, fortunatly.

> According to MV kernel, there are USB devices that use such buffers.
>
> After spending last weekend with RISCWatch :) I can say that SCSI subsystem
> is also guilty of this behavior (drivers/scsi/scsi_scan.c::scan_scsis,
> scsi_result0).

Owch.

> Unfortunately, I don't know how many similar places of code are still
> waiting to be found :(.
> To be safe I think it's better to modify consistent_sync to handle such
> "bad" buffers.
>
> If start and/or end of the buffer are not properly aligned I use "dcbf" to
> flush corresponding cache line(s) and then call invalidate_dcache_range.
>
> This change doesn't affect performance of consistent_sync noticeably (like
> in the variant I found in MV kernel, where invalidate_dcache_range was
> changed to flush_dcache_range if USB was enabled)

Good to know.

> I don't know whether we should "ifdef" this for CONFIG_4xx and I know this
> fix is ugly :)
> I'm not even sure that such hacks should be included in the kernel :)))
> (but I will definitely use it in my tree)
>
> Comments/suggestions are welcome!

Well, one thing that is worth noting is that the USB people knew this
was a problem, and it was / should have been fixed in the 2.5 cycle.
Similarly, SCSI was cleaned up a lot, so perhaps this has been fixed
there.  I think it's generally known that doing DMA off of the stack is
a bad idea, and should be fixed when found.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
