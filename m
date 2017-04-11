Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2N8n6LPpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:10:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] powerpc/pseries: do not use msgsndp doorbells on
 POWER9 guests
In-Reply-To: <20170407125602.31146-2-npiggin@gmail.com>
References: <20170407125602.31146-1-npiggin@gmail.com>
 <20170407125602.31146-2-npiggin@gmail.com>
Date: Tue, 11 Apr 2017 20:10:17 +1000
Message-ID: <87vaqbuueu.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> POWER9 hypervisors will not necessarily run guest threads together on
> the same core at the same time, so msgsndp should not be used.

I'm worried this is encoding the behaviour of a particular hypervisor in
the guest kernel.

If we *can't* use msgsndp then the hypervisor better do something to
stop us from using it.

If it would be preferable for us not to use msgsndp, then the hypervisor
can tell us that somehow, eg. in the device tree.

?

cheers
