Return-Path: <cfriesen@nortel.com>
Message-ID: <421E06B9.2000504@nortel.com>
Date: Thu, 24 Feb 2005 10:54:17 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: looking for help with scomc/scomd registers on 970
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not strictly linux related, but I thought someone might know the answer.

I've got a request from someone that wants to be able to flush the L2 on 
the 970.

The user manual has a procedure to do this, but it involves first 
flipping the cache to direct-mapped mode by setting SCOM register 
0x43000 bit 0x8000.  The only thing is, I can't find any linux code that 
ever touches the SCOM stuff, and the manual has no examples of *reading* 
from the SCOM area, just writing to it, so I'm not entirely sure how to 
do that.

A google search found the following snippet of darwin code:


lis r8,cFIR ; Get the Core FIR register address
ori r8,r8,0x8000 ; Set to read data
sync
mtspr scomc,r8 ; Request the Core FIR
mfspr r25,scomd ; Get the source
mfspr r8,scomc ; Get back the status (we just ignore it)
sync
isync	
			


This implies that bit 0x8000 needs to be set to specify a read command, 
and that we need to read the status after the read.  Does anyone know if 
this is in fact the case?

Also, in that code they make reference to early chip revisions that 
returned scom reads shifted by one bit.  Does anyone know which versions 
are affected?


Thanks,

Chris
