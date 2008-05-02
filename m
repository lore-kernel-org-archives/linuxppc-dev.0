Return-Path: <benh@kernel.crashing.org>
Subject: Re: [POWERPC][v2] Bolt in SLB entry for kernel stack on secondary cpus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18458.55542.977597.204532@cargo.ozlabs.ibm.com>
References: <18458.39064.783013.268948@cargo.ozlabs.ibm.com>
	<20080502055648.GA28378@yookeroo.seuss>
	<18458.55542.977597.204532@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 03 May 2008 09:19:43 +1000
Message-Id: <1209770383.26383.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-02 at 19:03 +1000, Paul Mackerras wrote:
> David Gibson writes:
> 
> > Do you even need the processor ID test at all?  The boot processor
> > should always have its stack covered by SLB entry 0 when we come
> > through here, shouldn't it?
> 
> I was concerned that get_paca()->kstack wouldn't have been initialized
> by the time the boot cpu calls slb_initialize().  If that fear is
> unfounded then the check could go.

No, you are correct, it's not initialized. However, I find that a bit
weird, as we shouldn't have a problem initializing it in
start_here_multiplatform rather than start_here_common.

The whole stack setup part of these here seems like a dup to me.

Ben.
