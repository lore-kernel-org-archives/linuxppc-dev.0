Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0279DDF4D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:48:58 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33GmpdO032675
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:48:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33Gmpit102070
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:48:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33GmoKF016355
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:48:51 -0400
Date: Tue, 3 Apr 2007 11:48:50 -0500
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-ID: <20070403164850.GP4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403163414.GN4922@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403163414.GN4922@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	pcihpd-discuss@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Resend, I flubbed the cc list.)

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
