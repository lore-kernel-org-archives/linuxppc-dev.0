From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Highmem on PPC?
Date: Thu, 7 Feb 2002 22:51:05 +0100
Message-Id: <20020207215105.3897@smtp.wanadoo.fr>
In-Reply-To: <20020207144308.C19569@boardwalk>
References: <20020207144308.C19569@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I pulled the latest linuxppc_2_4_devel, ported gemini to it, and ran
>an overnight test with:
>
>NFS mounted root filesystem
>while (true) do make clean; make -j8 zImage; done
>crashme +2000 666 100 8:00:00 2
>Flood ping in and out
>
>On a dual 7410 Gemini with 1 GB RAM.  Used all but 70MB of memory.  No
>hangs.
>
>The weird thing is that crashme was supposed to run for 8 hours but
>it's been running for over 14 hours now.  Any ideas?
>
>Also, I don't think this was a particularly good test of highmem since
>I don't think many bounce buffers were used, or that the kernel had
>much reason to map/unmap many highmem pages.  Unfortunately, my SCSI
>controller isn't working quite right and I can't test with a hard disk
>as a result.  Any ideas for stressing the system harder?

Well, I don't know what your previous kernel had, but recent _devel
has my fix to limit lowmem to what can be mapped by BATs on SMP.
That may help with the 7410. If the machine ends up beeing really
stable, then I'll have to look into CPU bugs for my 7450 problems.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
