Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 21231679F6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 01:27:31 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id 988F080697AD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 11:27:33 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03696-05 for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 11:27:24 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id 6780E80697AB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 11:27:24 -0400 (EDT)
Subject: Re: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
	<1147204345.3139.11.camel@excalibur.timesys.com>
	<3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 11:23:55 -0400
Message-Id: <1147274635.23931.17.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks, Dan!  This is exactly the kind of feedback I was seeking.

Based on your comments and Wolfgang's comments, I conclude that:

     1. The U-Boots on my MPC885ADS and MPC8272ADS boards are
        unequivocally broken and should be replaced with ones from the
        official U-Boot source repositories that use IMMR values
        matching the Linux kernel source.
     2. For now, there is no pressing need to fix the existing drivers;
        they may continue dereferencing IMAP_ADDR directly as they
        currently do.
     3. In the future, the drivers will ultimately migrate toward
        individually calling ioremap() and maintaining their own private
        pointers.


Thanks again,

Walt 



On Tue, 2006-05-09 at 17:51 -0400, Dan Malek wrote:
> On May 9, 2006, at 3:52 PM, Walter L. Wimer III wrote:
> 
> > Exactly.  I think this kind of "automatic adaption" to the particular
> > platform is what should be in the vanilla kernel.
> 
> This does not mean you can choose some arbitrary value.
> There is a small range of high memory addresses that will
> work successfully for IMMR.  You may not see any problems
> right away, but depending upon drivers selected and the
> software features used, some problems will crop up.
> There are also MMU performance enhancements that may
> be used with certain values, and guaranteed kernel crashes
> at some point in the future when abused.
> 
> With Linux, the IMMR should always have a value of
> 0xf0000000 or 0xff000000 for best results.
> 
> > This was the second major part of our 2.6.11.7-based patch.  It
> > performed a single ioremap(), stored the result in a global  
> > pointer, and
> > then used that pointer in all the drivers instead of using IMAP_ADDR
> > directly.
> 
> This is not an acceptable practice.  We are removing all
> global pointers like this, and any driver that needs access to
> some or all of the IMMR space should be individually mapping
> those regions it needs.  Under the covers of ioremap() we are
> performing various alignment and reuse of address spaces
> in order to support things like performance enhancements
> and cache coherent regions.
> 
> Thanks.
> 
> 	-- Dan
> 
