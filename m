Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78A14B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 05:32:26 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB8ITsMs019766
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2009 11:29:54 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id nB8IW7SX031484
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2009 11:32:09 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB8IW6XH013385
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2009 11:32:06 -0700
Date: Tue, 8 Dec 2009 13:32:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: vinayak.kale@gmail.com
Subject: Re: DTS parsing and kernel bus support query
Message-ID: <20091208183203.GN2937@zod.rchland.ibm.com>
References: <0016363b7ec8d1ffb8047a37e663@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0016363b7ec8d1ffb8047a37e663@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 08, 2009 at 01:53:41PM +0000, vinayak.kale@gmail.com wrote:
> Hi
>
> I have following queries about DTS parsing and kernel bus support. I 
> would really appreciate any help.
>
> I have a PowerPC 440 core based board. We are porting Linux kernel – 2.6.31.
>
> 1) For other PowerPC 4xx based boards, what we found is devices like  
> UART/I2C/GPIO are connected through PLB->OPB buses. Accordingly we 
> specify the node structure inside a dts file. Does kernel uses the actual 
> path to locate a node eg /plb/opb/i2c? or it uses the compatible property 
> to locate a node?

It calls "of_platform_bus_probe" very early with a list of buses to walk to
create the of_platform devices.  Then the device drivers will use the
compatible properties to bind to the right of_platform devices.  If the bus
isn't walked, then those devices won't get created in the kernel.  See the
beginning portions of arch/powerpc/platforms/44x/ppc44x_simple.c.

> 2)In case of our board, instead of OPB and EBC we have buses like AI and  
> APB. So our DTS node struct for UART looks like /plb/ai/apb/serial. For  
> this do we need to add any extra support in kernel in order to recognize  
> the devices on AI and APB buses? Similar question for Flash device. It's 
> on the path /plb/ai/flash.

You would need to clearly have the AI and APB buses in the DTS file, and then
have them walked via of_platform_bus_probe.  If they are simple busses without
odd translations, it shouldn't be too hard to do.

> I need to access UART/I2C/GPIO/Flash devices over AI and APB bus. PLB is  
> connected to AI bus. AI is further connected to APB.
>
> 3) Do we need to add extra support for AI/APB bus in kernel?

Not sure.  I don't know how those busses operate.

josh
