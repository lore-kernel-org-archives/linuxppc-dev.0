Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP3G81LZtzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:34:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: jallen@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 mdroth@linux.vnet.ibm.com, sahilmehta17@gmail.com
Subject: Re: [PATCH v7 2/4] powerpc/pseries: Revert 'Auto-online hotplugged
 memory'
In-Reply-To: <20170215184528.11755.568.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20170215184528.11755.568.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Thu, 16 Feb 2017 15:34:23 +1100
Message-ID: <87wpcqkb3k.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> Revert the patch patch to auto-online hotplugged memory, commit
> id ec999072442a. Using the auto-online acpability does online added
> memory but does not update the associated device struct to
> indicate that the memory is online. The result of this is that
> memoryXX/online file in sysfs still reports the memory as being offline.

Isn't that just a bug in the auto-online code?

If I'm reading it right it's calling online_memory_block(). If that
doesn't cause the memory_block to be online that would puzzle me.


Also commit ec999072442a went into v4.8, so is memory hotplug broken
since then? If so we need to backport this or whatever fix we come up.

cheers
