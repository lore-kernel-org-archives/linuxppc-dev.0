Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-01.bluehost.com (outbound-mail-01.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id 350B1DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Sep 2008 16:32:26 +1000 (EST)
Received: from [72.25.39.148] (helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <dhlii@dlasys.net>) id 1KhI4n-0007qn-4a
	for linuxppc-embedded@ozlabs.org; Sun, 21 Sep 2008 00:05:45 -0600
Message-ID: <48D5E437.6060708@dlasys.net>
Date: Sun, 21 Sep 2008 02:05:43 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: C67x00 USB problems
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


    Good news - works.
    Bad news - sort of.

    I am using the C67x00_HCD driver from 2.6.24 mainline.
   
    If I kill off installing the interrupt handler and just poll it.
    I can get the first port working - fairly slowly.

    If I enable the interrupt handler I get lots of messages from the
Kernel about unhandled IRQ's and then the Kernel disables
    the IRQ. Although sometimes I just get a kernel panic when loading
the driver.

    The only way out of the irq handler without handling the IRQ is

     // printk(KERN_ERR "c67x00_irq()00\n");
    int_status = c67x00_ll_hpi_status(c67x00);
    if (!int_status)
        return IRQ_NONE;

    But if that is failing then why are things working when polled ?

    Clues would be greatly appreciated ?

    Is there any interest in a patch to support polling the USB driver ?








   






-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
