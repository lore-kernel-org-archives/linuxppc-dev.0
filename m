Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCBD72C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 10:12:45 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 20:12:42 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 425A0C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:12:40 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q0CejN298722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:12:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q0CcEp022041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:12:40 -0400
Date: Wed, 26 Jun 2013 08:12:34 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] powerpc/eeh: Don't collect PCI-CFG data on PHB
Message-ID: <20130626001234.GA6232@shangw.(null)>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
 <1372161315.3944.201.camel@pasglop>
 <20130625234917.GA4556@shangw.(null)>
 <1372204646.3944.223.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372204646.3944.223.camel@pasglop>
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

On Wed, Jun 26, 2013 at 09:57:26AM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-26 at 07:49 +0800, Gavin Shan wrote:
>> It's something like the followings. For ER on PE#0, we will have
>> PE with type of EEH_PE_BUS marked as isolated, instead of the
>> one with EEH_PE_PHB.
>> 
>> 
>>         [ EEH_PE_PHB] <---> [ EEH_PE_PHB] <---> [ EEH_PE_PHB]
>>                                   |
>>                             [ EEH_PE_BUS ] PE#0
>>                                   |
>
>So we actually have two PEs here ? One real (PE#0) and one imaginary
>(PHB PE) with no PE# associated ?
>

Yes, The (PHB PE) is actually a container to all PEs under the
PHB ;-)

>>                         -------------------------
>>                         |                       |
>>                    [ EEH_PE_BUS ] PE#1     [ EEH_PE_BUS] PE#2
>> 
>> >I would either not bother and collect the FF's, or make this specific
>> >to fence and only fence.
>> >
>> 
>> I'd like to keep it specific to fenced PHB and it's already be
>> that :-)

Thanks,
Gavin
