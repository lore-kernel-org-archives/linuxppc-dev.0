Return-Path: <tnt@246tNt.com>
Received: from outmx003.isp.belgacom.be (outmx003.isp.belgacom.be
	[195.238.4.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BBB967BAD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 06:12:28 +1100 (EST)
Received: from outmx003.isp.belgacom.be (localhost [127.0.0.1])
	by outmx003.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kAHJCJV7016251
	for <linuxppc-embedded@ozlabs.org>; Fri, 17 Nov 2006 20:12:20 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <455E0987.7000809@246tNt.com>
Date: Fri, 17 Nov 2006 20:12:07 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
	libata
References: <11637151391017-git-send-email-tnt@246tNt.com>
	<20061116234601.78325642@localhost.localdomain>
In-Reply-To: <20061116234601.78325642@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Embedded <linuxppc-embedded@ozlabs.org>,
	Sven Luther <sl@bplan-gmbh.de>, Linux IDE <linux-ide@vger.kernel.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alan wrote:
> On Thu, 16 Nov 2006 23:12:19 +0100
> Sylvain Munaut <tnt@246tNt.com> wrote:
>
>   
>> * The manual states we should check for the TIP bit before all
>> PIO transaction. That's not really supported by libata and requires
>> reimplementing almost all the hooks. But after talking to Freescale,
>> it turnsout it's not really necessary. So this driver doesn't implement
>> that check. I noticed no problem so far ...
>>
>>     
>
> All PIO transactions meaning each PIO command sequence or each register
> read/write ? In the former case is it not enough just to wrap the command
> write ?
>   
Each register write apparently.

>> * This driver doesn't use the standard function to compute timing
>> because the 5200 needs more timing parameters that are not handled
>> by the generic call (ta and t4).
>>     
>
> I'd rather the generic code was taught to compute any extra times you
> need but it seems clean enough.
>   
Well, I can do that as well. It should be simple enough and not
interfere with
the existing drivers.


Sylvain
