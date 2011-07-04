Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6206BB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 23:57:15 +1000 (EST)
Subject: Re: hvc_console change results in corrupt oops output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110704205738.742e56d0@kryten>
References: <20110704205738.742e56d0@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jul 2011 23:56:27 +1000
Message-ID: <1309787787.14501.268.camel@pasglop>
Mime-Version: 1.0
Cc: borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-07-04 at 20:57 +1000, Anton Blanchard wrote:

 .../...

> The hypervisor gives us a busy return, so we could retry a number of
> times instead of dropping it on the floor. We'd need to do it in the
> hvc_console driver - the tty drivers share the same backend
> functions so we can't hide it in the pseries put_chars function.

For kernel console, I don't see why not wait forever ... If the
underlying backend really lost the connection it can always return a
negative error no ?

Or we could have "well defined" return codes for "wait forever" vs.
"drop this" ... maybe return -EAGAIN.

Cheers,
Ben.
