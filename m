Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 676E067B64
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 04:51:45 +1000 (EST)
Date: Thu, 29 Jun 2006 22:51:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Message-ID: <20060629225131.43b9ed59@localhost.localdomain>
In-Reply-To: <8A7E4B7C-8744-47FF-90FA-9B68C5187CEE@freescale.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FE2@zch01exm40.ap.freescale.net>
	<8A7E4B7C-8744-47FF-90FA-9B68C5187CEE@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2006 13:03:23 -0500
Andy Fleming wrote:

[snip]
> >>> +	iounmap(bcsr_regs);
> >>> +
> >> And if we have a design, which do not contain real ethernet UCC  
> >> usage? Or UCC
> >> geth is disabled somehow explicitly? Stuff like that normally
> >> goes to the
> >> callback that is going to be triggered upon Etherbet init.
> > I will move it.
> 
> 
> Wait...no.  I don't understand Vitaly's objection.  If someone  
> creates a board with an 8360 that doesn't use the UCC ethernet, they  
> can create a separate board file.  This is the board-specific code,  
> and it is perfectly acceptable for it to reset the PHY like this.   
> What ethernet callback could be used?
> 

I am sort of against the unconditional trigger of the ethernet-specific stuff,
dependless if UCC eth is really wanted in specific configuration.

For stuff like that I'd make a function (to setup low-level stuff), and pass it 
via platform_info to the eth driver, so that really driver-specific things happen in driver context only.

Yes this is board specific file, and virtually everything needed for the board can take place here. 
But usually BCSR acts as a toggle for a several things, and IOW, I see it more correct to trigger those stuff from the respective drivers (using a callback passed through platform_info)

-Vitaly
