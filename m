Subject: Re: 405GPr PCI target/host
From: Adrian Cox <adrian@humboldt.co.uk>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION>
References: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION>
Content-Type: text/plain
Message-Id: <1092947874.10314.146.camel@localhost>
Mime-Version: 1.0
Date: Thu, 19 Aug 2004 21:37:54 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-08-19 at 19:28, Steven Blakeslee wrote:
> I am trying to get an IBM 405GPr processor to work as a target/host on a PCI
> bus.  A PCI target can temporarily become a host on the PCI bus. Basically
> this means it needs to do everything the host currently does except
> assigning PCI memory space, the dedicated host is responsible for this.

> [snip]

> I was wondering if anyone has done something like this, not necessarily with
> a 405, any processor experience will do.  I appreciate any help or advice.

I've written drivers for several systems of this form. Generally people
are trying to do one of the following:
1) Communicate between the PCI root (running Linux, Windows, or anything
else) and embedded Linux on a non-root processor. This requires a custom
driver, but is essentially straightforward. Eugene Surovegin has
described this elsewhere in the thread.
2) Communicate between embedded Linux on a non-root processor and custom
electronics on another non-root device. This also requires a
straightforward custom driver.
3) Use a standard Linux device driver running on a non-root processor to
control a standard PCI device elsewhere on the bus. This is usually
unsolvable without a custom motherboard to provide the required
interrupt routing. Most people give up and use a non-transparent PCI
bridge instead.

Does your requirement fit one of those?

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
