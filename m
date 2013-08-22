Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 2CB582C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 08:42:13 +1000 (EST)
Date: Thu, 22 Aug 2013 15:29:51 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
Message-ID: <20130822222951.GA13201@ovro.caltech.edu>
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5216860A.6060409@ovro.caltech.edu>
Cc: Saravanan S <sarans1987@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 22, 2013 at 02:43:38PM -0700, David Hawkins wrote:
> Hi S.Saravanan,
> 
> > I have a custom board  with four MPC8640 nodes connected over
> > a transparent PCI express switch . In this configuration one node is
> > configured as host(Root Complex) and others as agents(End Point). Thus
> > the legacy PCI software works fine . However the mainline kernel lacks
> > any standard support for Inter-processor communication over PCI. I am
> > in the process of developing an Ethernet over  PCI driver for the same
> > on the lines of rionet . However I am facing the following problems.
> >
> > a)   I can generate MSI interrupts from End Point to Root Complex over
> > PCI . But the vice-versa is not possible . However i need a method to
> > interrupt the End Point from the Root Complex to complete my driver.
> 
> Root complex's would normally interrupt a device via a PCIe write
> to a register in a BAR on the end-point (or in extended configuration
> space registers depending on the hardware implementation).
> 
> > Only previous references I can find are this post
> > http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg25765.html
> > However this uses doorbells and I think may not be possible in MPC8640.
> 
> PCIe drivers need some way to interrupt the processor, so there must
> be an option somewhere ... for example, what are the message register
> interrupts intended for? See p479
> 
> http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8641DRM.pdf
> 
> (Ira and myself have not used the MPC8640 so are not familiar with
> its user manual).
> 
> > Any pointers on this issue and guidance on this driver development would
> > be helpful .
> 
> We use the Ethernet-over-PCI driver that Ira developed. Our next boards
> will use an MPC8308, but we don't currently have any in a PCIe device
> form-factor (just the MPC8038RDB), so he has not ported it to PCIe.
> 
> Feel free to discuss your ideas for your PCIe driver (eg., why start
> with rionet rather than Ira's driver), either on-list, or email Ira
> and myself directly.
> 

One further note. You might want to look at rproc/rpmsg and their virtio
driver support. That seems to be where the Linux world is moving for
inter-processor communications. See for example the ARM CPUs interfacing
with DSPs.

Ira
