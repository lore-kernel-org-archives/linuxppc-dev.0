Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EC0EDDF3F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:45:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33GjmrM016942
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:45:48 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33GjeAD282920
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:45:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33GjdLR012568
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:45:39 -0400
Date: Tue, 3 Apr 2007 11:45:38 -0500
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 12/19] PCI: rpaphp: remove rpaphp_set_attention_status()
Message-ID: <20070403164538.GO4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403004446.C25AA3A65C@topology.austin.ibm.com>
	<20070403161938.GO8423@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403161938.GO8423@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, pcihpd-discuss@lists.sourceforge.net,
	Greg KH <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, kristen.c.accardi@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 11:19:38AM -0500, Nathan Lynch wrote:
> Linas Vepstas wrote:
> 
> You're changing the locking behavior here -- you've moved the
> rtas_set_indicator and the modification of
> hotplug_slot->info->attention_status outside of the code which holds
> rpaphp_sem.
> 
> P.S.  Should rpaphp_sem be changed to a mutex?

In patch 19, I remove the lock entirely. It doesn't seem to serve any
function that I could make out; it does not protect anything in the rpa
code, nor does it appear to be mandated by the hotplug code. Certainly,
none of the other hotplug drivers do this.  

--linas
