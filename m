Return-Path: <frannk_m1@yahoo.com>
Received: from web13803.mail.yahoo.com (web13803.mail.yahoo.com
	[216.136.175.13]) by ozlabs.org (Postfix) with SMTP id 38DAA2BD7B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 07:57:02 +1000 (EST)
Message-ID: <20040917215020.72936.qmail@web13803.mail.yahoo.com>
Date: Fri, 17 Sep 2004 14:50:20 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: cascading 8259 interrupts
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am having problems getting the 8259 interrupts setup on my
mpc8245 based board. here is what I have:
EPIC interrupt 0: ethernet controller
EPIC interrupt 1: unused at this time
EPIC interrupt 2: 8259 PIC controller
EPIC interrupt 3: internal uart


I have the ethernet and urat working just fine. I can NFS mount
my root directory accross the network and I console I/O working
just fine. The problem is when I try to cascade the 8259 PIC to
interrupt 2, Linux hangs when booting. I have tried using the
sandpoint board as a model but it doesn't cacscade 8259
interrupts to EPIC interrupt2, it uses EPIC interrupt 0
according to the comments. 
How can I cacscade the 8259 to my EPIC interrupt 2???
Here's my code in my baord_setup.c:

   openpic_set_sources(0, 2, OpenPIC_Addr + 0x10200);
   openpic_set_sources(2, 1, OpenPIC_Addr + 0x10240);
   openpic_set_sources(3, 1, OpenPIC_Addr + 0x11120);

   openpic_init(NUM_8259_INTERRUPTS);
   openpic_hookup_cascade(18, "8259 cascade to EPIC",
&i8259_irq);

        for ( i = 2 ; i < 3 ; i++ )
             irq_desc[i].handler = &i8259_pic;
        i8259_init(0xfef00000);




		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
