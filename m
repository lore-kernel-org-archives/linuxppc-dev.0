Date: Thu, 7 Feb 2002 14:43:08 -0700
From: Val Henson <val@nmt.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020207144308.C19569@boardwalk>
References: <20020205115618.D6834@boardwalk> <20020205193316.19866@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020205193316.19866@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Tue, Feb 05, 2002 at 08:33:16PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 05, 2002 at 08:33:16PM +0100, Benjamin Herrenschmidt wrote:
>
> And let me know if you find something ;)

I pulled the latest linuxppc_2_4_devel, ported gemini to it, and ran
an overnight test with:

NFS mounted root filesystem
while (true) do make clean; make -j8 zImage; done
crashme +2000 666 100 8:00:00 2
Flood ping in and out

On a dual 7410 Gemini with 1 GB RAM.  Used all but 70MB of memory.  No
hangs.

The weird thing is that crashme was supposed to run for 8 hours but
it's been running for over 14 hours now.  Any ideas?

Also, I don't think this was a particularly good test of highmem since
I don't think many bounce buffers were used, or that the kernel had
much reason to map/unmap many highmem pages.  Unfortunately, my SCSI
controller isn't working quite right and I can't test with a hard disk
as a result.  Any ideas for stressing the system harder?

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
