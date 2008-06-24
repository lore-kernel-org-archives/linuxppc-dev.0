Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9D3CDE037
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 09:13:46 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m5ONDfxA001522
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 16:13:41 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5ONDeij000234
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 18:13:40 -0500 (CDT)
Message-ID: <48617FA4.7070603@freescale.com>
Date: Tue, 24 Jun 2008 18:13:40 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Do we still need devtree_lock?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to write a function that gets a list of all aliases

	aliases {
		serial0 = &serial0;
		serial1 = &serial1;
		pci0 = &pci0;
		pci1 = &pci1;
		pci2 = &pci2;
	};

That is, I do not know which aliases are in the /aliases node, so I need a
function that works somewhat like of_find_property(), but just returns the Nth
property instead of doing a strcmp.

I can't seem to find one, so I probably need to write one.  However, I noticed
that of_find_property() uses a lock:

	read_lock(&devtree_lock);
	for (pp = np->properties; pp != 0; pp = pp->next) {
		if (of_prop_cmp(pp->name, name) == 0) {
			if (lenp != 0)
				*lenp = pp->length;
			break;
		}
	}
	read_unlock(&devtree_lock);

But the comment for devtree_lock says this:

extern rwlock_t devtree_lock;	/* temporary while merging */

Since arch/ppc is going away, does this meant that the lock can go away do?

-- 
Timur Tabi
Linux kernel developer at Freescale
