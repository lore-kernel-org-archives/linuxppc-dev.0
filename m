Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 57FDFDDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 02:53:46 +1000 (EST)
Message-ID: <48AC4B86.8010902@ru.mvista.com>
Date: Wed, 20 Aug 2008 20:51:18 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/9] Rework PowerPC 44x board support
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> The following patch series reworks the board support code for PowerPC 44x
> platforms.  It eliminates a number of redundant <board>.c files and add a
> ppc44x_simple.c file that has an explicit list of boards that are supported
> by it.  This is the same mechanism that Grant Likely has used for MPC 5200
> boards.
> 
> It also adds some more explicit support for Glacier and Yosemite boards, as
> those boards were using a board level compatible property in their DTS files
> that was a bit confusing.
> 
> Review would be appreciated.  Tested on Sequoia, and I plan on testing on as
> many boards as I can before committing to my tree.
> 
> josh

Sorry if I miss anything, but
what happens if I build an uImage just for Rainier (not enabling other 
platforms in the kernel config) and then start it on Canyonlands for 
example?
They both use PowerPC_44x_simple stuff and looks like now we claim that 
all these "simple" boards are compatible. So, board check always passes, 
although Canyonlands support is actually disabled (CONFIG_460EX = n; 
CONFIG_PPC4xx_PCI_EXPRESS = n). It's not critical, but I just thought we 
might also remove the platform-specific options from 
arch/powerpc/platforms/44x/Kconfig for these boards at all. Just enable 
all board-specific stuff under "config PPC44x_SIMPLE".
Otherwise we probably should have a configurable char *board[] array.

Thanks,
Valentine.
