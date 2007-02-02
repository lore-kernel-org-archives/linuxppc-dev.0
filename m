Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 25934DDF29
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Feb 2007 05:39:40 +1100 (EST)
Date: Fri, 2 Feb 2007 12:46:45 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [5/9] pasemi: Implement restart
Message-ID: <20070202184644.GA30912@lixom.net>
References: <20070202045448.145851000@lixom.net>>
	<20070202045508.643066000@lixom.net>>
	<9C45758A-F748-43B2-97F6-E27FE0AC0530@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9C45758A-F748-43B2-97F6-E27FE0AC0530@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2007 at 12:07:42AM -0600, Kumar Gala wrote:
> >-	pas_power_off();
> >+	void __iomem *sdcreg;
> >+	printk("Restarting...\n");
> >+	/* XXXOJN This should maybe come out of the device tree */
> >+	sdcreg = ioremap(0xfc101100, 4);
> 
> You can't do the ioremap here,  restart may get call an oops from  
> interrupt context.

Oh, that's right. Will do it in setup instead.


Thanks,

-Olof
