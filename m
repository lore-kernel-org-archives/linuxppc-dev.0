Return-Path: <hollisb@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F800DE088
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 06:50:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3HKkiot012157
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:46:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3HKoLF1154016
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:50:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3HKmbXV003103
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 16:48:37 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 15:50:18 -0500
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
	<20090417203053.1D692F88052@mail119-dub.bigfish.com>
In-Reply-To: <20090417203053.1D692F88052@mail119-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904171550.19625.hollisb@us.ibm.com>
Cc: Tirumala Reddy Marri <tmarri@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 April 2009 15:30:45 John Linn wrote:
> We think that we still need that conditional as the code is not Oring in the 
enable such that it would
> disable external debug mode for the BDI. But we need it this way for our 
Xilinx pod.
> 
> #if !defined(CONFIG_BDI_SWITCH)
>             /*
>              * The Abatron BDI JTAG debugger does not tolerate others
>              * mucking with the debug registers.
>              */
>             lis     r2,DBCR0_IDM@h
>             mtspr   SPRN_DBCR0,r2
>             isync
>             /* clear any residual debug events */
>             li      r2,-1
>             mtspr   SPRN_DBSR,r2
> #endif

So change the code to OR in your bits. What's the problem?

-- 
Hollis Blanchard
IBM Linux Technology Center
