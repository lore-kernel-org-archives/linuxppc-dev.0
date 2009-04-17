Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A808DDEF5
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 06:36:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3HKWwst017449
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:32:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3HKaNbE197582
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:36:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3HKaMqN007889
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:36:22 -0400
Date: Fri, 17 Apr 2009 16:35:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: Question about DBCR0 initialization for 440
Message-ID: <20090417203531.GB3776@zod.rchland.ibm.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
	<200904171307.47734.hollisb@us.ibm.com>
	<1239995087.7210.19.camel@pasglop>
	<fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
	<20090417203053.1D692F88052@mail119-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090417203053.1D692F88052@mail119-dub.bigfish.com>
Cc: Tirumala Reddy Marri <tmarri@amcc.com>,
	Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 02:30:45PM -0600, John Linn wrote:
>> > Might be worth checking if external debug is enabled, and 
>> override it
>> > only if it's not.
>> 
>> ppc440x5_um.pdf says that both can be enabled.
>> 
>
>The code that I started the thread with, from the fsl file, has conditional for the BDI around it.
>
>We think that we still need that conditional as the code is not Oring in the enable such that it would
>disable external debug mode for the BDI. But we need it this way for our Xilinx pod.

EDM is a read-only bit according to the docs I have.  You can't set it (or
clear it) at all.  It's only set by external hardware.

josh
