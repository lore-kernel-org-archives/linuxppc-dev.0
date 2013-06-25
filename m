Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 576B82C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 09:49:28 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 17:49:25 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EED45C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:49:19 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PNnKPn307542
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:49:20 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PNnKGG001435
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 20:49:20 -0300
Date: Wed, 26 Jun 2013 07:49:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] powerpc/eeh: Don't collect PCI-CFG data on PHB
Message-ID: <20130625234917.GA4556@shangw.(null)>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
 <1372161315.3944.201.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372161315.3944.201.camel@pasglop>
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

On Tue, Jun 25, 2013 at 09:55:15PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-06-25 at 18:00 +0800, Gavin Shan wrote:
>> +       /*
>> +        * When the PHB is fenced or dead, it's pointless to collect
>> +        * the data from PCI config space because it should return
>> +        * 0xFF's. For ER, we still retrieve the data from the PCI
>> +        * config space.
>> +        */
>> +       if (eeh_probe_mode_dev() &&
>> +           (pe->type & EEH_PE_PHB) &&
>> +           (pe->state & (EEH_PE_ISOLATED | EEH_PE_PHB_DEAD)))
>> +               valid_cfg_log = false;
>> +
>
>I'm still unsure about that one. EEH_PE_ISOLATED could be the result
>of a normal ER of PE#0 (which can happen for various reasons other
>than a fence) in which case the config space is available and
>interesting.
>

It's something like the followings. For ER on PE#0, we will have
PE with type of EEH_PE_BUS marked as isolated, instead of the
one with EEH_PE_PHB.


	[ EEH_PE_PHB] <---> [ EEH_PE_PHB] <---> [ EEH_PE_PHB]
				  |
			    [ EEH_PE_BUS ] PE#0
				  |
		        -------------------------
			|			|
		   [ EEH_PE_BUS ] PE#1	   [ EEH_PE_BUS] PE#2

>I would either not bother and collect the FF's, or make this specific
>to fence and only fence.
>

I'd like to keep it specific to fenced PHB and it's already be that :-)

Thanks,
Gavin
