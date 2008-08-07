Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808060631k278e187ej965f0ac08c837937@mail.gmail.com>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
	<18585.31504.836857.829592@cargo.ozlabs.ibm.com>
	<fa686aa40808060631k278e187ej965f0ac08c837937@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 08:35:38 +1000
Message-Id: <1218148538.24157.311.camel@pasglop>
Mime-Version: 1.0
Cc: devicetree-discuss@ozlabs.org, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It's not what we do with flattened device trees blobs though.  In the
> flattened tree we're not using a /chosen/stdout property, just the
> linux,stdout-path one.
> 
> The question that remains is; should there be?  Should the dt blobs
> use /chosen/stdout also?  (I'm not familiar enough with real OF to
> know the answer.  I'm assuming that an instance value is not the same
> as a phandle).

Yup, there are two issues there:

 - The instance value would have to be converted to a phandle while
OF is still alive. I initially did that and added a stdout-node or so
property, but that still hit the next issue.

 - IBM machines has this weird distinction between the real phandle
and the ibm,phandle, the later being the same except for things
that get hotplugged ... and some of the vdevices. We got really
confused trying to sort that out with the output device.

So in the end, I decided to just convert the ihandle to a path and
stick that path in the device-tree.

Cheers,
Ben.
