Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by ozlabs.org (Postfix) with ESMTP id E65BFDDF1C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 02:41:57 +1100 (EST)
Date: Tue, 3 Feb 2009 16:25:02 +0100
From: Willy Tarreau <w@1wt.eu>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: 2.6.29-rc3-git5 build failure : drivers/staging/panel
Message-ID: <20090203152502.GC12398@1wt.eu>
References: <49885F9A.6040703@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49885F9A.6040703@in.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Feb 03, 2009 at 08:45:38PM +0530, Sachin P. Sant wrote:
> 2.6.29-rc3-git5 randconfig build on powerpc fails with following error
> 
> CALL    arch/powerpc/kernel/systbl_chk.sh
> CALL    arch/powerpc/kernel/prom_init_check.sh
> CC [M]  drivers/staging/panel/panel.o
> drivers/staging/panel/panel.c:625: error: conflicting types for set_bits
> /home/sachin/linux-2.6.29-rc3-git5/arch/powerpc/include/asm/bitops.h:216: 
> error: previous definition of set_bits was here
> make[3]: *** [drivers/staging/panel/panel.o] Error 1
> make[2]: *** [drivers/staging/panel] Error 2
> make[1]: *** [drivers/staging] Error 2
> make: *** [drivers] Error 2
> 
> Will provide .config if required.

I don't think any config will be needed. The problem is that we have
conflicting names between global and local functions. Could you please
try to rename "set_bits" as weel as the few references to this function
in panel.c ? I'd suggest you name it "panel_set_bits".

I can work on a patch if needed, but since the fix is really easy I'd
prefer to get a confirmation that it's enough.

Thanks for the report,
Willy
