Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFA282C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 09:51:21 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 17:51:19 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7B6F16E8028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:51:13 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PNocaw341610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:50:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PNocpX003871
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:50:38 -0300
Date: Wed, 26 Jun 2013 07:50:34 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] powerpc/eeh: Don't collect PCI-CFG data on PHB
Message-ID: <20130625235034.GB4556@shangw.(null)>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
 <1372161366.3944.202.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372161366.3944.202.camel@pasglop>
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

On Tue, Jun 25, 2013 at 09:56:06PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-06-25 at 18:00 +0800, Gavin Shan wrote:
>> +               pci_regs_buf[0] = 0;
>> +               eeh_pe_for_each_dev(pe, edev) {
>> +                       loglen += eeh_gather_pci_data(edev, pci_regs_buf,
>> +                                                     EEH_PCI_REGS_LOG_LEN);
>> +               }
>> +       }
>
>Unless I'm mistaken, this is buggy and will overwrite the content of
>pci_regs_buf for every device (they will all write over the same
>portion of the log).
>

No, you're right. I'm going to fix it in next revision :-)

Thanks,
Gavin
