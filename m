Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A90A8DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 07:30:01 +1000 (EST)
Message-ID: <4817934A.3050805@freescale.com>
Date: Tue, 29 Apr 2008 16:29:46 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 4/6] [POWERPC] QE: implement support for the GPIO LIB API
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<4817850C.20201@freescale.com> <20080429212304.GA8103@zarina>
In-Reply-To: <20080429212304.GA8103@zarina>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Well, I'm indeed removing [further] support for the par_io nodes,
> overwriting it with gpio nodes. That way we'll stop new use cases of
> these nodes.

I have no problem with replacing par_io nodes with gpio nodes.

> Eventually I plan to adjust the existing code/device trees accordingly.
> If you think that code should be adjusted at the same time as
> documentation, I'm fine with it as well. I'll just add new documentation
> instead of replacing the old.

Yes, please.

>> You can't just delete the par_io documentation without updating the code and
>> planning for feature removal.  Almost all of the existing code out there for QE
>> boards expects a par_io node, and the device trees still have them.
> 
> Yup, exactly. Old device tree still use them, but don't we want to get
> rid of this? If so, we should remove documentation, or someone will
> use it for the new device trees. ;-)

It should still be documented, but marked as deprecated.  The documentation can
be removed only when all the DTS files *and* the code are scrubbed of those
kinds of nodes.  And you can't remove backwards compatibility for those from the
code until at least the next major revision of the kernel.

Look at function of_get_mac_address() for an example.  "mac-address" was removed
mid last year, but we still support them.  Try to isolate the code that support
the newer gpio nodes and the  older par_io nodes into one function, and it'll be
easier to deal with.

-- 
Timur Tabi
Linux kernel developer at Freescale
