Return-Path: <ben.c@servergy.com>
Received: from exprod6og106.obsmtp.com (exprod6og106.obsmtp.com [64.18.1.191])
 by ozlabs.org (Postfix) with SMTP id CEA97B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 01:39:04 +1000 (EST)
Received: by pbbro8 with SMTP id ro8so1235169pbb.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2012 08:39:02 -0700 (PDT)
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Ben Collins <ben.c@servergy.com>
In-Reply-To: <1339061428.24838.24.camel@pasglop>
Date: Thu, 7 Jun 2012 11:38:59 -0400
Message-Id: <489B8149-6E40-48B3-880F-EF8BE72E94BF@servergy.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com>
 <16AB27C3-8709-4A7C-AFFE-42A0B658AC1D@servergy.com>
 <1339061428.24838.24.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 7, 2012, at 5:30 AM, Benjamin Herrenschmidt wrote:

> On Wed, 2012-06-06 at 19:35 -0400, Ben Collins wrote:
>>=20
>> pci_bus 0000:00: root bus resource [io  0xffbed000-0xffbfcfff] (bus
>> address [0x100000000-0x10000ffff])
>>=20
>> Without the fix that I sent, it ends up looking like:
>>=20
>> pci_bus 0000:00: root bus resource [io  0xffbed000-0xffbfcfff] (bus
>> address [0x0000-0xffff])
>>=20
>> And that's when some devices fail to be assigned valid bar 0's and =
the
>> kernel complains because of it.
>=20
> Note that oddly, the second range of bus addresses looks -more- =
correct
> than the first one...

Except that the first one is exactly the same bus address as my bare =
metal system:

pci_bus 0000:00: root bus resource [io  0xffbeb000-0xffbfafff] (bus =
address [0x100000000-0x10000ffff])

I only have one PCIe RAID card on the bare metal system. Not surprising =
I never noticed the problem on it directly.

> Cheers,
> Ben.
>=20
>=20

--
Ben Collins
Servergy, Inc.
(757) 243-7557

CONFIDENTIALITY NOTICE: This communication contains privileged and/or =
confidential information; and should be maintained with the strictest =
confidence. It is intended solely for the use of the person or entity in =
which it is addressed. If you are not the intended recipient, you are =
STRICTLY PROHIBITED from disclosing, copying, distributing or using any =
of this information. If you received this communication in error, please =
contact the sender immediately and destroy the material in its entirety, =
whether electronic or hard copy.
