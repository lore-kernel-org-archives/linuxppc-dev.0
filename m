Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6EFF42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 14:26:26 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 13 Jun 2013 00:26:22 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id F09EC38C801A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 00:26:18 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D4QJ7J304916
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 00:26:19 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5D4QJFE015047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 01:26:19 -0300
Date: Thu, 13 Jun 2013 12:26:15 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/27] powerpc/eeh: I/O chip EEH state retrieval
Message-ID: <20130613042615.GA4045@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-16-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936224.8250.93.camel@pasglop>
 <20130612033203.GA10000@shangw.(null)>
 <1371010765.8250.173.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371010765.8250.173.camel@pasglop>
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

On Wed, Jun 12, 2013 at 02:19:25PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-12 at 11:32 +0800, Gavin Shan wrote:
>
>> >Same comments about "state" which is really "delay" and is probably
>> >not necessary at all ...
>> >
>> 
>> We need the "delay" in future to support PowerKVM guest. If the
>> specified PE is being reset, we rely on the delay to hold the
>> powerkvm guest for a while until the PE reset is done.
>
>Do we ? Can't we just rely on "temp unavailble" result and wait 1s when
>that happens (then try again) ?
>
>IE, A delay associated with a state doesn't make that much sense
>semantically speaking. With a state *transition* maybe but this isn't
>what this function is about...
>

Sorry, Ben. I should have clarified more clearly: Basically, the EEH
core is going to be shared by: powernv, pseries on top of powernv or
phyp. While running pseries on top of phyp, we're getting PE state
through RTAS call "ibm,read-slot-reset-state2" and desired delay returned
from f/w for temporary unavailable PE. In the future, the function
ioda_eeh_get_state() will be called directly to emulate the RTAS call
for guest running on top of PowerNV.

So the answer is we can do it by makeing the assumption that f/w won't
return valid delay and we're going to use default value (1 second) for
guest on powernv or phyp, or we keep the delay here.

Thanks,
Gavin
