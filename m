Return-Path: <scottwood@freescale.com>
Message-ID: <46CB0FB9.5000706@freescale.com>
Date: Tue, 21 Aug 2007 11:15:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/20] bootwrapper: Add CPM serial driver.
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173957.GI30562@ld0162-tx32.am.freescale.net>
	<20070821024200.GJ15469@localhost.localdomain>
In-Reply-To: <20070821024200.GJ15469@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>>diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
>>index 944f0ee..d47f8e0 100644
>>--- a/arch/powerpc/boot/serial.c
>>+++ b/arch/powerpc/boot/serial.c
>>@@ -121,6 +121,11 @@ int serial_console_init(void)
>> 		rc = ns16550_console_init(devp, &serial_cd);
>> 	else if (dt_is_compatible(devp, "marvell,mpsc"))
>> 		rc = mpsc_console_init(devp, &serial_cd);
>>+	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
>>+	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
>>+	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
>>+	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
>>+		rc = cpm_console_init(devp, &serial_cd);
> 
> 
> If all these variants admit a compatible driver, there really should
> be defined a compatible value that they all include in the device
> tree.

That's what I did last time, and several people complained. :-)

The issue was that while there is a lot in common between these 
variants, there's no one common subset that can be used to drive the 
device without knowledge of what variant it is (or knowledge of where 
the firmware placed the descriptors).

> But I guess you'd still need all these tests for device trees
> which didn't have it.

Nah, this is a new binding.

-Scott
