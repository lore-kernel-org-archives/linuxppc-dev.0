Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id D08706855F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 06:32:02 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0808.wanadoo.fr (SMTP Server) with ESMTP id 6D7D71C0027D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 22:31:59 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-40-23.w82-126.abo.wanadoo.fr
	[82.126.157.23])
	by mwinf0808.wanadoo.fr (SMTP Server) with ESMTP id 481551C00264
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 22:31:59 +0200 (CEST)
Date: Thu, 27 Oct 2005 22:30:17 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20051027203017.GA13787@localhost.localdomain>
References: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
	<20051027181751.GD9628@mag.az.mvista.com>
	<20051027184921.GA11742@localhost.localdomain>
	<20051027200447.GC13847@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051027200447.GC13847@mag.az.mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Board based on MPC7447 and MV64462
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2005 at 01:04:47PM -0700, Mark A. Greer wrote:
> On Thu, Oct 27, 2005 at 08:49:21PM +0200, Sven Luther wrote:
> > On Thu, Oct 27, 2005 at 11:17:51AM -0700, Mark A. Greer wrote:
> > > On Thu, Oct 27, 2005 at 06:47:29PM +0530, Ashish Bijlani wrote:
> > > > Hi,
> > > > 
> > > > I've added platform support for a board based on MPC7447A and MV64462
> > > > Marvell Discovery III system controller. I modified code for Katana to make
> > > > it work for this board. The ethernet and serial are working fine but I don't
> > > > see anything in "lspci" output.
> > > 
> > > Do you have any pci devices?  If not, then that's to be expected.
> > > If you do, then you have something messed up in your code and they
> > > aren't being found.
> > 
> > They should at least shgow the northbridge pci ids, no ? 
> 
> No b/c the regs for the bridge are not pci compliant so the bridge is
> "excluded" or hidden from the generic pci code (which is where lspci
> gets its info from).  If it wasn't, the generic pci code would get
> confused as would the bridge.

The pegasos OF allows access to the pci config area through rtas, and those
call filter out any dangerous accesses. And since you didn't know about rtas,
i will explain for others who may be in other cases.

RTAS is a OpenFirmware/CHRP extension (RunTimeAbstraction..., not sure about
the S), which provides a set of methods which will run even when linux has
taken over and overwritten the firmware, providing stuff like halt/reset,
pci-read|write-config, nvram-fetch|store, clock access functions, ...

Friendly,

Sven Luther
