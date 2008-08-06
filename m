Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E4491DE0A9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:32:07 +1000 (EST)
Date: Tue, 05 Aug 2008 23:32:05 -0700 (PDT)
Message-Id: <20080805.233205.201125898.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080806060239.30717.79273.stgit@trillian.secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 06 Aug 2008 00:02:44 -0600

> of_lookup_stdout() is useful for figuring out what device to use as output
> for early boot progress messages.  It returns the node pointed to by the
> linux,stdout-path property in the chosen node.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

On sparc platforms this is obtained differently.  We obtain the 32-bit
instance value of "/chosen/stdout" and convert that into a prom device
node path using "instance-to-path".

If this of_lookup_stdout() is going into generic OF code, it should be
done in a way that works on all platforms.  All of these "linux,*"
properties and node names are powerpc platform specific.
