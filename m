Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 22FC32C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 07:17:45 +1000 (EST)
Message-ID: <1367615852.4389.98.camel@pasglop>
Subject: Re: net/eth/ibmveth: Fixup retrieval of MAC address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Hutchings <bhutchings@solarflare.com>
Date: Sat, 04 May 2013 07:17:32 +1000
In-Reply-To: <1367598632.2756.3.camel@bwh-desktop.uk.solarflarecom.com>
References: <1367458520.4389.6.camel@pasglop>
 <1367598632.2756.3.camel@bwh-desktop.uk.solarflarecom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 17:30 +0100, Ben Hutchings wrote:
> > +	/* Workaround for old/broken pHyp */
> > +	if (mac_len == 8)
> > +		mac_addr_p += 2;
> > +	if (mac_len != 6) {
> 
> Missing 'else' before the second if?

Absolutely... oops :-) I couldn't find a version of pHyp with the wrong
property to test with. I suppose I could hack it up in OFW before boot.

I'll fix that and respin, sorry about that.

Cheers,
Ben.

> > +		dev_err(&dev->dev, "VETH_MAC_ADDR attribute wrong len %d\n",
> > +			mac_len);
> > +		return -EINVAL;
> > +	}
> [...]
> 
