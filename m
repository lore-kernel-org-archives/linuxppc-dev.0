Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 763E7DDF19
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 06:45:03 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l28Jjhtw032058
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 14:45:43 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l28JivEc145686
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 12:44:57 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l28Jiu9t014678
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 12:44:57 -0700
Subject: Re: [PATCH 14/15] Early serial debug support for PPC44x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070305032453.6B56ADDF1E@ozlabs.org>
References: <20070305032453.6B56ADDF1E@ozlabs.org>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 13:44:10 -0600
Message-Id: <1173383051.4861.27.camel@zod.rchland.ibm.com>
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

On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> 
> +config PPC_EARLY_DEBUG_44x_PHYSLOW
> +	hex
> +	depends PPC_EARLY_DEBUG_44x
> +	default "0x40000200"
> +
> +config PPC_EARLY_DEBUG_44x_PHYSHIGH
> +	hex
> +	depends PPC_EARLY_DEBUG_44x
> +	default "0x1"
> +

These two options need to have some kind of description string next to
hex otherwise Kconfig will not allow you to set them.  I noticed this
while playing with bamboo.  So something like:

config PPC_EARLY_DEBUG_44x_PHYSLOW
	hex "The low 32bits of the UART address"

That will allow you to change the values from the default.

josh
