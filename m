Return-Path: <ankur_maheshwari@procsys.com>
Received: from mailsvr.procsys.com (unknown [61.95.199.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 482A5DE11B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Oct 2007 16:55:50 +1100 (EST)
Received: from [192.168.1.243] ([192.168.1.243])
	by mailsvr.procsys.com (8.13.5/8.13.5) with ESMTP id l9U5voar024818
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Oct 2007 11:27:50 +0530
Message-ID: <4726C743.9070809@procsys.com>
Date: Tue, 30 Oct 2007 11:25:15 +0530
From: Ankur Maheshwari <ankur_maheshwari@procsys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [Fwd: mpc8xx, i2c read DB busy issue]
Content-Type: multipart/mixed; boundary="------------030609030005020502090508"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030609030005020502090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030609030005020502090508
Content-Type: message/rfc822;
 name="mpc8xx, i2c read DB busy issue.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc8xx, i2c read DB busy issue.eml"

X-Mozilla-Keys: 
Message-ID: <4721B3B7.8070602@procsys.com>
Date: Fri, 26 Oct 2007 15:00:31 +0530
From: Ankur Maheshwari <ankur_maheshwari@procsys.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: mpc8xx, i2c read DB busy issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I am trying to use mpc860 as i2c-SLAVE. Kernel, I am using is 
Linux-2.4.4, which I can't change due to some reasons.

I am able to do I2C read/write operations on mpc8xx-i2c slave only after 
re-insmoding my driver module (i2c-algo-8xx.c, and adapter layer drive, 
code I took form i2c-rpx/r360.c ).

The issue I am facing is when I insmod i2c-driver on fresh Linux boot, 
any i2c-mpc860 as slave read/write operation gives me busy status (which 
is for Rx BD not available) in Controller's i2c Event Registers. When I 
get busy status I have to do force_close() and re-init of bd, then only 
busy status goes off.

I tried calling cpm_iic_init(); twice while __init but with no change in 
busy status.

After some initial try, i2c slave write works but i2c read gives no data 
to the master. After re-insmoding driver, read/write works with some 
times (1 out of 15 times) i2c-read failing.

But still I can't understand why busy is coming....

Any help or suggestions are highly appreciated.

thanks,
Ankur Maheshwari

 


--------------030609030005020502090508--
