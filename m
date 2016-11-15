Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ2MY5Jn4zDsxW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:36:25 +1100 (AEDT)
Message-ID: <1479202544.2608.56.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 11/11] powerpc: rewrite local_t using soft_irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 anton@samba.org, npiggin@gmail.com
Date: Tue, 15 Nov 2016 20:35:44 +1100
In-Reply-To: <20161115080644.GA23527@visitor2.iram.es>
References: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1479146692-15726-12-git-send-email-maddy@linux.vnet.ibm.com>
 <20161115080644.GA23527@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-15 at 09:06 +0100, Gabriel Paubert wrote:
> 
> I'm really wondering whether this is the kind of thing that would
> benefit from transactions. But transactional memory was only implemented
> on Power7 and later IIRC, and we still need to support machines without
> transactional memory. 

Power8 and later.

Also this is about *local* atomics not general atomics, so the overhead
of starting a transaction in that case is way way higher than the
proposed implementation.

Cheers,
Ben.
