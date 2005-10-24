Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C0E0968618
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Oct 2005 01:27:43 +1000 (EST)
In-Reply-To: <1130081898$57509$59788830@info@moreframe.com>
References: <1130081898$57509$59788830@info@moreframe.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D85EC946-F790-457F-8892-500410AB5B58@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Mon, 24 Oct 2005 10:27:18 -0500
To: info <info@moreframe.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Help needed Linux-2.6 - MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 23, 2005, at 10:39, info wrote:

> Junita
>
> Sorry to disturbed you. I find your question in the http:// 
> ozlabs.org mail list.
> Have you fixed the bug in gianfar_phy.c?
> tempval = gfar_read(&priv-> regs-> dmactrl);
> tempval |= (DMACTRL_GRS | DMACTRL_GTS);
> gfar_write(&priv-> regs-> dmactrl, tempval);
>
> while (!(gfar_read(&priv-> regs-> ievent) & (IEVENT_GRSC |  
> IEVENT_GTSC)))
> cpu_relax();
>
> /* Reset MAC layer */
> gfar_write(&priv-> regs-> maccfg1, MACCFG1_SOFT_RESET);


I'm a bit confused by the statement above.  The code you present is  
from gianfar.c, and is certainly not a bug.  It is possible you are  
using an older version of the code, which has a bug, which is fixed  
by adding these lines above the code you show:

         tempval = gfar_read(&priv->regs->dmactrl);
         tempval &= ~(DMACTRL_GRS | DMACTRL_GTS);
         gfar_write(&priv->regs->dmactrl, tempval);

This fixes a problem where setting GRS and GTS when they're already  
set doesn't initiate the graceful stop.  But if you are using 2.6.13,  
you should have this fix.  I suspect that, like I told Junita, you  
need to make sure the platform code has the right CCSRBAR value set up.

>
> I buy a RMC-G8500 card from GDAtech, I try to build linux-2.6.13.4  
> from kernel.org and meet the same problems as you had. I test the  
> same code on freescale 8540_ADS board, it is good.Can you share  
> some infomation of your progress?


I'm not familiar with this card.  Are you sure there's support for it  
in your source tree?


Andy Fleming
