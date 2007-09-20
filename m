Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F960DDFEB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:13:45 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8KIDgjC017764
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 14:13:42 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KIDeZw143252
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:13:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KIDeiX022485
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 12:13:40 -0600
Date: Thu, 20 Sep 2007 13:13:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: add setup_cpu for 44x for processor-specific init
Message-ID: <20070920131336.58df01e7@weaponx.rchland.ibm.com>
In-Reply-To: <20070920175558.GA3191@ru.mvista.com>
References: <200709201732.l8KHWuGA035995@sullivan.realtime.net>
	<20070920175558.GA3191@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Sep 2007 21:55:58 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> This adds cpu_setup functionality to PowerPC 44x platform.
> The cpu_setup callback is invoked by head_32 code and 
> the identify_cpu() function at early init and is used to 
> initialize FPU on 440EP(x) processors. The FPU initialization 
> was previously done in head_44x.S. Also a workaround for 
> the incorrect write to DDR SDRAM 440EPx/440GRx errata added.
> Data can be written to wrong address in SDRAM when write 
> pipelining is enabled on plb0. The setup_cpu function
> for these processors disables write pipelining.

Wow, you're fast ;)

I'd like to see this split up a bit so there's not so much in one
patch.  Essentially, introduce cpu_setup_44x.S, move the FPU init to
use it, and then add the PLB workaround.

I still need to look at the code too :)

josh
