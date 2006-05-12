Return-Path: <s.maiti@tcs.com>
Received: from inkolg01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 9D218679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 15:10:25 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DDA7@ismail.innsys.innovsys.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: Help Needed: input overrun(s)
MIME-Version: 1.0
From: s.maiti@tcs.com
Message-ID: <OF3D251B79.F77E45B0-ON6525716C.00158469-6525716C.001C29A9@tcs.com>
Date: Fri, 12 May 2006 10:37:38 +0530
Content-Type: text/plain; charset="us-ascii"
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

Thank you very much for your help. Actually in our driver we are using all 
128 channels of MCC1. So we have relocated the dpram for the uart and 
ethernet to the dpram 3 and freed the space for the MCC1 accordingly. We 
have gone through our allocations, nowhere it's conflicting. 
In your case is your driver able to transmit and receive data correctly? 
In our case whenever we load the driver the console output gets crambbled. 
Through debugging we have identified that the cause of it may be due to 
the configuration of L1RSYNC, L1TSYNC, RCLK and TCLK. Can these 
configuration cause this ttyS overrun? 
Also when the driver is loaded we are not getting any interrupts. We are 
writting to the Tx buffer through a user space application, but that is 
not resulting in any tx interrupts. Can you help me regarding this.
Also I will be grateful to if let me know which kernel version of linux 
you are using and the flow of initialization you are using in your driver.
Looking forward to your help.

Thanks and regards,
Souvik Maiti
Tata Consultancy Services Limited
Mailto: s.maiti@tcs.com
Website: http://www.tcs.com



"Rune Torgersen" <runet@innovsys.com> 
05/11/2006 07:44 PM

To
<s.maiti@tcs.com>
cc
<linuxppc-embedded@ozlabs.org>, "Stevan Ignjatovic" <stevan@iritel.com>
Subject
RE: Help Needed: input overrun(s)






> From: s.maiti@tcs.com [mailto:s.maiti@tcs.com] 
> Thanks very much for your reply. It's seems you have already 
> developed the MCC driver. Are you using channels 32 to 96? 
> Have you made any changes in the dp ram allocation for uart 
> or ethernet driver? 
> Please help me... 

We are using every other channel from 32 to 96 on both MCC's as SS7
receivers.
We did not have to do any relocations for UART or ethernet. 
Ethernet uses upper DPRAM (above 0x8000) and uarts use the first 128
bytes.

We statically allocate DPRAM with cpm_alloc_fixed. MCC1 use 0x0800 to
0x17ff
MCC2 use 0x2800 to 0x37ff. Extra param RAM is allocated with cpm_alloc
and is allocated as 256*8 bytes, and shared between MCC1 and 2.

All BD and interrupt tables are in main memory.

ForwardSourceID:NT00006DD6 
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
