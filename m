Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7B1BDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 18:22:05 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ISTff-0008S3-1t
	for linuxppc-embedded@ozlabs.org; Tue, 04 Sep 2007 01:22:03 -0700
Message-ID: <12473922.post@talk.nabble.com>
Date: Tue, 4 Sep 2007 01:22:03 -0700 (PDT)
From: sanguru <santoshguru@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Enabling Cache in MPC5200
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


Hi,
I am using a LITE5200 evaluation board, and am not able to enable the
 cache.
The execution hangs in these calls.
void EnableInstCache(void)
{
     __asm(" mfspr   r5,1008");
     __asm(" ori     r5,r5,0x00008800");// # Set the ICE and ICFI bit
     __asm(" andi.   r6,r5,0x0000F7FF");// # clear the ICFI bit for the
 final store
     __asm(" mtspr   1008,r5");
     __asm(" isync");
     __asm(" isync");
     __asm(" isync");
     __asm(" isync");
     __asm(" sync");
    __asm(" mtspr   1008,r6");// # Do the final store
    __asm(" isync");
    __asm(" sync");

}

void EnableDataCache(void)
{
     __asm(" mfspr   r5,1008");
     __asm(" ori     r5,r5,0x00004400");// # Set the ICE and ICFI bit
     __asm(" andi.   r6,r5,0x0000FBFF");// # clear the ICFI bit for the
 final store
     __asm(" mtspr   1008,r5");
     __asm(" isync");
     __asm(" isync");
     __asm(" isync");
     __asm(" isync");
     __asm(" sync");
    __asm(" mtspr   1008,r6");// # Do the final store
    __asm(" isync");
    __asm(" sync");

}
What could be the problem?
Thanks
-San
-- 
View this message in context: http://www.nabble.com/Enabling-Cache-in-MPC5200-tf4376247.html#a12473922
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
