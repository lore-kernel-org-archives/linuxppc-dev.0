Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93CD9DDF13
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:34:18 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l33GW4x5031756
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:32:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33GYF89199078
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 10:34:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33GYE9u030638
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 10:34:15 -0600
Date: Tue, 3 Apr 2007 11:34:14 -0500
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-ID: <20070403163414.GN4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Kristen,

Please queue these cleanup patches for 2.6.22.

This is a collection of very small, mostly trite, patches that clean up 
various bits and pieces of the RPAPHP hotplug code. They eliminate
almost 10% of the code, while making almost no funcional change. 
There are a few bugfixes to various error paths, and one memleak fix. 
Some documentation is added.  The result is, I beleive, slightly more 
readable, easier to understand code. In particular, the enable/disable 
add/remove code paths are now more obviously symmetrical in thier function.

--linas

p.s. some more simplifcation is possible: one could probably merge
__enable_slot() and rpaphp_enable_slot() with a bit of elbow grease,
and the asymmetric pairing of rpaphp_deregister_slot()  with
rpaphp_add_slot() as "opposites" of each other still bugs me.

I'm also irked that dlpar_pci_add_bus() is quite similar to 
pcibios_add_pci_devices() which is quite similar to init_phb_dynamic()
and think that these should be refactored so that they are more clearly
orthogonal to one another. Just right now, I'm not planning on doing 
anything about this, at least, not without prodding.

--linas 
