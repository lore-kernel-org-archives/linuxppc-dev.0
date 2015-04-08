Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6244E1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 16:57:23 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 8 Apr 2015 07:57:19 +0100
Message-ID: <5524D147.1080201@fr.ibm.com>
Date: Wed, 08 Apr 2015 08:57:11 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
 <20150407164439.GA4514@roeck-us.net> <55241C02.60103@fr.ibm.com>
 <20150407192212.GA6446@roeck-us.net>
In-Reply-To: <20150407192212.GA6446@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Guenter,

On 04/07/2015 09:22 PM, Guenter Roeck wrote:
> Hi Cedric,
> 
> On Tue, Apr 07, 2015 at 08:03:46PM +0200, Cedric Le Goater wrote:
>>
>> on a P7  :
>>
>> 	# ppc64_cpu --info
>> 	Core   0:    0*    1*    2*    3* 
>> 	Core   1:    4*    5*    6*    7* 
>> 	Core   2:    8*    9*   10*   11* 
>> 	Core   3:   12*   13*   14*   15* 
>> 	Core   4:   16*   17*   18*   19* 
>> 	Core   5:   20*   21*   22*   23* 
>>
> How would the 'sensors' output look like on that system ?
> Wouldn't it be something like the following ?
> 
>  	Core 0-7:    +29.0°C  
>  	Core 4-11:   +29.0°C  

yep. 

>>> Also, how do you know that the range of CPU IDs is always 8 ?
>>
>> This is a shortcut. The code is for the ibmpowernv platform and assumes 
>> that we are running on a P8 (8 hardware threads). It would be better to 
>> use a "maximum threads per core" variable but I am not sure this is 
>> available, as it is a tunable. I will look into it.
>>
> Tunable how ? 

You can switch on and off threads.

> The core code must have some means to detect this number when it initialized 
> CPU entries, or am I missing something ?

threads_per_core is what the code needs. v3 is on its way.

Thanks !

C.
