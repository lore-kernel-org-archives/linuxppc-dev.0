Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E0B9DDD05
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 10:53:28 +1000 (EST)
Subject: Re: [PATCH] generic check_legacy_ioport
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070423081540.GA28244@aepfle.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070423081540.GA28244@aepfle.de>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 10:53:20 +1000
Message-Id: <1177376000.14873.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-23 at 10:15 +0200, Olaf Hering wrote:
> check_legacy_ioport makes only sense on PREP, CHRP and pSeries.
> They may have an isa node with PS/2, parport, floppy and serial ports.
> Cell has IPMI, check for that too.
> 
> Remove the check_legacy_ioport call from ppc_md, its not needed anymore.
> Hardware capabilities come from the device-tree.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Ok, I like the aproach, but why the heck those ifdef's ? Can't you just
remove them ?

Also, doing ifdef on xxxx_MODULE is always BAD because that means the
module can't be built afterward.

> +	if (np) {
> +		of_node_put(np);
>  		return 0;

And also check now if the parent is "isa". Just to be sure. If a
platform won't match that, then it will need it's own
check_legacy_ioport which is fine with me.

To be totally correct, we should -also- check if the port number fits in
the the actual "reg" property but I'm not sure I can be bothered :-)
It's legacy stuff after all...

Cheers,
Ben.
