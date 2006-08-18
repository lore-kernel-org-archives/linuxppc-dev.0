Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53106.mail.yahoo.com (web53106.mail.yahoo.com
	[206.190.49.56]) by ozlabs.org (Postfix) with SMTP id 884CB679F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 13:48:46 +1000 (EST)
Message-ID: <20060818034844.79626.qmail@web53106.mail.yahoo.com>
Date: Thu, 17 Aug 2006 20:48:44 -0700 (PDT)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: Re: Linuxppc-embedded Digest, Vol 24, Issue 42
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <mailman.3.1155866402.4331.linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The following code works on linux 2.6

__volatile__ unsigned char dummy;
u32 msr;
    
local_irq_disable(); 

    
((cpm2_map_t *)CPM_MAP_ADDR)->im_clkrst.car_rmr = 1;  
 /* Checkstop Reset enable */
    
/* Interrupts and MMU off */
__asm__ __volatile__ ("mfmsr    %0":"=r" (msr):);
    
msr &= ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR);
__asm__ __volatile__ ("mtmsr    %0"::"r" (msr)); 
    
dummy = ((cpm2_map_t
*)CPM_MAP_ADDR)->im_clkrst.res[0];
    
printk("Restart failed.\n");
for (;;);


--- linuxppc-embedded-request@ozlabs.org wrote:

> Send Linuxppc-embedded mailing list submissions to
> 	linuxppc-embedded@ozlabs.org
> 
> To subscribe or unsubscribe via the World Wide Web,
> visit
> 
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body
> 'help' to
> 	linuxppc-embedded-request@ozlabs.org
> 
> You can reach the person managing the list at
> 	linuxppc-embedded-owner@ozlabs.org
> 
> When replying, please edit your Subject line so it
> is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
> 
> 
> Today's Topics:
> 
>    1. RE: reboot on PQ2FADS board. (Liu Dave-r63238)
> 
> 
>
----------------------------------------------------------------------
> 
> Message: 1
> Date: Fri, 18 Aug 2006 09:45:21 +0800
> From: "Liu Dave-r63238" <DaveLiu@freescale.com>
> Subject: RE: reboot on PQ2FADS board.
> To: "Zhimin \(Jimmy\) Liu" <zliu@edgar-online.com>,
> 	<linuxppc-embedded@ozlabs.org>
> Message-ID:
> 
>
<995B09A8299C2C44B59866F6391D26350CDA9C@zch01exm21.fsl.freescale.net>
> Content-Type: text/plain; charset="us-ascii"
> 
> Hi Liu,
>  
> please try this..
>  
>      u32 msr;
>      
>      volatile immap_t *immap = (immap_t *)
> IMAP_ADDR;
>      
>      
>      /* Interrupts and MachineCheck off */
>      __asm__ __volatile__ ("mfmsr    %0":"=r"
> (msr):);
>      
>      msr &= ~(MSR_ME | MSR_EE);
>      __asm__ __volatile__ ("mtmsr    %0"::"r"
> (msr)); 
>      
>      immap->im_clkrst.car_rmr = 1;    /* Checkstop
> Reset enable */
> 
>      immap->resxxx = 0;        /* please find one
> immap illegal address
>                                    access it, trig
> reset */
>      for (;;);
> 
> 
> 
> ________________________________
> 
> 	From:
>
linuxppc-embedded-bounces+daveliu=freescale.com@ozlabs.org
>
[mailto:linuxppc-embedded-bounces+daveliu=freescale.com@ozlabs.org]
> On
> Behalf Of Zhimin (Jimmy) Liu
> 	Sent: Friday, August 18, 2006 1:00 AM
> 	To: linuxppc-embedded@ozlabs.org
> 	Subject: reboot on PQ2FADS board.
> 	
> 	
> 
> 	Did you sovlve the problem? I have same issue for
> the  PQ2FADS
> board. 
> 
> 	jimmy 
> 
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL:
>
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20060818/968e753a/attachment.html
> 
> 
> ------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> End of Linuxppc-embedded Digest, Vol 24, Issue 42
> *************************************************
> 


Jimmy Zhimin Liu
mailto:jimmyzhmliu@yahoo.com
www.edgar-online.com
11200 Rockville Pike, Suite 301
Rockville, MD 20874
(301)287-0339(O)
(202)499-6822(H)

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
