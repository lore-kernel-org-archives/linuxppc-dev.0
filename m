Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85F76DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 19:14:49 +1000 (EST)
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <17854.1186045405@neuling.org>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186004885.22717.50.camel@farscape.rchland.ibm.com>
	<24613.1186034191@neuling.org>
	<1186039870.5495.595.camel@localhost.localdomain>
	<13166.1186045008@neuling.org>
	<1186045096.5495.617.camel@localhost.localdomain>
	<17854.1186045405@neuling.org>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 19:14:39 +1000
Message-Id: <1186046080.5495.620.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, will_schmidt@vnet.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-02 at 19:03 +1000, Michael Neuling wrote:
> > 
> > Ok, that was missing from your description :-)
> 
> Sorry... so ditch the barriers? 

As you like. The reason why you can ditch them is purely because you
know for sure that the only case the firmware will access those shadows
from another CPU is that one and it happens to be just right. What are
the chances that in the future, FW will do something different and
nobody will "fix" the code ?

Considering that eieios are fairly cheap and it's not a very hot code
path as far as I can tell, I'd rather keep them.

Cheers,
Ben.
