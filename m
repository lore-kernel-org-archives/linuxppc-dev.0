Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 971DB2C00D9
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2013 05:04:06 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 19 Mar 2013 14:04:04 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B3608C9002A
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:03:59 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2JI3wNO253458
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:03:58 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2JI3rg0027428
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 12:03:54 -0600
Message-ID: <5148A886.5080109@linux.vnet.ibm.com>
Date: Tue, 19 Mar 2013 13:03:50 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/11] Add platform_has_feature()
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB457.9000409@linux.vnet.ibm.com>
 <20130314085616.GD9841@iris.ozlabs.ibm.com>
In-Reply-To: <20130314085616.GD9841@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2013 03:56 AM, Paul Mackerras wrote:
> On Fri, Mar 08, 2013 at 10:02:31PM -0600, Nathan Fontenot wrote:
>> The firmware_has_feature() function makes it easy to check for supported
>> features of the hardware. There is not corresponding function to check for
>> features supported by the client architecture.
> 
> Actually, firmware_has_feature checks for supported features of the
> hypervisor, or in a sense the platform, rather than hardware.

Ahh, thanks for clarifying that for me. I'll update the description.

> 
>> This patch adds a platform_has_feature() function to check features selected
>> by firmware and reported via the device tree 'ibm,architecture-vec5'
>> property. As part of this the #defines used for the architecture vector are
>> moved to prom.h and re-defined such that the vector 5 options have the vector
>> index and the feature bits encoded into them. This allows for callers of
>> platform_has_feature() to pass in a single pre-defined value.
> 
> One other comment below...
> 
>>  /* PCIe/MSI support.  Without MSI full PCIe is not supported */
>>  #ifdef CONFIG_PCI_MSI
>> -#define OV5_MSI			0x01	/* PCIe/MSI support */
>> +#define OV5_MSI			0x0201	/* PCIe/MSI support */
>>  #else
>> -#define OV5_MSI			0x00
>> +#define OV5_MSI			0x0200
>>  #endif /* CONFIG_PCI_MSI */
> 
> The #ifdef was done this way in order to control what ended up in the
> option vector we pass to the platform firmware.  For checking what the
> platform supports, wouldn't we want OV5_MSI to be 0x0201 always?
> Similarly for OV5_CMO, OV5_XCMO, etc.?

Yes, you're correct. I will update this.

-- 
-Nathan
