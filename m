Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 50DEFDDEE5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:45:21 +1100 (EST)
Message-ID: <45D1F92B.3000000@freescale.com>
Date: Tue, 13 Feb 2007 11:45:15 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45D1F46C.4050901@freescale.com>
	<5B1BBAE9-00FC-454B-8855-7D362DF59850@kernel.crashing.org>
In-Reply-To: <5B1BBAE9-00FC-454B-8855-7D362DF59850@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> How about something like comparing against a local null array instead.  
> Something like:
> 
>     u8 null_mac_addr[6] = { 0 };
>     if (!mac_addr || (memcmp(mac_addr, null_mac_addr, 6) == 0)) {

I believe this will cause the compiler to generate more code, not less.  When 
you declare an initialized array as a local variable, the compiler reserves 
space on the stack, and then it generates code to copy the data from some global 
storage to the stack.

If I inline a string instead, however, the compiler will just put the string in 
global storage and reference it directly.  The compiler should be able to detect 
multiple instances of the same string, and store them as a single string.

If you still want null_mac_addr[], you would need to do this:

	static const u8 null_mac_addr[6] = { 0 };

Although frankly it would be nice if the Ethernet module had static globals and 
functions for this sort of thing.

Do you still want me to create null_mac_addr[], as above?  I was going to put 
the code inside an inline function anyway, per Sergei's request.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
