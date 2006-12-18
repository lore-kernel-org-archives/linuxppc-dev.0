Return-Path: <tnt@246tNt.com>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.5.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D02B67C2B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 10:10:55 +1100 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBINAnBI027053
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 00:10:49 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45871F97.4010002@246tNt.com>
Date: Tue, 19 Dec 2006 00:09:11 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] powerpc: Add uevent handler for ibmebus
References: <1166481999359-git-send-email-tnt@246tNt.com>
	<11664820013460-git-send-email-tnt@246tNt.com>
	<11664820011861-git-send-email-tnt@246tNt.com>
	<200612190003.38713.arnd@arndb.de>
In-Reply-To: <200612190003.38713.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Devel <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 18 December 2006 23:46, Sylvain Munaut wrote:
>   
>> +       struct ibmebus_dev *ebus_dev;
>> +       struct of_device *of;
>> +
>> +       if (!dev)
>> +               return -ENODEV;
>> +
>> +       ebus_dev = to_ibmebus_dev(dev);
>> +       if (!ebus_dev)
>> +               return -ENODEV;
>> +
>> +       of = &ebus_dev->ofdev;
>>     
>
> This can be shortened to 
>
> 	of = to_of_device(dev);
>
> With that code in place, this function is identical to those
> for macio and of_platform_device, and you can collapse them
> all into of_device_uevent.
>
> 	Arnd <><
>   
Right, damn I missed that. Not too used to the whole "to_..." stuff.
I'll wait a little in case someone has other comments, and I'll resubmit
in a single patch (unless you really want me to separate in 4 patch, 2
of those
being one liners ...)


    Sylvain
