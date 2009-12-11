Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers through
	extended ptrace interface
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
Date: Thu, 10 Dec 2009 20:45:02 -0600
Message-Id: <ABDB7BBD-AFF2-4CAD-94E0-4A711FB7919B@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:

> These patches implement an extention to the ptrace interface proposed =
by
> Thiago Bauermann and the the PowerPC gdb team.
>=20
> GDB intends to support the following hardware debug features of BookE
> processors:
>=20
> 4 hardware breakpoints (IAC)
> 2 hardware watchpoints (read, write and read-write) (DAC)
> 2 value conditions for the hardware watchpoints (DVC)
>=20
> For that, we need to extend ptrace so that GDB can query and set these
> resources. Since we're extending, we're trying to create an interface
> that's extendable and that covers both BookE and server processors, so
> that GDB doesn't need to special-case each of them. We propose the
> following 3 new ptrace requests described below.
>=20
> There have been discussions of a generic hardware debug interface for =
the
> kernel which would hopefully contemplate all the functionality below =
and
> supersede it.  But we need something that works now, and which enables =
GDB
> to be simpler and work with both Server and Embedded processors =
without
> special cases.

What do we do in EDM mode?  We need a flag somewhere to determine if HW =
supports conveying DBCR0[EDM] and if it does which of the ptrace calls =
fails?

- k=
