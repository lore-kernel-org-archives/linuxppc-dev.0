Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AF1AB6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 17:59:50 +1000 (EST)
Subject: Re: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
	not atomic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1305692584.2580.3.camel@mulgrave.site>
References: <20110504115324.GE17855@lsi.com>
	<1305616571.6008.23.camel@mulgrave.site>
	<B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
	<20110518041551.GL15227@parisc-linux.org>
	<1305692584.2580.3.camel@mulgrave.site>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 May 2011 17:00:10 +1000
Message-ID: <1305702010.2781.33.camel@pasglop>
Mime-Version: 1.0
Cc: "Prakash, Sathya" <Sathya.Prakash@lsi.com>, "Desai,
	Kashyap" <Kashyap.Desai@lsi.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>, linuxppc-dev@lists.ozlabs.org,
	miltonm@bga.com, paulus@samba.org, "Moore, Eric" <Eric.Moore@lsi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Just adding Milton to the CC list, he suspects races in the driver
instead).

On Wed, 2011-05-18 at 08:23 +0400, James Bottomley wrote:
> On Tue, 2011-05-17 at 22:15 -0600, Matthew Wilcox wrote:
> > On Wed, May 18, 2011 at 09:37:08AM +0530, Desai, Kashyap wrote:
> > > On Wed, 2011-05-04 at 17:23 +0530, Kashyap, Desai wrote:
> > > > The following code seems to be there in /usr/src/linux/arch/x86/include/asm/io.h.
> > > > This is not going to work.
> > > > 
> > > > static inline void writeq(__u64 val, volatile void __iomem *addr)
> > > > {
> > > >         writel(val, addr);
> > > >         writel(val >> 32, addr+4);
> > > > }
> > > > 
> > > > So with this code turned on in the kernel, there is going to be race condition 
> > > > where multiple cpus can be writing to the request descriptor at the same time.
> > > > 
> > > > Meaning this could happen:
> > > > (A) CPU A doest 32bit write
> > > > (B) CPU B does 32 bit write
> > > > (C) CPU A does 32 bit write
> > > > (D) CPU B does 32 bit write
> > > > 
> > > > We need the 64 bit completed in one access pci memory write, else spin lock is required.
> > > > Since it's going to be difficult to know which writeq was implemented in the kernel, 
> > > > the driver is going to have to always acquire a spin lock each time we do 64bit write.
> > > > 
> > > > Cc: stable@kernle.org
> > > > Signed-off-by: Kashyap Desai <kashyap.desai@lsi.com>
> > > > ---
> > > > diff --git a/drivers/scsi/mpt2sas/mpt2sas_base.c b/drivers/scsi/mpt2sas/mpt2sas_base.c
> > > > index efa0255..5778334 100644
> > > > --- a/drivers/scsi/mpt2sas/mpt2sas_base.c
> > > > +++ b/drivers/scsi/mpt2sas/mpt2sas_base.c
> > > > @@ -1558,7 +1558,6 @@ mpt2sas_base_free_smid(struct MPT2SAS_ADAPTER *ioc, u16 smid)
> > > >   * care of 32 bit environment where its not quarenteed to send the entire word
> > > >   * in one transfer.
> > > >   */
> > > > -#ifndef writeq
> > > 
> > > Why not make this #ifndef CONFIG_64BIT?  You know that all 64 bit
> > > systems have writeq implemented correctly; you suspect 32 bit systems
> > > don't.
> > > 
> > > James
> > > 
> > > James, This issue was observed on PPC64 system. So what you have suggested will not solve this issue.
> > > If we are sure that writeq() is atomic across all architecture, we can use it safely. As we have seen issue on ppc64, we are not confident to use
> > > "writeq" call.
> > 
> > So have you told the powerpc people that they have a broken writeq?
> 
> I'm just in the process of finding them now on IRC so I can demand an
> explanation: this is a really serious API problem because writeq is
> supposed to be atomic on 64 bit.
> 
> > And why do you obfuscate your report by talking about i386 when it's
> > really about powerpc64?
> 
> James
> 
