Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <00eecfdbd5bccc7b293d847033121eee@freescale.com>
References: <1132032910.23979.6.camel@gaston>
	<00eecfdbd5bccc7b293d847033121eee@freescale.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 13:34:49 +1100
Message-Id: <1132108490.5646.67.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-11-15 at 20:19 -0600, Becky Bruce wrote:
> Ben,
> 
> Yeah,  I clearly shouldn't run testcases at 11pm, because I got in a 
> rush and only confirmed that lmw/stmw were actually taking the 
> exception.  Those 2 are working beautifully.  To test the others, I 
> need to run on a different board which, of course,  isn't bootable at 
> the moment.  As soon as I can get that up and running, I'll try some of 
> the other cases and let you know how it goes......
> 
> BTW, Based on the pile of docs I have here, I think the list of 
> alignment-exception-causing events on FSL's current parts (603, 603e, 
> 750, 74x, 74xx, e500) is:
> 
> - lmw/stmw (all procs, non-word aligned)
> - single and double precision floating point ld/st ops (non-E500, non 
> data size aligned)
> - dcbz to WT or CI memory (all procs)
> - dcbz with cache disabled (all procs but 603e?)
> - misaligned little endian accesses (603e)
> - lwarx/stwcx (all procs)
> - multiple/string with LE set (750, 603e, 7450, 7400)
> - eciwx/ecowx (750, 7450, 7400)
> - a couple of others related to vector processing
> 
> If anybody knows offhand of something missing there, let me know.

What about lwz/stw cropssing page boundaries ? Is this handled in HW ?

Ben.
