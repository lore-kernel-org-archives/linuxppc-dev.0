Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BAAA2C0364
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 18:50:23 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 02:50:08 -0600
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 48D62C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 04:50:05 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J8mvEq39977008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 04:48:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J8mu6r014127
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 05:48:56 -0300
Date: Wed, 19 Jun 2013 16:48:52 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/31] powerpc/eeh: Trace PCI bus from PE
Message-ID: <20130619084852.GA11210@shangw.(null)>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371544435-4943-6-git-send-email-shangw@linux.vnet.ibm.com>
 <51C15BE3.70906@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51C15BE3.70906@linux.vnet.ibm.com>
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

On Wed, Jun 19, 2013 at 03:21:07PM +0800, Mike Qiu wrote:

.../...

>>+		/*
>>+		 * For PCI bus sensitive PE, we can reset the parent
>>+		 * bridge in order for hot-reset. However, the PCI
>>+		 * devices including the associated EEH devices might
>>+		 * be removed when EEH core is doing recovery. So that
>>+		 * won't safe to retrieve the bridge through downstream
>>+		 * EEH device. We have to trace the parent PCI bus, then
>>+		 * the parent bridge explicitly.
>>+		 */
>>+		if (eeh_probe_mode_dev() && !pe->bus) {
>>+			first_edev = list_first_entry(&pe->edevs,
>>+						      struct eeh_dev, list);
>>+			pe->bus = eeh_dev_to_pci_dev(first_edev)->bus;
>>+		}
>Hi Gavin
>
>I have qestion, can we keep pe->bus for a device pe ? the value is
>the bus which edev belongs to.
>
>so that we can make the code more efficient for device pe.
>
>I have no idea of whether this will cause side effect
>

Thanks, Mike. Good catch actually, it won't have side-effect and
possiblly avoid problems during hot-plug: For PCI bus with only
child PCI device, we won't return the PCI bus (without fix) and
the EEH core doesn't do hot-plug on the affected PCI bus then. 

I'm testing on the updated patch and will send that out soon if it
works well.

Thanks,
Gavin
