Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F10EFB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 18:57:36 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add Initiate Coprocessor Store Word (icswx)
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110503165520.67eab924@kryten>
References: <20110503164304.7690a1b7@kryten>
	<1304405237.2513.304.camel@pasglop>  <20110503165520.67eab924@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 May 2011 18:57:27 +1000
Message-ID: <1304413047.2513.305.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-03 at 16:55 +1000, Anton Blanchard wrote:
> Hi Ben,
> 
> > My only comment (sorry Anton :-) would have been that we could lazily
> > allocate the spinlock on the first use_cop() ... or do we have that
> > potentially called in the wrong context ?
> 
> I worry what might happen in a threaded app. It would be a strange
> thing to do, but the program may call use_cop from two threads at the
> same time. In that case you could corrupt the PID/ACOP values
> and leak a spinlock of memory I think.

OK, it's a bit nasty to solve. I'll put the latest patch in my queue and
if all goes well, it should hit next by the end of the week.

Cheers,
Ben.
