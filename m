Return-Path: <johnrose@austin.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3598679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 03:50:57 +1100 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2OGHjQL029840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 11:17:45 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2OGHOAS011801
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 11:17:24 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2OGKN1r191726
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 09:20:24 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2OGGKcQ027194
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 09:16:20 -0700
Subject: Re: pci_dlpar.c & probe mode
From: John Rose <johnrose@austin.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143160576.4257.51.camel@localhost.localdomain>
References: <1143160576.4257.51.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1143217005.2567.12.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Fri, 24 Mar 2006 10:16:45 -0600
Cc: External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I noticed that pcibios_add_pci_devices() test the platform type to
> decide wether to do a device-tree based probe or a direct PCI probe. Why
> can't it use ppc_md.probe_mode() like the rest of the PCI code does ?

I can't see a good reason either! :)  I'll have a patch in two shakes of
a lamb's tail.  

On a related note, I don't understand why devtree-based probe is only
desirable for the LPAR case (on pSeries).  

Also, do we anticipate future probe modes for new platforms or
something?  Adding such logic to ppc_md seems like mucho infrastructure
to answer a simple question (lpar or not).  For exmaple, _machine gets
used all over the pmac code.

John
