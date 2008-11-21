Return-Path: <dave@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9656DDDD4
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 10:50:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mALNkXk2001212
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:46:33 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mALNohHR151608
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:50:43 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mALNohqT008435
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:50:43 -0500
Subject: Nodes with no memory
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 15:50:41 -0800
Message-Id: <1227311441.11607.57.camel@nimitz>
Mime-Version: 1.0
Cc: mjw <mjw@linux.vnet.ibm.com>, Nathan Lynch <nathanl@austin.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was handed off a bug report about a blade not booting with a, um
"newer" kernel.  After turning on some debugging messages, I got this
ominous message:

        node 1
        NODE_DATA() = c000000000000000

Which obviously comes from here:

arch/powerpc/mm/numa.c

        for_each_online_node(nid) {
                unsigned long start_pfn, end_pfn;
                unsigned long bootmem_paddr;
                unsigned long bootmap_pages;

                get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);

                /* Allocate the node structure node local if possible */
                NODE_DATA(nid) = careful_allocation(nid,
                                        sizeof(struct pglist_data),
                                        SMP_CACHE_BYTES, end_pfn);
                NODE_DATA(nid) = __va(NODE_DATA(nid));
                memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
		...

careful_allocation() returns a NULL physical address, but we go ahead
and run __va() on it, stick it in NODE_DATA(), and memset it.  Yay!

I seem to recall that we fixed some issues with memoryless nodes a few
years ago, like around the memory hotplug days, but I don't see the
patches anywhere.

I'm thinking that we need to at least fix careful_allocation() to oops
and not return NULL, or check to make sure all it callers check its
return code.  Plus,  we probably also need to ensure that all ppc code
doing for_each_online_node() does not assume a valid NODE_DATA() for all
those nodes.

Any other thoughts?

I'll have a patch for the above issue sometime soon. 

-- Dave
