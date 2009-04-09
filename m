Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 388BDDE125
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 00:34:16 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n39EOKNk016600
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Apr 2009 10:24:20 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n39EYDA64763776
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Apr 2009 10:34:13 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n39EY9QY028664
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Apr 2009 08:34:09 -0600
Date: Thu, 9 Apr 2009 10:33:19 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
Message-ID: <20090409143319.GG18304@zod.rchland.ibm.com>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
	<20090409124634.GF18304@zod.rchland.ibm.com>
	<c8485d470904090706t4fd2893tdeaf3710b19bd0f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8485d470904090706t4fd2893tdeaf3710b19bd0f1@mail.gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	Suneel <"[mailto:suneel.garapati@xilinx.com]"@xilinx.com>,
	akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 09, 2009 at 04:06:56PM +0200, Roderick Colenbrander wrote:
>On Thu, Apr 9, 2009 at 2:46 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com>wrote:
>> > #define NUM_REGS      2
>> > #define REG_FB_ADDR   0
>> >@@ -112,6 +123,11 @@ struct xilinxfb_drvdata {
>> >
>> >       struct fb_info  info;           /* FB driver info record */
>> >
>> >+      u32             regs_phys;      /* phys. address of the control
>> >+                                              registers */
>>
>> Is this driver usable on the 440 based Xilinx devices?  If so, is it
>> possible
>> to have the physical address of the registers above 4GiB, so is common with
>> almost all the I/O on the other 440 boards?
>>
>>
>The driver works fine on 440 based Xilinx boards (the ML510 I use has a 440
>core). It might be nice to move physical addresses above 4GB for devices but
>in all Xilinx tools and reference designs addresses below 4GB are used for
>periperhals and I think even below 2GB (or even below 1GB). It depends on
>the design.

Right.  The "depends on the design" part is what I'm worried about.  Perhaps
using resource_size_t here is more appropriate, given that designs can change
and put the regs above 4GiB.  That way you can set the Kconfig option
appropriately for both cases.

josh
