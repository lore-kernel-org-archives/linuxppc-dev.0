Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id F125B67D82
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 01:40:30 +1000 (EST)
Message-ID: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
Date: Fri, 29 Jul 2005 11:40:27 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: mpc8248  SEC -- interrupt handler not invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
  Will  appreciate if someone can guide me how to debug this inside SEC
(security co-processor) core.

 The linux driver is writing descriptor into the FETCH-Register(0x2048) 
for Random Number generation execution unit(RNG-EU). The request came
through a test program from user space. The RNG generation request never
seems to complete as my ISR is not invoked.
 I checked the CCPSR(Crypto Channel Pointer Status register = 0x2010) and
it has value=0:7(0-31 : 32-63 bits). 7 means "channel_error". But its
always there even before I write the RNG descriptor to Fetch-register.

1. I can read the ID register and verified it is 0x09000000.
2. I can see my ISR is registered(0x47)  under /proc/interrupts.

I don't see anything wrong with the descriptor which is very simple Random
Number Generation request.

regards
-vikas aggarwal
