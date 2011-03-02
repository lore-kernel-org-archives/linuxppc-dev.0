Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1749B714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Mar 2011 16:48:00 +1100 (EST)
Subject: Re: Per process DSCR + somefixes (try#3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@au1.ibm.com>
In-Reply-To: <4D5B62F2.3020709@au1.ibm.com>
References: <4D5B62F2.3020709@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 16:47:48 +1100
Message-ID: <1299044868.8833.832.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-16 at 16:38 +1100, Alexey Kardashevskiy wrote:
> step1: http://patchwork.ozlabs.org/patch/71489/
> step2: http://patchwork.ozlabs.org/patch/81423/
> 
> In step2 I defined sysfs node as:
> 
> static SYSDEV_ATTR(dscr_default, 0600, show_dscr_default, 
> store_dscr_default);
> 
> and it caused problems with rhel6.
> Now it is:
> 
> static SYSDEV_CLASS_ATTR(dscr_default, 0600, show_dscr_default, 
> store_dscr_default);
> 
> It works now on both 2.6.32 and 2.6.36 but is that correct?

Ok, please resend with a proper changeset comment, something like that
would do:

<<
The DSCR (aka Data Stream Control Register) is supported on some
server PowerPC chips and allow some control over the prefetch
of data streams.

This patch allows the value to specified per thread by emulating
the corresponding mfspr and mtspr instructions. Children of such
threads inherit the value. Other threads use a default value that
can be specified in sysfs.
>>

And include your Signed-off-by: line.

BTW. I suppose it's an expected behaviour that thread created with a
given default value will keep that value even when the default is later
changed right ? And their descendents will use the same default as the
original thread, not the new default, at least that's how I read your
code :-) Maybe that should be documented somewhere...

Cheers,
Ben.
