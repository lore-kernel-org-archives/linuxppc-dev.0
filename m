Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3EC862C0309
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 17:48:07 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 01:48:04 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EFE6D19D8036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:47:51 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P7m1Ho387444
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:48:01 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P7lxGk013507
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:48:00 -0600
Date: Tue, 25 Jun 2013 15:47:55 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] powerpc/eeh: Check PCIe link after reset
Message-ID: <20130625074755.GA8486@shangw.(null)>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1372140384.3944.189.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372140384.3944.189.camel@pasglop>
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

On Tue, Jun 25, 2013 at 04:06:24PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-06-25 at 13:55 +0800, Gavin Shan wrote:
>>         * don't touch the other command bits
>>          */
>> -       eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
>> -       if (edev->config_space[1] & PCI_COMMAND_PARITY)
>> -               cmd |= PCI_COMMAND_PARITY;
>> -       else
>> -               cmd &= ~PCI_COMMAND_PARITY;
>> -       if (edev->config_space[1] & PCI_COMMAND_SERR)
>> -               cmd |= PCI_COMMAND_SERR;
>> -       else
>> -               cmd &= ~PCI_COMMAND_SERR;
>> -       eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
>> +       if (pdev) {
>> +               eeh_ops->write_config(dn, PCI_COMMAND, 4,
>> +                                     edev->config_space[1]);
>> +       } else {
>
>That needs a much better comment. Why are you doing that instead
>of what's below ? In fact there is more to restore in a bridge
>right ? (windows etc...). Do you do that ? Should we just have a
>different function to restore a device vs. a bridge ?
>

Yeah, We should have one separate function to do that for bridge.
I'll do that in next revision.

>I also don't see a need to do thing differently between phyp and
>powernv. Bridges inside partitions would suffer the same fate in
>both cases.
>

If we just have complete reset for fenced PHB, we need restore it
from the cache (edev->config_space[1]) instead of reading that from
hardware. Fenced PHB is the special case on PowerNV :-)

Thanks,
Gavin
