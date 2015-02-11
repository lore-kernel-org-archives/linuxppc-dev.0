Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E76AD1A019F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 16:03:03 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 22:03:01 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 41C653E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 22:02:59 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1B533V529884426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 22:03:03 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1B52wr1023807
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 22:02:59 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4] powerpc, powernv: Add OPAL platform event driver
In-Reply-To: <1423206522-18084-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1423206522-18084-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2015 16:02:22 +1100
Message-ID: <m31tlxniqp.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>	(1) Environmental and Power Warning (EPOW)
>	(2) Delayed Power Off (DPO)
> The user interface for this driver is /dev/opal_event character
> device file where the user space clients can poll and read for
> new opal platform events. The expected sequence of events driven
> from user space should be like the following.
>
> 	(1) Open the character device file
> 	(2) Poll on the file for POLLIN event
> 	(3) When unblocked, must attempt to read OPAL_PLAT_EVENT_MAX_SIZE size
> 	(4) Kernel driver will pass at most one opal_plat_event structure
> 	(5) Poll again for more new events

A few thoughts from discussing with Michael and Joel:
- not convinced that a chardev is the most ideal way to notify
  userspace. It seems like yet-another powerpc specific notification
  mechanism, which isn't ideal.
- netlink probably isn't right either (although maybe *sligthtly*
  better?)
- it seems that the "standard" way is ACPI, so I wonder if we could emit
  an ACPI event and essentially fake having ACPI... that would make all
  existing userspace "just work", right?
  Looking at acpi_bus_generate_netlink_event call in
  drivers/acpi/button.c it looks possible that we may be able to
  (relatively simply) do that?
- What do UPSs do? It would seem that some common "this is what's about
  to happen to your power" would almost *have* to exist somewhat
  generically?

I strongly advocate for anything that doesn't require custom userspace
that's OPAL/POWER specific (that we then have to get into distros etc etc)
