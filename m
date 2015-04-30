Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00F8C1A025F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 09:47:23 +1000 (AEST)
Message-ID: <1430437642.32679.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Fix possible leaked device node reference
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 01 May 2015 09:47:22 +1000
In-Reply-To: <5542A589.9010703@linux.vnet.ibm.com>
References: <5541891A.6040506@linux.vnet.ibm.com>
 <5542A589.9010703@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-30 at 14:58 -0700, Tyrel Datwyler wrote:
> On 04/29/2015 06:44 PM, Nathan Fontenot wrote:
> > Failure return from dlpar_configure_connector when dlpar adding cpus
> > results in leaking references to the cpus parent device node. Move the
> > call to of_node_put() prior to checking the result of
> > dlpar_configure_connector.
> > 
> > Fixes: 8d5ff320766f ("powerpc/pseries: Make dlpar_configure_connector parent node aware")
> 
> That commit went into 3.12. Shouldn't this be CC to stable?

It could, but it fails the "real bug" test:

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

(from Documentation/stable_kernel_rules.txt)

Because the node we're leaking a reference on is /cpus, and in practice that's
pretty harmless.

cheers
