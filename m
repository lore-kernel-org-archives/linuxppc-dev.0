Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77F00DDE35
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 11:29:00 +1100 (EST)
Subject: Re: [PATCH] Fix performance monitor exception in 2.6.20-series
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Livio Soares <livio@eecg.toronto.edu>
In-Reply-To: <20070113154029.GA32292@eecg.toronto.edu>
References: <20070113154029.GA32292@eecg.toronto.edu>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 11:29:04 +1100
Message-Id: <1168734544.5011.78.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>   IMHO, option  #1 is very  nice, as long  as the PMU interrupt  handler behaves
> itself.  One reason option #1 is desirable is, with PC-sampling, we are now able
> to  sample  regions _inside_  interrupt-disabled  sections  (assuming an  actual
> external interrupt  hasn't really occured yet). Before,  with hardware disabling
> of  interrupts,  the  PMU  exceptions  were  necessarily  delivered  outside  of
> interrupt disabled sections. 
> 
>   Anyways, does anyone see a problem with the following patch? 

Well, are you absolutely sure that nothing will break as a result of
having a PMU interrupt happening right when it's not expected to ?

You are basically turning the PMU interrupt into an NMI... I'm not sure
how safe that is.

Ben.
