Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB638DDF9B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Oct 2007 14:55:45 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IfTbj-0003PY-3l
	for linuxppc-embedded@ozlabs.org; Tue, 09 Oct 2007 21:55:43 -0700
Message-ID: <13129401.post@talk.nabble.com>
Date: Tue, 9 Oct 2007 21:55:43 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: concern related to Functions For executing Longer delay in driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all....

I am working on a driver which is Pooling for a bit in hardware. And here is
my concern :-

1. The worst case time delay could be 400 ms for which i am pooling every 50
ms eg :-

                          while((test_bit(PIC_BUSY,(volatile UINT32*)((void
*)mmap_reg_ptr+FR_FPGA_STATUS_REG))==1)&& (delay < MAX_DELAY_PIC)){
		KDEBUG1(" In PIC busy state \n");
		msleep_interruptible(PIC_DELAY);
		delay +=PIC_DELAY;
		}/* End of if() */

2. This function will be called after every 1 min and i do have to poll for
400 ms (worst case) after every 1 min.

3. i have a wait queue Implimented in the driver which will be schedule to
be executed every time interrupt occurs (worst case 1ms).

3. The delay function which will make the driver to poll for the bit in the
hardware which you could see in the above example is
msleep_interruptible(PIC_DELAY);

4. As far as my knowledge we could use either mdelay() ,msleep(),
msleep_interruptible(), or schedule_timeout() for such long delays. I have
used msleep_interruptible() but still i feel as per the senario if i could
get a better option which will make my driver more effecient.

5. Please let me know which could be the best and reliable fn() for this
approach and please let me know the reason also .

Thank you 
Misbah
-- 
View this message in context: http://www.nabble.com/concern-related-to-Functions-For-executing-Longer-delay-in-driver-tf4598583.html#a13129401
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
