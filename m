Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E6B61A2D88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 08:58:50 +1000 (AEST)
Date: Fri, 25 Sep 2015 00:50:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 David Miller <davem@davemloft.net>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 devicetree@vger.kernel.org, Sunil Goutham <sgoutham@cavium.com>,
 Robert Richter <rric@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
 Soren Brinkmann <soren.brinkmann@xilinx.com>,
 Iyappan Subramanian <isubramanian@apm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Li Yang <leoli@freescale.com>, Keyur Chudgar <kchudgar@apm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
Message-ID: <20150924225033.GI20825@lunn.ch>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <20150924215731.GE20825@lunn.ch>
 <20150924221541.GF21513@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150924221541.GF21513@n2100.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Thanks for testing.  Please could you confirm whether the same behaviour
> is observed without the patches, just to make absolutely sure that isn't
> a regression.

So i tested this now.

I have two FEC interfaces. One i my main access interface, and the
second is used by DSA to access switches. With your patches, the
module Used by count is equal to the number of interfaces which are
up.

Without your patches, the count is always 0.

When i try to remove the fec module, without your patches, but DSA
still using the interface, i get the same

 kernel:unregister_netdevice: waiting for eth1 to become free. Usage count = 1

as with your patch. So this is not a regression.

   Andrew
