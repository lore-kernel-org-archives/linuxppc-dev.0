Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D91D51A0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 01:04:31 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 30 Apr 2015 20:34:28 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 95238125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 20:36:29 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3UF4Qrv52953264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 20:34:26 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3UF4P0A003167
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 20:34:26 +0530
Message-ID: <55424477.6070005@linux.vnet.ibm.com>
Date: Thu, 30 Apr 2015 20:34:23 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/3] leds/powernv: Add driver for PowerNV platform
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
 <20150428101008.26912.38735.stgit@localhost.localdomain>
 <5316346.zPr516JNgQ@wuerfel>
In-Reply-To: <5316346.zPr516JNgQ@wuerfel>
Content-Type: text/plain; charset=windows-1252
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2015 03:48 PM, Arnd Bergmann wrote:
> On Tuesday 28 April 2015 15:40:35 Vasant Hegde wrote:
>> +++ b/Documentation/devicetree/bindings/leds/leds-powernv.txt
>> @@ -0,0 +1,29 @@
>> +Device Tree binding for LEDs on IBM Power Systems
>> +-------------------------------------------------
>> +
>> +The 'led' node under '/ibm,opal' lists service indicators available in the
>> +system and their capabilities.
>> +
>> +led {
>> +       compatible = "ibm,opal-v3-led";
>> +       phandle = <0x1000006b>;
>> +       linux,phandle = <0x1000006b>;
>> +       led-mode = "lightpath";
>> +
>> +       U78C9.001.RST0027-P1-C1 {
>> +               led-types = "identify", "fault";
>> +               led-loc = "descendent";
>> +               phandle = <0x1000006f>;
>> +               linux,phandle = <0x1000006f>;
>> +       };
>> +       ...
>> +       ...
>> +};

Arnd,

  Thanks for the review.

> 
> We normally don't list the 'phandle' or 'linux,phandle' properties in the binding
> description.
> 

Sure. .Will fix.


>> +
>> +Each node under 'led' node describes location code of FRU/Enclosure.
>> +
>> +The properties under each node:
>> +
>> +  led-types : Supported LED types (attention/identify/fault).
>> +
>> +  led-loc   : enclosure/descendent(FRU) location code.
>>
> 
> Could you use the standard 'label' property for this?

This was discussed earlier [1] and agreed to use led-types property here..

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/126301.html

-Vasant
