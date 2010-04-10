Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 483CEB7D18
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 18:53:26 +1000 (EST)
Subject: Re: A better way to sequence driver initialization?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <4BBF7E9C.80604@billgatliff.com>
References: <4BBF7E9C.80604@billgatliff.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 10 Apr 2010 18:53:17 +1000
Message-ID: <1270889597.6865.107.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-04-09 at 14:23 -0500, Bill Gatliff wrote:
> 
> My recent post, "Requesting a GPIO that hasn't been registered yet", and
> Anton's reply thereto (thanks, Anton!) on linuxppc-dev got me thinking
> about the problem of dependencies between devices in different  classes,
> and/or between drivers/devices in general.  I'd like to float an idea to
> see if it's worth pursuing. 

I'd rather do things a bit more explicitely and less prone to break
existing stuff... something along the lines of, first defining a variant
of the initcalls to enable that "multithreaded" stuff, along with an
explicit wait_for_service("subsys:hid"); for example.

One could also expose service deps via the module info, thus delaying
module init, or things like that (in fact, initcalls could even come
with a list of dependencies).

Cheers,
Ben.
