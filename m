Return-Path: <nd@bplan-gmbh.de>
Date: Sun, 5 Nov 2006 14:16:54 +0100 (MET)
Message-ID: <454DE41C.3090609@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <454902F9.20206@bplan-gmbh.de>	
	<1162419138.25682.453.camel@localhost.localdomain>	
	<454A1C37.5050208@bplan-gmbh.de>	<454A5952.6090801@bplan-gmbh.de>	
	<1162683341.28571.82.camel@localhost.localdomain>	
	<20061105111753.3e41f6b7.nd@bplan-gmbh.de>	
	<1162723031.28571.228.camel@localhost.localdomain>	
	<20061105123101.3cc1696f.nd@bplan-gmbh.de>
	<1162731733.28571.241.camel@localhost.localdomain>
In-Reply-To: <1162731733.28571.241.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------020102060401090704060108"
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020102060401090704060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>> As said, no option here. I think there is different way to see how works the PIC. However, from a register point of view. There is just critical, main, peripherals, SDMA.
>>
>> Loot at "ICTL Perstat, MainStat, MainStat, CritStat Encoded Register--MBAR + 0x0524"
> 
> You should have your device-tree match your internal numbering. As you
> noticed, the CRIT interrupt and the EXT interrupts are just the same.

As I see, they aren't.
Critical interrupts defines IRQ 0, as well as slice timer0, WakeUp from 
deep-sleep mode (CCS) interrupt, etc..

Where as main is IRQ[1-3] as well as others stuff.

I did implement/change the irqchip, on your request, because in this 
case (IRQ0 -> l2=1, IRQ[13] -> l2=1->3). and the ack/mask bit are the 
same, it makes sense to have the same func called.

> So right now, what you should do is figure out a proper encoding for the
> firmware, and then either fix your device-tree, or do a hack in
> prom_init.c that fixes it up.
> 

I think the OFW has proper encoding, moreover, this encoding was done up 
on your request and opinion.

If you still want to change the Linux interrupt encoding, I will then 
hack prom_init.c and submmit new patches...

Regards,

--------------020102060401090704060108
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------020102060401090704060108--
