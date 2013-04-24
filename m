Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 685592C011B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:29:40 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 21:29:38 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5947D6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:29:33 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O1TZ7e335360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:29:36 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O1TZnm032281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:29:35 -0600
Date: Wed, 24 Apr 2013 09:29:32 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/powernv: Supports PHB3
Message-ID: <20130424012932.GA6527@shangw.(null)>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366715034-24594-2-git-send-email-shangw@linux.vnet.ibm.com>
 <1366730340.12131.3.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366730340.12131.3.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 24, 2013 at 01:19:00AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-04-23 at 19:03 +0800, Gavin Shan wrote:
>> -/* Fixup wrong class code in p7ioc root complex */
>> +/* Fixup wrong class code in p7ioc and p8 root complex */
>>  static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
>>  {
>>         dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>  }
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x2da, pnv_p7ioc_rc_quirk);
>>  
>This can go away from the normal patch, it is only necessary to work
>around a problem in the simulator. The real PHB3 doesn't need the
>workaround (p7ioc still does).
>

Ok. I'll remove it in next version ;-)

Thanks,
Gavin
