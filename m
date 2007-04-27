Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 26C78DDF9C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:34:11 +1000 (EST)
Message-ID: <46324340.5000506@ru.mvista.com>
Date: Fri, 27 Apr 2007 22:38:56 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] SystemACE driver - abstract register ops
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
In-Reply-To: <528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org,
	Rick Moleres <rick.moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> For your reading pleasure, I've attached the bus attachment changes
> that I've made in my tree.  I hope to get this driver accepted into
> mainline during the 2.6.22 merge window; so please get any comments
> you have back to me ASAP.
> 
> Cheers,
> g.

ML300 + IBM microdrive.
8-bit, __BIG_ENDIAN
(ace->bus_width = 0;)

Have noticed a misprint (see below).
Correcting it seems to make the device geometry to be recognized OK, but then:

[    3.798449] xsysace xsa: Xilinx SystemACE revision 1.0.12
[    3.891228] xsysace xsa: capacity: 2104704 sectors
[    3.973193]  xsa:<4>xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0
[    6.103446] xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0
[    7.207342] xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0
[    8.311230] xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0
[    9.411113] xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0
[   10.511016] xsysace xsa: kicking stalled fsm; state=3 task=1 iter=2 dc=0

Will have a deeper look tomorrow.
And try CF card too.
At the moment not sure if this the driver issue.

Thanks,
Andrei


Index: linux-2.6.20/drivers/block/xsysace.c
===================================================================
--- linux-2.6.20.orig/drivers/block/xsysace.c
+++ linux-2.6.20/drivers/block/xsysace.c
@@ -240,9 +240,9 @@ static void ace_identin_8(struct ace_dev
  	int i = ACE_FIFO_SIZE/2;
  	while (i--)
  #if defined(__BIG_ENDIAN)
-		*ace->data_ptr = (in_8(r)) | (in_8(r+1)<<8);
+		*ace->data_ptr++ = (in_8(r)) | (in_8(r+1)<<8);
  #else
-		*ace->data_ptr = (in_8(r)<<8) | (in_8(r+1));
+		*ace->data_ptr++ = (in_8(r)<<8) | (in_8(r+1));
  #endif
  	ace->data_count--;
  }
@@ -253,9 +253,9 @@ static void ace_datain_8(struct ace_devi
  	int i = ACE_FIFO_SIZE/2;
  	while (i--)
  #if defined(__BIG_ENDIAN)
-		*ace->data_ptr = (in_8(r)<<8) | (in_8(r+1));
+		*ace->data_ptr++ = (in_8(r)<<8) | (in_8(r+1));
  #else
-		*ace->data_ptr = (in_8(r)) | (in_8(r+1)<<8);
+		*ace->data_ptr++ = (in_8(r)) | (in_8(r+1)<<8);
  #endif
  }
