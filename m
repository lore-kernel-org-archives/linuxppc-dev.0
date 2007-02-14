Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 582EBDDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:58:08 +1100 (EST)
Message-ID: <45D385E9.4020808@freescale.com>
Date: Wed, 14 Feb 2007 15:58:01 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <1171409687840-git-send-email-timur@freescale.com>	
	<1171411075.20192.116.camel@localhost.localdomain>	
	<45D29AE5.7090004@freescale.com>	
	<1171430877.20192.133.camel@localhost.localdomain>	
	<45D29EB1.5060801@freescale.com>	
	<1171431334.20192.138.camel@localhost.localdomain>	
	<45D316CD.9070901@freescale.com>	
	<1171486473.20192.147.camel@localhost.localdomain>	
	<45D378F4.3040003@freescale.com>
	<1171487822.20192.163.camel@localhost.localdomain>
In-Reply-To: <1171487822.20192.163.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> In case somebody wants to use something else than uboot ? I'd like the
> base structure of the mandatory nodes to be there. /chosen is mandatory,
> so it should be there.

I just posted a new patch that just deletes linux,boot-cpu and leaves the 
'chosen' node alone.

However, there is a valid reason for *not* having a 'chosen' node in the DTS. 
Currently, U-Boot does not update the existing 'chosen' node.  Instead, it 
creates a new one.  This means that if one existed in the DTS, then there would 
be *two* in the device tree that is passed to the kernel.  There is no way to 
guarantee that the kernel will use the right one.

Of course, the real solution to this problem is to fix U-Boot.  However, there 
isn't any signed up to do that, and even if someone posted a patch right now, 
there's no telling when it will get applied.  And even if it got applied today, 
all current U-Boot installations would be broken.  Many of these systems will 
never be updated.

Therefore, I would say that having a 'chosen' node in the DTS is actually a 
*bad* thing, on systems that use U-Boot.

Another work-around would be to update the compiler to delete the chosen node 
when it builds the DTB.  That's not a bad idea, I think, but until that feature 
is implemented, the DTS files should not have a 'chosen' node.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
