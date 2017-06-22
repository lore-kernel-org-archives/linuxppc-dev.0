Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtSBz2QLSzDvdV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 13:44:59 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id s66so951554pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:44:59 -0700 (PDT)
Date: Thu, 22 Jun 2017 13:44:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/6] powerpc/64s: Blacklist functions invoked on a trap
Message-ID: <20170622134446.2daf569c@roar.ozlabs.ibm.com>
In-Reply-To: <0ddd4186e9044e5fa7079a6b5bb30aa885957142.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <0ddd4186e9044e5fa7079a6b5bb30aa885957142.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017 00:08:41 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Blacklist all functions involved while handling a trap. We:
> - convert some of the symbols into private symbols,
> - remove the duplicate 'restore' symbol, and
> - blacklist most functions involved while handling a trap.

I'm not sure removing "restore" makes it better. 
fast_exc_return_irq is a relatively specialised case...
I think all these names could be reworked and made a bit
more consistent and descriptive, but for this patch could
you just leave restore in there?

Otherwise it seems okay to me, but I haven't gone through
all the functions involved with trap yet and verified.

Thanks,
Nick
