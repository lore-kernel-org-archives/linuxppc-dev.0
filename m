Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1676DDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 05:22:13 +1000 (EST)
Message-ID: <46BCBB2C.2040408@genesi-usa.com>
Date: Fri, 10 Aug 2007 20:23:24 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] pseries: device node status can be "ok" or "okay"
References: <20070809232700.GY25995@austin.ibm.com>
	<769ccd8091fc725571c5a695a70af4b9@kernel.crashing.org>
In-Reply-To: <769ccd8091fc725571c5a695a70af4b9@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Segher Boessenkool wrote:
>> It seems that some versions of firmware will report a device
>> node status as the string "okay". As we are not expecting this
>> string, the device node will be ignored by the EEH subsystem.
>> Which means EEH will not be enabled.
>>
>> When EEH is not enabled, PCI errors will be converted into
>> Machine Check exceptions, and we'll have a very unhappy system.
> 
>> -	if (status && strcmp(status, "ok") != 0)
>> +	if (status && strncmp(status, "ok", 2) != 0)
>>  		return NULL;	/* ignore devices with bad status */
> 
> Shouldn't you check for the two literal strings, instead of
> only matching the common prefix?  Seems safer.

What are the chances that the status string is "oklahoma" or
"okeechobee" or "okinawa"?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
