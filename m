Return-Path: <tnt@246tNt.com>
Received: from outmx027.isp.belgacom.be (outmx027.isp.belgacom.be
	[195.238.2.208]) by ozlabs.org (Postfix) with ESMTP id A7DBF67A2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 08:06:44 +1100 (EST)
Received: from outmx027.isp.belgacom.be (localhost [127.0.0.1])
	by outmx027.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2BL6cCl011976
	for <linuxppc-embedded@ozlabs.org>; Fri, 11 Mar 2005 22:06:39 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4232085F.9000909@246tNt.com>
Date: Fri, 11 Mar 2005 22:06:39 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
References: <4231F9F9.5080506@246tNt.com> <4231FABA.2030809@246tNt.com>
	<20050311204823.GA11928@xyzzy>
In-Reply-To: <20050311204823.GA11928@xyzzy>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/2] MPC52xx updates : PCI Support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:

>The first hunk of arch/ppc/platforms/lite5200.c looks corrupted.
>See the line beginning "fdef CONFIG_PCI".
>
>-Dale
>
>  
>
Damn, you're right and even the first patch is screwed, half of it is 
missing.

Discard theses, I'll put them on-line somewhere and post the urls.


    Sylvain

>On Fri, Mar 11, 2005 at 08:08:26PM +0000, Sylvain Munaut wrote:
>  
>
>>And here's the second patch :
>>    
>>
>
>[ deleted lines ]
>
>  
>
>>diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
>>--- a/arch/ppc/platforms/lite5200.c     2005-03-11 20:41:56 +01:00
>>+++ b/arch/ppc/platforms/lite5200.c     2005-03-11 20:41:56 +01:00
>>@@ -35,6 +35,8 @@
>>#include <asm/ocp.h>
>>#include <asm/mpc52xx.h>
>>
>>+#include <syslib/mpc52xx_pci.h>
>>+
>>
>>extern int powersave_nap;
>>
>>fdef CONFIG_PCI
>>+static int
>>+lite5200_map_irq(struct pci_dev *dev, unsigned char idsel,
>>+                 unsigned char pin) {
>>+       return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
>>+}
>>+#endif
>>    
>>
>
>[ more deleted lines ]
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  
>
