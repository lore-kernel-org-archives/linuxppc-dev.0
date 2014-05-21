Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DDCA1A007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 10:12:23 +1000 (EST)
Message-ID: <1400631131.3986.144.camel@pasglop>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 21 May 2014 10:12:11 +1000
In-Reply-To: <20140520115606.GB20397@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-20 at 21:56 +1000, Gavin Shan wrote:

 .../...

> >I think what you want is an irqfd that the in-kernel eeh code
> >notifies when it sees a failure. When such an fd exists, the kernel
> >skips its own error handling.
> >
> 
> Yeah, it's a good idea and something for me to improve in phase II. We
> can discuss for more later. For now, what I have in my head is something
> like this:

However, this would be a deviation from (or extension of) PAPR. At the
moment, the way things work in PAPR is that the guest is responsible for
querying the EEH state when something "looks" like an error (ie, getting
ff's back). This is also how it works in pHyp.

We have an interrupt path in the host when doing "native" EEH, and it
would be nice to extend PAPR to also be able to shoot an event to the
guest possibly using RTAS events, but let's get the basics working and
upstream first.

Cheers,
Ben.
