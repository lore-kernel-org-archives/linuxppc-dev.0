Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B465267CE6
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 07:57:57 +1000 (EST)
Subject: Re: vsdo_datapage.h WTF?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1160233817.4795.85.camel@pmac.infradead.org>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
	<20061007145811.GA4043@krispykreme>
	<1160233817.4795.85.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 07:56:29 +1000
Message-Id: <1160258190.7122.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-10-07 at 16:10 +0100, David Woodhouse wrote:
> On Sun, 2006-10-08 at 00:58 +1000, Anton Blanchard wrote:
> > We need a way to export cache size/associativity information (sysfs,
> > /proc/device-tree parsing?) and a plan to fix the applications using
> > it first. 
> 
> ELF auxvec?

No, we abuse them too much already.

I was thinking that the vDSO could have a mecanism for retreiving infos,
maybe based on name.

 int __kernel_query_config(const char *tag, void *buffer, int size);

Or something like that and we define a bunch of them in a header... Now
the problem is to get glibc to re-export that to apps...

Ben.
