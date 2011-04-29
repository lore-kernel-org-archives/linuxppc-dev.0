Return-Path: <B32579@freescale.com>
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: RE: [PATCH 2/2] powerpc: add support for MPIC message register API
Date: Fri, 29 Apr 2011 17:27:06 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741967EC@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>
	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>
	<4DBAED5D.4060906@mentor.com>
In-Reply-To: <4DBAED5D.4060906@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Meador Inge <meador_inge@mentor.com>,
	"openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> > Hi,
> >
> > I have no comments about coding and architecture. It looks fine.
> >
> > Only have a query about its use case..
> >    "Any application intended to use message interrupt requires to know
> reg_num because of struct mpic_msgr* mpic_msgr_get(unsigned int reg_num)
> API"
> >
> > It will be good to search available unit internally and provide its
> pointer. It will make application more flexible.
> >
>=20
> The problem is that you fundamentally cannot implement an allocator for
> MSG registers if you're going to communicate with another kernel (how
> would both kernels' allocators be synchronized?). So the message register
> allocation must be decided at design time, not run time.
>=20

I agree with you..  It is true while communicating with another kernel.
But message interrupts can be used by different independent drivers within =
same kernel. For eg. PCIe and Ethernet driver.=20
As per current design both drivers needs to be in sync before requesting an=
y message unit for avoiding any conflict. As these drivers are completely i=
ndependent. It is very difficult.=20

Can it be possible to provide new API to take care it.

--Prabhakar
