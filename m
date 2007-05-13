Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC] cell: saving spus information for kexec crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20070511172233.GA14587@kryten>
References: <200705111353.22781.adetsch@br.ibm.com>
	<20070511172233.GA14587@kryten>
Content-Type: text/plain
Date: Mon, 14 May 2007 08:14:01 +1000
Message-Id: <1179094441.32247.68.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andre Detsch <adetsch@br.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-11 at 12:22 -0500, Anton Blanchard wrote:
> Hi,
> 
> > This patch adds support for investigating spus information after a
> > kernel crash event, through kdump vmcore file.
> > Implementation is based on xmon code, but the new functionality was
> > kept independent.
> 
> This brings up a point: it looks like kdump doesnt capture the FP and
> altivec regs. Could be important for some bugs.
> 
> This brings up yet another point, it looks like our userspace core dumps
> dont capture altivec or SPU state.

That's interesting: We do have a dump_task_altivec() but it looks like
its never called ... ouch. Maybe we can use the XFPREGS stuff or should
we add our own hook in binfmt_elf.c for that ?

As for SPU state, there's code to dump the SPEs in a separate section,
though I don't know if it's been merged yet (no up to date git tree
at hand right now). It uses different macros off binfmt_elf.

Ben.
