Return-Path: <betatester@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16B82679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Apr 2006 06:24:04 +1000 (EST)
Message-ID: <444A89A5.4030402@orkun.us>
Date: Sat, 22 Apr 2006 14:53:09 -0500
From: Tolunay Orkun <betatester@orkun.us>
MIME-Version: 1.0
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
References: <20060421202308.D508F3526B7@atlas.denx.de>
	<200604212332.55123.antonio.dibacco@aruba.it>
In-Reply-To: <200604212332.55123.antonio.dibacco@aruba.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Antonio Di Bacco wrote:
> Little bit off topic:
> I decided to adopt a different strategy, the sw download web page will contain 
> a java applet that will act as a tftp server, then the board will be rebooted 
> and an environment variable will instruct the u-boot to tftp the new software 
> from the applet. What do you think? I know that applets cannot read local 
> files on the PC, unless they have a valid certificate but the user should 
> trust me.
> 
> Bye,
> Antonio.
> 

If this approach hits a roadblock for some reason (user resistance, 
firewall issues with tftp etc.), think about the following...

During the update you can use a small ram based file system (tempfs) 
holding everything you need, kill all unneeded processes, fill your ram 
based file system. Once this ram file system is filled you will 
pivot_root to it making it new root fs and proceed to update from it. 
Once update is down you can reboot.

I have not done this so it is very likely there are some details that I 
cannot foresee at this very moment.

Best regards,
Tolunay
