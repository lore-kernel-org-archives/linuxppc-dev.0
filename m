Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 060862C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 13:33:31 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 11 Jun 2013 21:33:29 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3D4EF1FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 21:28:13 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C3XPjh234176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 21:33:25 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5C3XPAg006114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 21:33:25 -0600
Date: Wed, 12 Jun 2013 11:33:22 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 17/27] powerpc/eeh: I/O chip PE log and bridge setup
Message-ID: <20130612033322.GB10000@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-18-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936279.8250.94.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370936279.8250.94.camel@pasglop>
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

On Tue, Jun 11, 2013 at 05:37:59PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
>> The patch adds backends to retrieve error log and configure p2p
>> bridges for the indicated PE.
>> 
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>
>> +/**
>> + * ioda_eeh_configure_bridge - Configure the PCI bridges for the indicated PE
>> + * @pe: EEH PE
>> + *
>> + * For particular PE, it might have included PCI bridges. In order
>> + * to make the PE work properly, those PCI bridges should be configured
>> + * correctly. However, we need do nothing on P7IOC since the reset
>> + * function will do everything that should be covered by the function.
>> + */
>> +static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
>> +{
>> +	return 0;
>
>Does it now ?
>
>IE. Who reconfigures the windows and other config space bits of P2P
>bridges ? Or is this handled elsewhere in Linux or in the upper levels
>of EEH ? Or is that only needed for the PHB ?
>

The EEH core already coverred it, so we needn't do anything here.
If we're going to reset the PHB, firmware will re-initialize the
PHB and the left will be coverred by EEH core.

Thanks,
Gavin
