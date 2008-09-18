Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 28D40DDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 14:43:27 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KgBMP-0001GC-NJ
	for linuxppc-embedded@ozlabs.org; Wed, 17 Sep 2008 21:43:22 -0700
Message-ID: <19545826.post@talk.nabble.com>
Date: Wed, 17 Sep 2008 21:43:21 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Ioremap related concern ...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

i am facing a problem regarding the usage of ioremap function which is
described as:-

1) I am remaping the SDRAM memory into three continews buffer as 
	ptr1 = (unsigned int *)ioremap(0x0001000,0x1000);
	ptr2 = (unsigned int *)ioremap(0x0002000,0x1000);
	ptr3 = (unsigned int *)ioremap(0x0003000,0x1000);

I am filling the data into the SDRAM buffer using these remap pointers 

2)  SDRAM is mmaped to user space into a buffer as 
	struct sdram_buf
	{
		unsigned int buf[4096];

	};
	struct sdram_buf sdram_buf_obj[3];

The mapping looks correct but it doesent work ... :(

	If is do the ioremap like this it works 
	
	ptr1 = (unsigned int *)ioremap(0x0001000,(0x1000 * 4));
	ptr2 = (unsigned int *)ioremap(0x0002000,(0x1000 * 4));
	ptr3 = (unsigned int *)ioremap(0x0003000,(0x1000 * 4));

	Doing this actually takes more space into the ram memory hence for mapping 
	1 M of Ram memeoy it actually takes 4 MB practically.

Can any one point out the mistake or suggest something ...
-- 
View this message in context: http://www.nabble.com/Ioremap-related-concern-...-tp19545826p19545826.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
