Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CDA01A0EE2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 07:16:24 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Feb 2015 20:16:20 -0000
Message-ID: <54E795FA.1090005@fr.ibm.com>
Date: Fri, 20 Feb 2015 21:15:54 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
 <20150220165212.GE22752@roeck-us.net>
In-Reply-To: <20150220165212.GE22752@roeck-us.net>
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

On 02/20/2015 05:52 PM, Guenter Roeck wrote:
> On Fri, Feb 20, 2015 at 04:07:34PM +0100, Cédric Le Goater wrote:
>> Hello !
>>
>> These patches rework the ibmpowernv driver to support the new device 
>> tree as proposed by this patchset on the skiboot mailing list :
>>
>>   https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html
>>
>> They are based on Linux 3.19 and were tested on IBM Power and Open Power 
>> systems running trusty.
>>
>> The main issue is that the new device tree is incompatible with the 
>> previous ibmpowernv drivers. The consequence is no powernv sensors 
>> on systems with such a opal/linux configuration.
>>
> I don't think that would be acceptable. There must be lots of such
> systems out there. Why does it have to be incompatible ?
> Can't it support both the old and new versions ?

I should have provided more explanation in the Linux patchset. Sorry 
for that. Here is the rationale behind this brutal code change.

The initial ibmpowernv driver was designed in the early days of the
powernv platform and the device tree it is using to expose the sensors 
has some limitations that makes it difficult to add new ones. The current 
layout of the device tree is also tightly coupled to IBM Power systems 
and their service processor (FSP). Open Power systems are different and 
need a different solution.

It is to get more sensors out the P8 (and there are quite a few) that 
the OPAL patchset [1] proposes a new device tree. On the Linux side, it 
feels simpler to make a jump forward and break the compatibility than 
to maintain multiple branches of code just to keep alive an early v1 
of the ibmpowernv driver.    

Open Power systems won't be impacted as ibmpowernv does not support them.


Cheers,

C.


[1] https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html
