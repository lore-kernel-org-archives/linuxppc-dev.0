Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw7t5665XzDt1m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:35:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, gkurz@linux.vnet.ibm.com
Subject: Re: [PATCH v3] cxl: Prevent adapter reset if an active context exists
In-Reply-To: <1476356908-302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1476356908-302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Fri, 14 Oct 2016 11:35:25 +1100
Message-ID: <878ttrepiq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> This patch prevents resetting the cxl adapter via sysfs in presence of
> one or more active cxl_context on it. This protects against an
> unrecoverable error caused by PSL owning a dirty cache line even after
> reset and host tries to touch the same cache line. In case a force reset
> of the card is required irrespective of any active contexts, the int
> value -1 can be stored in the 'reset' sysfs attribute of the card.

This is arguably a change to the ABI, but I assume we're OK with that as
it's arguably a bug in the existing implementation?

If so do we have a Fixes: ? and/or should this go to stable?

cheers
