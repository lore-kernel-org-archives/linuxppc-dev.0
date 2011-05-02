Return-Path: <B32579@freescale.com>
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/2] powerpc: add support for MPIC message register API
Date: Mon, 2 May 2011 03:41:03 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741984EE@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>
	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>
	<4DBAED5D.4060906@mentor.com>
	<071A08F2C6A57E4E94D980ECA553F8741967EC@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110429123051.4ed1ca01@schlenkerla.am.freescale.net>
In-Reply-To: <20110429123051.4ed1ca01@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Meador Inge <meador_inge@mentor.com>,
	"openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>=20
> >
> >
> > > > Hi,
> > > >
> > > > I have no comments about coding and architecture. It looks fine.
> > > >
> > > > Only have a query about its use case..
> > > >    "Any application intended to use message interrupt requires to
> > > > know
> > > reg_num because of struct mpic_msgr* mpic_msgr_get(unsigned int
> > > reg_num) API"
> > > >
> > > > It will be good to search available unit internally and provide
> > > > its
> > > pointer. It will make application more flexible.
> > > >
> > >
> > > The problem is that you fundamentally cannot implement an allocator
> > > for MSG registers if you're going to communicate with another kernel
> > > (how would both kernels' allocators be synchronized?). So the
> > > message register allocation must be decided at design time, not run
> time.
> > >
> >
> > I agree with you..  It is true while communicating with another kernel.
> > But message interrupts can be used by different independent drivers
> within same kernel. For eg. PCIe and Ethernet driver.
> > As per current design both drivers needs to be in sync before
> requesting any message unit for avoiding any conflict. As these drivers
> are completely independent. It is very difficult.
> >
> > Can it be possible to provide new API to take care it.
>=20
> Do you have a real use case in mind where these message registers (not
> MSIs) are used internally in this manner?

Yes, we use for PCIe host/agent test case scenario.
Host usage message register to interrupt Agent...
Agent uses message register to generate irq_out (automatically generate MSI=
) to interrupt master. Please see RM for more details about irq_out
=20

Note: PCIe host/agent test scenario is used internally and we are working o=
n pushing it out..
=20
> Perhaps an allocator could be added in the same patchset that adds such a
> user.
>=20

Yaa. It can be done. Otherwise module has to query each message unit for it=
s availability.=20

--Prabhakar
