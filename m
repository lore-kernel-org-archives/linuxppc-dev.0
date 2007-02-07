Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C87BEDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:42:01 +1100 (EST)
In-Reply-To: <1170883956.2620.305.camel@localhost.localdomain>
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45DA66E1-EAB7-4A3A-9347-4564F6A68C0F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
Date: Wed, 7 Feb 2007 15:41:02 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 3:32 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2007-02-07 at 15:17 -0600, Timur Tabi wrote:
>> Hi everyone,
>>
>> What is the current consensus on using mac-address vs. local-mac- 
>> address in the
>> device tree?  The 1275 spec says this:
>>
>> "local-mac-address" Standard property name to specify preassigned  
>> network address.
>> "mac-address" Standard property name to specify network address  
>> last used.
>>
>> I think we need to agree on some interpretation of these  
>> statements, and all the
>> code should be updated to implement that interpretation.
>
> It's fairly clear:
>
> local-mac-address is what is statically set by the firwmare (comes  
> from
> EEPROM, whatever).
>
> mac-address is really only meaningful if your firmware is
> "dynamic" (real OF, uboot maybe) and was, for some reason,  
> instructed by
> the user to use a different mac address for that boot (if that feature
> exist).
>
> It's basically the mac-address that was actually used on that  
> interface
> to netboot the kernel I'd say.

Which means the code in fsl_soc.c is wrong in how it handles the  
precedence of gianfar:

                 mac_addr = get_property(np, "local-mac-address", NULL);
                 if (mac_addr == NULL)
                         mac_addr = get_property(np, "mac-address",  
NULL);
                 if (mac_addr == NULL) {
                         /* Obsolete */
                         mac_addr = get_property(np, "address", NULL);
                 }

should really be:

                 mac_addr = get_property(np, "mac-address", NULL);
                 if (mac_addr == NULL)
                         mac_addr = get_property(np, "local-mac- 
address", NULL);
                 if (mac_addr == NULL) {
                         /* Obsolete */
                         mac_addr = get_property(np, "address", NULL);
                 }

- k
