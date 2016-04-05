Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfC6D2zL7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 12:12:04 +1000 (AEST)
Date: Tue, 5 Apr 2016 12:12:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] spapr: Don't set the TM ibm,pa-features bit in PR KVM mode
Message-ID: <20160405021201.GA2663@yogo.paulus.ozlabs.org>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160404210928.0d9ae644@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 04, 2016 at 09:09:28PM +1000, Anton Blanchard wrote:
> We don't support transactional memory in PR KVM, so don't tell
> the OS that we do.

This assumes PR KVM won't ever support TM, which is hopefully not
true.  If PR KVM does get TM support in future, then QEMU will have no
clear way to know whether it needs to clear the pa-features bit or
not.  I think we need to define some way for the KVM implementation to
tell qemu which of these kinds of CPU features it supports.

However, we could defer implementing that mechanism until PR KVM does
get support for TM, I guess.  In that case this patch could go in now,
though it seems slightly icky to be using the pvinfo stuff to
distinguish PR from HV.

Paul.
