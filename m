Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E927EDDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Feb 2007 12:45:58 +1100 (EST)
Subject: RE: 8360E - PCI / DTC Blob Setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rmcguire@videopresence.com
In-Reply-To: <000b01c746cf$35accc40$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
	<1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
	<000301c7458b$b9eb1330$6405a8c0@absolut>
	<829261C6-F534-4B85-A04D-8D280E46B2CF@kernel.crashing.org>
	<000401c74591$8a3a4ec0$6405a8c0@absolut>
	<BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
	<000801c7460d$211e46e0$6405a8c0@absolut>
	<974C77BD-19A0-4843-8E7B-3B430DB4ADE9@kernel.crashing.org>
	<001101c74629$28797380$6405a8c0@absolut>
	<AF782BFC-5262-462B-A522-8F685DC59158@kernel.crashing.org>
	<001001c74674$b17bf4f0$6405a8c0@absolut>
	<567B131D-57F5-4972-AF09-5373D041368C@kernel.crashing.org>
	<000b01c746cf$35accc40$6405a8c0@absolut>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 12:45:47 +1100
Message-Id: <1170639948.2620.80.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-02-02 at 05:36 -0800, Russell McGuire wrote:
> Well I am getting smarter on this:
> 
> I have read through the PCI Bridge Specs and found another issue that might
> have been causing a problem with the IDSEL lines. Unless you are interested
> I'll forgo that explanation and just go with fact that I have changed the
> IDSEL mappings to be legal when they are issued from the 83xx.
> 
> I have changed the IDSELs to be as follows, does this look correct?
> I agree with placing the NODE for the bridge into the dts file to be
> correct. Except I get stuck immediately at trying to come up with an
> address. I.e. the PCI host has a PCI@8500, which makes sense. But the Bridge
> chip doesn't have a mapped address to place in the file. I did read the PCI
> OF node spec <dated 1996> it hints that PCI-PCI bridges are essentially the
> same domain and may not need translation.

The unit address of a PCI device is it's bus/idsel/function, the
PCI-2-PCI bridge is no exception.  Thus it doesn't need to have an
assigned-address property, only "reg", which on PCI, doesn't contain
-assigned- addresses, but purely a description of the BARs. In fact, you
only really need the "reg" property for the config space itself which is
enough to give you a valid unit-address (@xxxx) for your bridge and to
make the PCI parsing code in linux happy.

Ben.
