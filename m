Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C4DCDE0D7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:41:47 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m3SFevAL028237
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:40:58 -0500
Message-Id: <DF3B8F4C-EAE1-4F44-8884-44535A855139@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: suggestions on handling additional exception levels on ppc32
Date: Mon, 28 Apr 2008 10:40:56 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm looking at fixing an issue parts that have multiple exception  
levels (e300, 40x, booke).

One of the issues is the transfer_to_handler patch in entry_32.S  
doesn't use the proper save/restore registers to transfer to C code.

The following bit of code is what I'm having issues with:

         .globl transfer_to_handler_cont
transfer_to_handler_cont:
3:
         mflr    r9
         lwz     r11,0(r9)               /* virtual address of handler  
*/
         lwz     r9,4(r9)                /* where to go when done */
         mtspr   SPRN_SRR0,r11
         mtspr   SPRN_SRR1,r10
         mtlr    r9
         SYNC
         RFI                             /* jump to handler, enable  
MMU */

A few possibilities:
* introduce an additional function pointer as part of  
EXC_XFER_TEMPLATE() to specifies the type of handler (normal, crit,  
dbg, mcheck)
* use the traps field low order bits to determine normal, crit, dbg,  
mcheck at run time.
* duplicate the code paths for each exception level

suggestions?

- k
