Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C124EB6F6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 15:38:41 +1000 (EST)
Subject: Re: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
	not atomic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@kernel.org>
In-Reply-To: <BANLkTimDktq8SxOU3HZkPpj=J9pdkzVX-w@mail.gmail.com>
References: <20110504115324.GE17855@lsi.com>
	<1305616571.6008.23.camel@mulgrave.site>
	<B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
	<20110518041551.GL15227@parisc-linux.org>
	<1305692584.2580.3.camel@mulgrave.site>
	<1305702010.2781.33.camel@pasglop>
	<mpt2sas-writeq-powerpc64@mdm.bga.com>
	<4565AEA676113A449269C2F3A549520F80B66280@cosmail03.lsi.com>
	<x86-32-writeq-is-broken@mdm.bga.com>
	<BANLkTimDktq8SxOU3HZkPpj=J9pdkzVX-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 15:34:02 +1000
Message-ID: <1305783242.7481.42.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch <linux-arch@vger.kernel.org>, "Prakash,
	Sathya" <Sathya.Prakash@lsi.com>, "Desai, Kashyap" <Kashyap.Desai@lsi.com>,
	linux scsi dev <linux-scsi@vger.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>, Hitoshi Mitake <h.mitake@gmail.com>,
	linux powerpc dev <linuxppc-dev@lists.ozlabs.org>,
	Milton Miller <miltonm@bga.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>,
	linux pci <linux-pci@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 21:16 -0700, Roland Dreier wrote:
> On Wed, May 18, 2011 at 11:31 AM, Milton Miller <miltonm@bga.com> wrote:
> > So the real question should be why is x86-32 supplying a broken writeq
> > instead of letting drivers work out what to do it when needed?
> 
> Sounds a lot like what I was asking a couple of years ago :)
> http://lkml.org/lkml/2009/4/19/164
> 
> But Ingo insisted that non-atomic writeq would be fine:
> http://lkml.org/lkml/2009/4/19/167

Yuck... Ingo, I think that was very wrong.

Those are for MMIO, which must almost ALWAYS know precisely what the
resulting access size is going to be. It's not even about atomicity
between multiple CPUs. I have seen plenty of HW for which a 64-bit
access to a register is -not- equivalent to two 32-bit ones. In fact, in
some case, you can get the side effects twice ... or none at all.

The only case where you can be lax is when you explicitely know that
there is no side effects -and- the HW cope with different access sizes.
This is not the general case and drivers need at the very least a way to
know what the behaviour will be.

Cheers,
Ben.
