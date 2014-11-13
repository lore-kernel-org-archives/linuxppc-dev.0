Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C1CE1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 23:41:05 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9DAC41400AB
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 23:41:03 +1100 (AEDT)
Message-ID: <1415882455.666.4.camel@kernel.crashing.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 13 Nov 2014 23:40:55 +1100
In-Reply-To: <1415876169.666.2.camel@kernel.crashing.org>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
 <20141113075817.GA1288@katana> <1415876169.666.2.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 21:56 +1100, Benjamin Herrenschmidt wrote:
> 
> No, there is no timeout, if that fails something went quite wrong, it
> could almost be a BUG_ON (basically we passed a wrong token or a NULL
> msg).
> 
> > > +   }
> > > +
> > > +   rc = be64_to_cpu(msg.params[1]);
> > > +   if (rc != OPAL_SUCCESS) {
> > > +           rc = -EIO;
> > > +           goto exit;
> > > +   }
> > > +

Actually, to correct myself, there are a number of error conditions
including timeouts inside the FW layer, but they are returned here, not
from opal_async_wait_response(). So indeed, we could do some error code
conversion at that point.

Neelesh, can you do that on top of your patch that adds the detailed
error codes ? We can merge it fw side tomorrow if you have a new spin,
worst case if the FW is old and only returns OPAL_HARDWARE we return
-EIO and if the FW is newer we'll have more precise error codes in Linux
too.

Cheers,
Ben.
