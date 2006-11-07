Return-Path: <nd@bplan-gmbh.de>
Date: Tue, 7 Nov 2006 10:22:49 +0100 (MET)
Message-ID: <4550503B.3060602@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <200611061103.kA6B3ADJ023943@post.webmailer.de>
	<454FC6B2.10909@246tNt.com>
In-Reply-To: <454FC6B2.10909@246tNt.com>
Content-Type: multipart/mixed; boundary="------------070106070402080104010609"
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070106070402080104010609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sylvain Munaut wrote:
>> +
>> +	/*
>> +	 * Most of ours IRQs will be level low
>> +	 * Only external IRQs on some platform may be others
>> +	 */
>> +	type = IRQ_TYPE_LEVEL_LOW;
>>   
> I've been wondering : Why LEVEL_LOW ?
> Aren't they LEVEL_HIGH ?
> (not that it changes much here ...)
> 

It makes only sense for the ext interrupts and not for the internal 
peripherals.
I made everything level low because it's quiet common (for example: 
PCI). Moreover, On our hardware (Efika) the IRQ[0-3] are dedicated to 
the PCI.

Anyway, as the current code looks inside the chipset register to 
retrieve the real settings, the 'type' vaiiable will be overwrite if 
require.

In my opinion, others platforms (without proper hw init by the firmware) 
may overwrite the external interrupt control reg in their platforms 
specific part.

>> +
>> +end:
>> +	of_node_put(picnode);
>> +	of_node_put(sdmanode);
>>   
> Is of_node_put specified as resilient to NULL argument ? (in the error
> path, that could happen)

of_node_put() is said to be NULL pointer safe.

> 
> Also, I think "PANIC" would be appropriate in the error path. If we
> can't init
> the PIC properly we may as well give up ... It's not like we're going to
> do much
> without it ...
> 

Well, panic or not your board won't do much ;-)
Moreover, the serial console should work a bit without interrupt.

On another hand, init_IRQ may return a value to indicate it succeed or 
not. but, this is beyound the scope of this patch.

Regards,

--------------070106070402080104010609
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


--------------070106070402080104010609--
