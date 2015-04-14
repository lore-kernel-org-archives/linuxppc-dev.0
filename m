Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DD31A0C47
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:41:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 15:41:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5E17C2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:41:21 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E5fCRa22413476
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:41:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E5el1a024837
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:40:47 +1000
Message-ID: <552CA84E.50705@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 11:10:30 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: cooloney@gmail.com, rpurdie@rpsys.net
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <1427260873.6468.68.camel@kernel.crashing.org>
In-Reply-To: <1427260873.6468.68.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2015 10:51 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2015-03-20 at 16:34 +0530, Vasant Hegde wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> This patch implements LED driver for PowerNV platform using the existing
>> generic LED class framework. It registers classdev structures for all
>> individual LEDs detected on the system through LED specific device tree
>> nodes. Device tree nodes specify what all kind of LEDs present on the
>> same location code. It registers LED classdev structure for each of them.
>>
>> The platform level implementation of LED get and set state has been
>> achieved through OPAL calls. These calls are made available for the
>> driver by exporting from architecture specific codes.
>>
>> As per the LED class framework, the 'brightness_set' function should not
>> sleep. Hence these functions have been implemented through global work
>> queue tasks which might sleep on OPAL async call completion.
>>
>> All the system LEDs can be found in the same regular path /sys/class/leds/.
>> There are two different kind of LEDs present for the same location code,
>> one being the identify indicator and other one being the fault indicator.
>> We don't use LED colors. Hence our LEDs have names in this format.
>>
>>         <location_code>:<ATTENTION|IDENTIFY|FAULT>
>>
>> Any positive brightness value would turn on the LED and a zero value
>> would turn off the LED. The driver will return LED_FULL (255) for any
>> turned on LED and LED_OFF for any turned off LED.
> 

Bryan, Richard,

  Did you get a chance to review this patchset?

-Vasant

> Any comment from the LEDs folks ? I am not too familiar with the LED
> subsystem so I would appreciate at least a cursory review of the high
> level design :-)
