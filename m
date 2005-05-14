Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 9B6C667B15
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 11:45:23 +1000 (EST)
Date: Fri, 13 May 2005 18:44:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Message-ID: <20050513184458.B15958@cox.net>
References: <3086.1116027422@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3086.1116027422@marajade.sandelman.ottawa.on.ca>;
	from mcr@sandelman.ottawa.on.ca on Fri, May 13, 2005 at
	07:37:02PM -0400
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: problems with ppc405 on 2.6.11.8.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 13, 2005 at 07:37:02PM -0400, Michael Richardson wrote:
> A customer of mine has a PPC405 system, which was based upon the
> Embedded Planet design. It runs U-boot 0.4.0, and the system currently
> ships with a kernel based upon Timesys 2.4.18. 
> 
> We are in the process of upgrading to 2.6.11. (linus, not timesys. We
> see no value add from timesys)
> 
> The major stumbling block was using boot/simple/{head,relocate}.S,
> and the inftrees.c. For reasons we do not understand, the system would
> fail in huft_build() when (setting up for) decompressing.  We traced
> through this using our bdi2000, after failing with puts() additions. 

If you are booting off of U-boot, why are you trying to boot a
zImage?  You should be booting a uImage which doesn't use the
bootwrapper glue code in arch/ppc/boot/. Load the right image 
and you will avoid all of this.

-Matt
