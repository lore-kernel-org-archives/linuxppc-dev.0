Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 070AFB6F11
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 08:00:46 +1000 (EST)
Received: by gwj15 with SMTP id 15so3034821gwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Aug 2010 15:00:45 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100803215137.GU26313@bicker>
References: <Pine.LNX.4.64.1008032334420.20393@ask.diku.dk>
	<20100803215137.GU26313@bicker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 3 Aug 2010 16:00:25 -0600
Message-ID: <AANLkTi=yOJ0Zfsn_h_xWai5O=OPkccMb-hDwKK+dWZwf@mail.gmail.com>
Subject: Re: [PATCH 8/9] arch/powerpc/kernel: Drop unnecessary null test
To: Dan Carpenter <error27@gmail.com>, Julia Lawall <julia@diku.dk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 3, 2010 at 3:51 PM, Dan Carpenter <error27@gmail.com> wrote:
> On Tue, Aug 03, 2010 at 11:35:17PM +0200, Julia Lawall wrote:
>> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci=
_of_scan.c
>> index 6ddb795..62dd363 100644
>> --- a/arch/powerpc/kernel/pci_of_scan.c
>> +++ b/arch/powerpc/kernel/pci_of_scan.c
>> @@ -336,8 +336,7 @@ static void __devinit __of_scan_bus(struct device_no=
de *node,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRI=
DGE ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->hdr_type =3D=3D PCI_HEADER_TYPE=
_CARDBUS) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *child =
=3D pci_device_to_OF_node(dev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_scan_pci_br=
idge(child, dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_scan_pci_bridge(child, dev)=
;
>
> The intention was probably to check "child" instead of "dev".
> pci_device_to_OF_node() can return NULL. =A0On the other hand the code
> has been this way for a year and no one has complained...

Still, it should be fixed.  It is likely that I'll be generalizing
this code for other architectures in the near future.  I'll spin a
patch.

g.
