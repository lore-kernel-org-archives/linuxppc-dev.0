Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8CDFADDF7B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 11:47:31 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M2FBQ-0006EX-9P
	for linuxppc-dev@ozlabs.org; Thu, 07 May 2009 18:47:28 -0700
Message-ID: <23438722.post@talk.nabble.com>
Date: Thu, 7 May 2009 18:47:28 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC8247 booting error
In-Reply-To: <20090505162649.GA4473@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23381214.post@talk.nabble.com>
	<20090505162649.GA4473@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


thanks for Scott's following

> You need to pass your physical address (0xd0000000) to ioremap() to
> obtain a virtual address that you can dereference.

actually, i have done that like you said. pass my phy addr to a virtual
addr, but i suppose it is a kernel virtual addr. i wanna get data from phy
in my application of user space. i try it by copy_to_user transfer a kernel
virtual addr to a use virtual addr for using by user. but copy_to_user
failed...

i do it like this

ssize_t read(....,char *buf,....,....)
{
     ....
      kernel_buf = (void *)ioremap(0xD0000000, 4096);
      copy_to_user(buf, kernel_buf, 4096); 
     ....
}




-- 
View this message in context: http://www.nabble.com/PPC8247-booting-error-tp23381214p23438722.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
