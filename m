Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 908B8DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:41:36 +1100 (EST)
Message-ID: <47C673B0.2070705@s5r6.in-berlin.de>
Date: Thu, 28 Feb 2008 09:41:20 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] firewire: endianess fix
References: <20080220220326.GA22328@uranus.ravnborg.org>	<1203545913.25307.47.camel@brick>	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
	<1204166506.15052.336.camel@pasglop>
In-Reply-To: <1204166506.15052.336.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Do we have the workaround for the old Apple UniNorth in the new FW OHCI
> driver (for selfID swapping iirc ?)

According to ohci1394.c, it selfIDs and headers of incoming packets are 
not byte-swapped by the old Apple Uninorth FireWire part.  And no, 
firewire-ohci doesn't have the workaround yet.

It should be trivial to copy'n'paste ohci1394's workaround into fw-ohci, 
but it would be good if someone could test before and after.

BTW, since that code is touched everytime a packet is received, we 
should enclose such a workaround in #ifdef CONFIG_PPC_PMAC && 
CONFIG_PPC32, shouldn't we?  (As a second step after adding the workaround.)
-- 
Stefan Richter
-=====-==--- --=- ===--
http://arcgraph.de/sr/
