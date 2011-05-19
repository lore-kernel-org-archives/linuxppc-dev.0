Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD42CB71CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 09:12:44 +1000 (EST)
Subject: Re: Kernel cannot see PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <BANLkTimoyzERHjw_kQ5SAbNWudWJoX7yMA@mail.gmail.com>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
	<BANLkTim22Lm=TG9vP+XH25k04ncX=kqy8g@mail.gmail.com>
	<BANLkTinNSXCQJ=WJm6CkfttOgpVz1XOCBQ@mail.gmail.com>
	<BANLkTimoyzERHjw_kQ5SAbNWudWJoX7yMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 09:12:31 +1000
Message-ID: <1305846751.7481.55.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Prashant Bhole <prashantsmailcenter@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-19 at 11:58 -0600, Bjorn Helgaas wrote:
> The scan below PCIX0 (bus 0001:00) doesn't find anything.  You really
> need a powerpc expert to help here, but in their absence, my guess
> would be something's wrong with config space access, so I would start
> by just adding some printks to ppc4xx_probe_pcix_bridge() to see if
> the rsrc_cfg address looks reasonable.  You might need a chip spec or
> maybe you can compare it to the device tree (I have no idea what the
> relation between the device tree and OF is).
> 
> You mentioned the u-boot "pci 2" command earlier.  It found a device
> on bus 2, which means there must be at least one P2P bridge to get you
> from bus 0 to bus 2.  So the output of "pci 0", "pci 1", "pci 80", and
> "pci 81" (to compare with what Linux found) would be interesting.

Well, if it's PCIe, there's the "virtual" P2P bridge of the root
complex.

The question is on what PCIe is his device connected, the one that we
see or the one that's disabled in the device-tree.

In the former case, maybe something Linux does kills it. IE. we reset
and re-train the link on these chips afaik, at least from memory, check
what's happening in ppc4xx_pci.c there. Maybe the card doesn't like it
or we're doing something wrong....

In the later case, then something in the device-tree is saying Linux not
to touch that bridge, usually the "status" property.

Cheers,
Ben.
