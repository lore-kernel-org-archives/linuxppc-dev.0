Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 41E3167A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 03:07:41 +1000 (EST)
Message-ID: <17071.198.22.236.230.1112805973.squirrel@198.22.236.230>
Date: Wed, 6 Apr 2005 12:46:13 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: kernelnewbies@nl.linux.org
Subject: mpc8248: how to map SEC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

freescale's mpc8248: how to map SEC ?
I am trying to map SEC(Security Engine). The linux-kernel i have from
embeddedplanet.com already  works great for CPM on this mpc8248.

In my first  approach i tried to run this block-of-code at the end of
fec_enet_init/fcc_enet.c
{
 unsigned long coremask1;
 unsigned long IOBaseAddress1;
 bd_t     *bd;
 bd = (bd_t *)__res;
 #define IDENTIFICATION_OFFSET1 0x1020
 #define SEC_BASE_ADDRESS       0x00040000
 #define SEC2_BASE_SIZE1        0x10000
 IOBaseAddress1=(unsigned long)
ioremap((phys_addr_t)(bd->bi_immr+SEC_BASE_ADDRESS), SEC_BASE_SIZE);
 coremask1=*((volatile unsigned long *)(IOBaseAddress1 +
IDENTIFICATION_OFFSET1) +1);
 printk(KERN_EMERG"SEC1.0 ID=%lu",coremask1);
}
But it will OOPS complaining 0x00040000 was passed to ioremap, that means 
bd->bi_immr is NULL. Why is it so? This approach works well for mpc8555E
SEC engine.

Second approach , i am trying to immitate based on how CPM is accessed on
mpc8248, here CPM_MAP_ADDR is #defined to ((uint)0xf0000000). Can i make a
similar #define for SEC_MAP_ADDR ? How the above value for CPM_MAP_ADDR
was chosen in arch/ppc/platforms/ep8248.h:line 42 ?

Will appreciate the help? I am struck here right now
