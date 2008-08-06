Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6B820DDFAA
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 20:52:06 +1000 (EST)
Date: Wed, 06 Aug 2008 03:52:05 -0700 (PDT)
Message-Id: <20080806.035205.98201455.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: David Miller <davem@davemloft.net>
In-Reply-To: <18585.31504.836857.829592@cargo.ozlabs.ibm.com>
References: <20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
	<18585.31504.836857.829592@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 6 Aug 2008 20:21:04 +1000

> David Miller writes:
> 
> > On sparc platforms this is obtained differently.  We obtain the 32-bit
> > instance value of "/chosen/stdout" and convert that into a prom device
> > node path using "instance-to-path".
> 
> That's actually exactly what we do too, the linux,stdout-path property
> is just a cache of the result of that process.  The difference is that
> we have to do it early on while we still have OF around, while you can
> do it later.

I do it right when I build the in-kernel OBP tree.  Then I cache
these results in:

extern struct device_node *of_console_device;
extern char *of_console_path;
extern char *of_console_options;

which are declared in asm/prom.h

I could compute it even earlier and just store a phandle instead
of a device_node pointer.
