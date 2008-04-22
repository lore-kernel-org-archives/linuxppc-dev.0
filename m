Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BFFDDE053
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 08:18:31 +1000 (EST)
Subject: Re: pci issue - wrong detection of pci ressources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <480DF46F.9090900@linux.vnet.ibm.com>
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>	<480BA937.7050603@linux.vnet.ibm.com>
	<1208727408.7009.0.camel@pasglop>	<480C80B6.30904@linux.vnet.ibm.com>
	<480C87BD.8090207@ru.mvista.com>	<480C9FE2.4030601@linux.vnet.ibm.com>
	<480CAFD2.2050108@ru.mvista.com> <480CBEE0.9000104@ru.mvista.com>
	<480DDE2B.4000808@linux.vnet.ibm.com> <480DE89B.2030402@ru.mvista.com>
	<480DF46F.9090900@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 08:18:10 +1000
Message-Id: <1208902690.9640.134.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >> radeonfb: EDID probed
> >> Parsing EDID data for panel info
> >> Setting up default mode based on panel info
> >> radeonfb (0000:00:0a.0): ATI Radeon Y`
> > 
> >    Hm, what's that Y`?
> 
> Thats the final message in the radeonfb driver ater initializing everything.
>    printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
> I wonder why that rinfo->name is clobbered - maybe another issue, I have to keep that in mind.

Nah, that's normal. ATI used to use nice letters for their PCI ID, and
we used to print that as that's also what they used in some docs etc...
but a few years ago, they started using other characters (running out of
letters). I think there's a patch floating around to print it in hex
instead.

Cheers,
Ben.
