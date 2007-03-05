Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [PATCH 14/22] spufs: use SPU master control
	=?iso-8859-15?q?to=09prevent_wild=09SPU?= execution
Date: Mon, 5 Mar 2007 02:02:59 +0100
References: <20061120174454.067872000@arndb.de>
	<200703011450.50935.arnd@arndb.de>
	<1172830438.16533.6.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1172830438.16533.6.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200703050202.59596.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 02 March 2007, Michael Ellerman wrote:
> There's also the error case for spu_run_init() which skips the master
> stop. I guess that's ok because we've only set the master control in the
> backing store, and the only way that will ever get propagated to an
> actual spu is by coming back thorough spufs_run_spu().

Hmm, the correct way would be to switch off the master control in there,
afaics. Fixing it only in spu_run_init would mean that we also handle
the case of spu_reacquire_runnable along with it.

> What originally caught my eye on this was the output from xmon. When we
> drop into xmon with no spu programs running and stop the spus, it
> reports that they _all_ have the master run enabled,

That looks right, there is no problem to have master control enabled,
as long as user space can't access the spu through a context that is
bound to it.

> and some of them 
> have the runcntl enabled (those that have had spu programs run on them
> since boot it seems).

While this sounds wrong. Maybe the runcntl is active on those that have
_not_ run since boot, which would make more sense. We should investigate
this.

> It looks like the save/restore code sets the master bit in several
> places, but never sets/clears the runcntl, which seems bogus to me.
> 
> So when we leave spufs_spu_run we do the master stop call:
> 
> spu_mfc_sr1_set: spu: c00000007ffdfc80 (15) sr1: 0x1b runcntl: 0x1
> Call Trace:
> [C00000000196BAA0] [C00000000000F920] .show_stack+0x68/0x1b0 (unreliable)
> [C00000000196BB40] [D0000000001475C0] .spu_hw_master_stop+0xa8/0x170 [spufs]
> [C00000000196BBE0] [D000000000148598] .spufs_run_spu+0x5ec/0x770 [spufs]
> [C00000000196BCC0] [D000000000144BA0] .do_spu_run+0xb4/0x180 [spufs]
> [C00000000196BD80] [C00000000003905C] .sys_spu_run+0xb0/0x108
> [C00000000196BE30] [C000000000008634] syscall_exit+0x0/0x40
> 
> 
> But then the save/restore code sets it back on?

Right, the context save code needs to enable master control in order to
run on the spu. However, that should be after all mappings to user space
have been discarded.

	Arnd <><
