Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 8541B67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 04:58:21 +1100 (EST)
Message-ID: <42275039.7000702@mvista.com>
Date: Thu, 03 Mar 2005 10:58:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: James Chapman <jchapman@katalix.com>
References: <42235B0A.3070302@katalix.com> <422384CA.6090004@mvista.com>
	<4223977C.4070502@katalix.com> <42239A2D.8070205@mvista.com>
	<4224C285.6000409@katalix.com>
In-Reply-To: <4224C285.6000409@katalix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.11-rc4] ppc: add support for Radstone ppc7d boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

James Chapman wrote:

> Revised patch for Radstone PPC7D board support.
>
> Signed-off-by: James Chapman <jchapman@katalix.com>
>
> - use mv64x60_set_bus() to setup for PCI scans rather than
>   writing to chip P2P_CONFIG registers directly. 


Looks good, James, except for a couple minor things.  If/when you 
address the comments, please resubmit the entire patch with a proper 
description so I can forward it on -- http://linux.yyz.us/patch-format.html

Thanks,

Mark
--

 > diff -Nru a/arch/ppc/platforms/radstone_ppc7d.c 
b/arch/ppc/platforms/radstone_ppc7d.c

 > +#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
 > +       mv64x60_mpsc_init(port, uart);

Don't you mean "mv64x60_progress_init( <base> );" ?

 > diff -Nru a/arch/ppc/platforms/radstone_ppc7d.h 
b/arch/ppc/platforms/radstone_ppc7d.h

 >+#define PPC7D_MV64360_REG_BASE                 0xfef00000

You don't really need this b/c CONFIG_MV64X60_NEW_BASE should have the 
correct value.
