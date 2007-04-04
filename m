Return-Path: <stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Wed, 4 Apr 2007 10:51:13 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302C194B9@az33exm25.fsl.freescale.net>
In-Reply-To: <20070404162905.GD21314@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<20070402181553.GH2132@mag.az.mvista.com>
	<f622cb9af058a72fc47521e44ae6672a@kernel.crashing.org>
	<20070404162905.GD21314@mag.az.mvista.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > "existing"
> > The value of this property defines the regions of virtual address
> > space managed by the MMU in whose package this property is defined
> > without regard to whether or not these regions are currently in use.
> > The encodings of virt and len are MMU-specific.
> >=20
> > Have a look at the PowerPC binding to find out about that specific
> > encoding.

the PowerPC binding defines this--

 + 5.1.7. Memory Management Unit properties
 +=20
 + To aid a client in taking over the translation mechanism and
 + still interact with Open Firmware (via the client interface),
 + the client needs to know what translations have been established by
 + Open Firmware. The following standard property shall exist within
 + the package to which the mmu property of the /chosen package refers.
 +=20
 + "translations"
 +=20
 +    This property, consisting of sets of translations, defines the
 +    currently active translations that have been established by Open
 +    Firmware (e.g., using map). Each set has the following format:
 +     (virt size phys mode )
 +=20
 + Each value is encoded as with encode-int.

The "mode" field seems to be undefined.

So would firmware need to define all phys to virt mappings in=20
the "translations" property or just the interesting ones-- i.e
uart/console and i2c?

Stuart
