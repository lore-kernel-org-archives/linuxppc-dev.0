Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070402181553.GH2132@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<20070402181553.GH2132@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <f622cb9af058a72fc47521e44ae6672a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Wed, 4 Apr 2007 13:18:41 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Agreed.  Dale Farnsworth suggested a 'ranges' type property at the top
> level that's used for phys->virt mappings.  That is much cleaner IMHO
> and eliminates the need to parse hash tables or add ioremap code to =
the
> bootwrapper.

I suggest you implement the standard "mmu" binding instead,
or the part that is relevant to you anyway:

/chosen/mmu contains the ihandle for an "mmu" node (for
flat trees, you use a phandle instead);

that node has properties, quoting from the base OF spec:

=93available=94
The property values are as defined for the standard =93reg=94 format,
with single-cell virtual addresses. The regions of virtual address
space denote the virtual address space that is currently unallocated
by the Open Firmware and is available for use by client programs.

=93existing=94
The value of this property defines the regions of virtual address
space managed by the MMU in whose package this property is defined
without regard to whether or not these regions are currently in use.
The encodings of virt and len are MMU-specific.

Have a look at the PowerPC binding to find out about that specific
encoding.


Segher
