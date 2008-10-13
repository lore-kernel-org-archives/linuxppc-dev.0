Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] powerpc/cell/oprofile: fix mutex locking for
	spu-oprofile
Date: Mon, 13 Oct 2008 16:53:28 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<18610.20951.764057.574721@cargo.ozlabs.ibm.com>
	<200808250955.57638.arnd@arndb.de>
In-Reply-To: <200808250955.57638.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810131653.29631.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 August 2008, Arnd Bergmann wrote:
> On Monday 25 August 2008, Paul Mackerras wrote:
> >=20
> > > Since rc4 is out now, I understand if you feel more comfortable with
> > > putting the patch into -next instead of -merge.
> >=20
> > Linus has been getting stricter about only putting in fixes for
> > regressions and serious bugs (see his recent email to Dave Airlie on
> > LKML for instance). =A0I assume that the corruption is just in the data
> > that is supplied to userspace and doesn't extend to any kernel data
> > structures.
>=20
> That's right, please queue it for -next then.

I just realized that this patch never made it into powerpc-next after
all, neither benh nor paulus version. Whoever is handling it today,
could you please pull

 master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge

to get this commit below. I have rebased it on top of the current
benh/powerpc/next branch.

Thanks,

	Arnd <><

=2D--

commit aa5810fa545515c9f383e3e649bd120bef9c7f29
Author: Carl Love <cel@us.ibm.com>
Date:   Fri Aug 8 15:38:36 2008 -0700

    powerpc/cell/oprofile: fix mutex locking for spu-oprofile

    The issue is the SPU code is not holding the kernel mutex lock while
    adding samples to the kernel buffer.

    This patch creates per SPU buffers to hold the data.  Data
    is added to the buffers from in interrupt context.  The data
    is periodically pushed to the kernel buffer via a new Oprofile
    function oprofile_put_buff(). The oprofile_put_buff() function
    is called via a work queue enabling the funtion to acquire the
    mutex lock.

    The existing user controls for adjusting the per CPU buffer
    size is used to control the size of the per SPU buffers.
    Similarly, overflows of the SPU buffers are reported by
    incrementing the per CPU buffer stats.  This eliminates the
    need to have architecture specific controls for the per SPU
    buffers which is not acceptable to the OProfile user tool
    maintainer.

    The export of the oprofile add_event_entry() is removed as it
    is no longer needed given this patch.

    Note, this patch has not addressed the issue of indexing arrays
    by the spu number.  This still needs to be fixed as the spu
    numbering is not guarenteed to be 0 to max_num_spus-1.

    Signed-off-by: Carl Love <carll@us.ibm.com>
    Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Acked-by: Robert Richter <robert.richter@amd.com>

 arch/powerpc/oprofile/cell/pr_util.h       |   13 +
 arch/powerpc/oprofile/cell/spu_profiler.c  |    4
 arch/powerpc/oprofile/cell/spu_task_sync.c |  236 ++++++++++++++++++++++++=
=2D--
 drivers/oprofile/buffer_sync.c             |   24 ++
 drivers/oprofile/cpu_buffer.c              |   15 +
 drivers/oprofile/event_buffer.c            |    2
 drivers/oprofile/event_buffer.h            |    7
 include/linux/oprofile.h                   |   16 +
 drivers/oprofile/cpu_buffer.c              |    4
 9 files changed, 284 insertions(+), 37 deletions(-)
