Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A3BE567A3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 02:56:56 +1000 (EST)
Date: Tue, 25 Apr 2006 20:57:03 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH] fix cpm_uart driver for PQ1...
Message-ID: <20060425205703.00955494@vitb.ru.mvista.com>
In-Reply-To: <200604251155.50781.david.jander@protonic.nl>
References: <200604251155.50781.david.jander@protonic.nl>
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

David,

Sorry haven't noticed you submit once working on series.

> 
> Hi,
> 
> This patch fixes the following three problems:
> 
> 1. Memory mapping virtual<-->dma is broken in the case that 
> CONFIG_CONSISTENT_START > CPM_ADDR.

Due to broken address translation, I used Kenneth work as a base. I'd
appreciate if you take a look/comment (CPM_UART: Fixed odd address
translations). Mostly it did the same as your patch/Kenneth work (so I
think it will be fair enough to put your both signed-off lines in there
as well - just let me know you do not object).

> 
> 2. SCC uart sends a break sequence each time it is stopped with the 
> CPM_CR_STOP_TX command. That means that each time an application closes the 
> serial device, a break is transmitted.

Can you please rebase it with my series applied? I'll submit it as incremental to my series then.
I am maintaining this part, and trying to make it better :).

> 
> 3. Implemented default BRG routing for PQ1 (in the same sense as it is done 
> for PQ2).

All ioport things are board-specific and should reside in BSP code (I'm pretty sure nobody will object...) - the BSP patch has examples how to do that. Though the legacy behavior it retaining,
I claim it as "no longer supported " and encourage board port owners to do minor changes in board-specific code and have cpm_uart operate on platform-device basis.


> 
> Signed-off-by: David Jander
> 




-- 
Sincerely, 
Vitaly
