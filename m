Return-Path: <paulus@ozlabs.org>
Date: Fri, 4 Jun 2010 19:06:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100604090648.GC26154@brick.ozlabs.ibm.com>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
	<20100604065145.GA2408@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100604065145.GA2408@in.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 04, 2010 at 12:21:45PM +0530, K.Prasad wrote:

> Meanwhile I tested the per-cpu breakpoints with the new emulate_step
> patch (refer linuxppc-dev message-id:
> 20100602112903.GB30149@brick.ozlabs.ibm.com) and they continue to fail
> due to emulate_step() failure, in my case, on a "lwz r0,0(r28)"
> instruction.

Strange, what was in r28?  The emulator should handle that instruction.

> About the latest patchset, given that we chose to ignore extraneous
> interrupts for non-ptrace breakpoints, I thought that re-using
> current->thread.ptrace_bps as a flag would be efficient than introducing
> a new member in 'struct thread_struct' to do the same. I'm not sure if
> you foresee any issues with that.

I just wonder what provides exclusion between its use as a flag and
its use to hold a real ptrace breakpoint.  As far as I can see nothing
does.  If there is something, it's off in some other source file,
unless I'm missing something.  And in that case there should be a bit
fat comment explaining why it's safe.

> If so, I'd like to send a new patch (rather than a new version of the
> complete patchset) to fix it along with the dangling put_cpu() in
> arch_unregister_hw_breakpoint() (I forgot to remove parts of the code
> between versions XIX and XX).

OK.

Paul.
