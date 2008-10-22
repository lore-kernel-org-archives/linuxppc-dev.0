Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 813EBDDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:11:55 +1100 (EST)
Subject: Re: [PATCHv2 1/1] powerpc: Update page in counter for CMM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <48FE3B16.5050402@linux.vnet.ibm.com>
References: <200810210436.m9L4aepT056796@sullivan.realtime.net>
	<48FE3B16.5050402@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 11:11:31 +1100
Message-Id: <1224634291.7654.287.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -	if (ret & VM_FAULT_MAJOR)
> +	if (ret & VM_FAULT_MAJOR) {
>  		current->maj_flt++;
> -	else
> +		preempt_disable();
> +		get_lppaca()->page_ins++;
> +		preempt_enable();
> +	} else

That isn't going to work very well on 32-bit or non-pseries
platforms :-)

We need either something like a ppc_md. callback or at least a test for
firmware feature... (which probably still needs an ifdef to build on
32 bit).

Cheers,
Ben.
