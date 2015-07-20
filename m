Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 1A7CD1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 22:46:42 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@freescale.com" <madalin.bucur@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Mon, 20 Jul 2015 12:46:37 +0000
Message-ID: <1437396397.10831.31.camel@transmode.se>
References: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
 <1437378870.10831.12.camel@transmode.se>
 <1437379026.10831.14.camel@transmode.se>
 <BL2PR03MB5456302C77FAEC1AC60669CE6850@BL2PR03MB545.namprd03.prod.outlook.com>
In-Reply-To: <BL2PR03MB5456302C77FAEC1AC60669CE6850@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-20 at 12:18 +0000, Madalin-Cristian Bucur wrote:
> Hi Joakim
>=20
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> > Sent: Monday, July 20, 2015 10:57 AM
> > To: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org; Bucur Madali=
n-
> > Cristian-B32716
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH RFC 02/10] dpaa_eth: add support for DPAA Ethernet
> >=20
> > On Mon, 2015-07-20 at 09:54 +0200, Joakim Tjernlund wrote:
> > > On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> > > > This introduces the Freescale Data Path Acceleration Architecture
> > > > (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> > > > BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> > > > the Freescale DPAA QorIQ platforms.
> > > >=20
> > > > Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> > > > ---
> > > ....
> > > > +	snprintf(net_dev->name, IFNAMSIZ, "fm%d-mac%d",
> > > > +		 dpa_mac_fman_index_get(pdev),
> > > > +		 dpa_mac_hw_index_get(pdev));
> > >=20
> > > Should ethernet drivers dictate interface name in user space nowadays=
?
> > > I would prefer if you didn't.
>=20
> The preformatted interface name was thought as a helper for quick interfa=
ce
> identification. It also ensures constant naming of the interfaces, i.e. i=
f you
> add/remove PCI network cards. One can make use of udev rules to override
> default interface names ("eth%d") in userspace.

I am not well versed in ethernet interface naming but I think you are just =
creating
another name space here. To me one either have the old eth%d names or let u=
dev do
the naming so there is some order w.r.t interface naming.

I also find it handy to be able to control which I/F is eth0 etc. just by c=
hanging
the order they are listed in the device tree. This makes our application ha=
ppy :)

>=20
> Another reason for using this is that the interface name was also used fo=
r the
> debugfs file name and when compiling dpaa_eth as a module there was a
> problem with udev concurrently renaming interfaces from eth0 to something
> like fmx-macy, making the next probed DPAA interface temporarily get the
> eth0 name (before being renamed fmx-macw). Subsequently,
> the debugfs_create_file(net_dev->name,...) call failed because of duplica=
ted
> names.
>=20
> If this is considered more of a bug than a feature, I can remove it and o=
nly change
> the naming of the debugfs entries to avoid the udev issue.

Perhaps netdev list can advise?

 Jocke=
