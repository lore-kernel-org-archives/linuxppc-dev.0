Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 14F14DE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 11:15:13 +1100 (EST)
Date: Thu, 10 Jan 2008 18:24:50 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2] [ALSA] Add ASoC drivers for the
	Freescale MPC8610 SoC
Message-ID: <20080111002450.GA13291@lixom.net>
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
	<4786A650.2080107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4786A650.2080107@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2008 at 05:12:16PM -0600, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > Does the driver access the DMA and GUTS registers directly?  If so,
> > what do you have to protect against race conditions of other drivers
> > accessing them also.
> 
> I don't have any more protection than any other driver that accesses SOC 
> registers directly.  Last I heard, Zhang's DMA driver was in limbo, and that 
> driver would be the best place to arbitrate DMA register access.  I was planning 
> on adding arbitration support to that driver after both drivers were applied.

Having been in a similar situation myself (needing to share resources
between DMA, ethernet and function offload), I recommend creating a
separate small library that all those drivers use, instead of making
some sort of dependency between drivers in completely different parts
of the kernel.


-Olof
