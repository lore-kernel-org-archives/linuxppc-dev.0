Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BFF65DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 00:52:54 +1100 (EST)
Date: Wed, 14 Feb 2007 16:53:30 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: Moving from arch/ppc to arch/powerpc with an MPC8248 (part 1)
Message-ID: <20070214165330.5312de55@vitb.dev.rtsoft.ru>
In-Reply-To: <200702141443.18865.laurent.pinchart@technotrade.biz>
References: <200702141308.17815.laurent.pinchart@technotrade.biz>
	<20070214161037.16260438@vitb.dev.rtsoft.ru>
	<200702141443.18865.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 14 Feb 2007 14:43:18 +0100
Laurent Pinchart <laurent.pinchart@technotrade.biz> wrote:

> Hi,
> 
> > > I'm trying to take the big jump and move my (mostly) stable board support
> > > from arch/ppc to arch/powerpc. I'm still at a very early stage, but here
> > > are already a few questions.
> > >
> > > arch/ppc defines some 8260 generic handlers in syslib/mpc8260_setup.c for
> > > operations such as halt, reset, show_cpuinfo, ... The MPC82xx ADS in
> > > arch/powerpc/platforms/82xx redefines those handles as board-specific
> > > functions. Should they be made generic to all 82xx boards, or should I
> > > copy them to my board-specific file ? If the code should be shared by all
> > > 82xx boards, I'll probably end up copying most of the
> > > arch/ppc/syslib/mpc8260_setup.c code to
> > > arch/powerpc/platforms/82xx/mpc82xx.c.
> >
> > I'd just copy stuff to the BSP -- let's consider the common/uncommon stuff
> > later when we'll have to add something else.
> >
> > It's hard to envision what level of code should be common and what should
> > be board-specific as of now. Otherwise, we'll have to painfully revisit
> > issue later.
> 
> It seems there are still lots of inconsistencies regarding MPC82xx support in 
> arch/powerpc. For instance, get_immrbase() is used to get the IMMR address 
> from the OF device tree, but cpm2_map() uses the CPM_MAP_ADDR address which 
> is platform-dependant, and hardcoded to 0xf0000000 in 
> platforms/82xx/pq2ads.h.
> 
Are you using up-to-date powerpc.git? I get rid of hardcoded CPM_MAP_ADDR
completely (or it should be such, heh). please make sure you have my recent commits in.

> Is someone working on fixing MPC82xx support for arch/powerpc ? I don't have 
> much time now to hack all the platform-specific code and cleanup 
> inconsistencies, so if someone is working on it I'll wait for patches. If 
> not, I'll have to work on that later, as time permits. As I'm new to the 
> arch/powerpc code, I'd appreciate if someone with a good understanding of 
> what should be done could give me a few pointers (such as 'fix the CPM2 
> mapping code this way', just general guidelines). Otherwise I'll have to ask 
> questions at every line of code.
> 

Well 827x works perfectly for me, and there are no direct immr dereferences anymore in arch/powerpc...
There still might be gotchas because that merge was sort of one-man-show, but let me know and we'll figure out something.


-- 
Sincerely, 
Vitaly
