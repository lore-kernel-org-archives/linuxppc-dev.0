Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92C52B7047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 15:50:31 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Apr 2012 05:47:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3P5oS2033882358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 15:50:28 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3P5oPvT011460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 15:50:27 +1000
Date: Wed, 25 Apr 2012 13:50:11 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.4-rc3 compile failed on IBM Power6
Message-ID: <20120425055011.GA978@shangw>
References: <CAPxxNQmfkJLPHq0BvzxOnLFO-e0FRmaF1VqLhP-jMqF-ziM2tA@mail.gmail.com>
 <20120425005432.GA14663@linux.vnet.ibm.com>
 <20120425015044.GA4637@shangw> <1335327042.21961.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335327042.21961.27.camel@pasglop>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ryan Wang <openspace.wang@gmail.com>,
 linux-kernel@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> In order to make iommu.c irrelative to CONFIG_EEH, we might figure out
>> the PE number of the PCI device during PCI probe time. Here're some
>> rough thoughts about the rework.
>> 
>>         - Introduce additional field "int pe_num" to "struct dev_archdata".
>>           That would be traced like: (struct pci_dev)->(struct device dev)
>>           ->(struct dev_archdata archdata).
>>         - During the PCI probe time (maybe pci_fixup_early), we can figure
>>           out the PE number.
>> 
>> Then we can retrieve the PE number of PCI device from "int pe_num" and needn't
>> care CONFIG_EEH has been turned on or off. I'm not sure Ben has any comments
>> on the idea? 
>
>Just select EEH from pseries Kconfig, no point in keeping that a user visible option.
>

Thanks for the suggestion, Ben :-)

I've sent one trivial patch against it.

>Cheers,
>Ben.
>
>

Thanks,
Gavin
