Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61D542C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 14:21:35 +1000 (EST)
Message-ID: <1371010765.8250.173.camel@pasglop>
Subject: Re: [PATCH 15/27] powerpc/eeh: I/O chip EEH state retrieval
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 12 Jun 2013 14:19:25 +1000
In-Reply-To: <20130612033203.GA10000@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-16-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936224.8250.93.camel@pasglop> <20130612033203.GA10000@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-12 at 11:32 +0800, Gavin Shan wrote:

> >Same comments about "state" which is really "delay" and is probably
> >not necessary at all ...
> >
> 
> We need the "delay" in future to support PowerKVM guest. If the
> specified PE is being reset, we rely on the delay to hold the
> powerkvm guest for a while until the PE reset is done.

Do we ? Can't we just rely on "temp unavailble" result and wait 1s when
that happens (then try again) ?

IE, A delay associated with a state doesn't make that much sense
semantically speaking. With a state *transition* maybe but this isn't
what this function is about...

Cheers,
Ben.
