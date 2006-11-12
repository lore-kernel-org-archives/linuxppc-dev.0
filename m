Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFD1267DCE
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 11:50:51 +1100 (EST)
Subject: Re: ipr SATA support is causing problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@us.ibm.com>
In-Reply-To: <4556631C.1070308@us.ibm.com>
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
	<45549962.108@us.ibm.com>
	<17749.1504.630761.341652@cargo.ozlabs.ibm.com>
	<4556631C.1070308@us.ibm.com>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 11:50:41 +1100
Message-Id: <1163292641.4982.249.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: James.Bottomley@SteelEye.com, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>, akpm@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 17:56 -0600, Brian King wrote:
> Paul Mackerras wrote:
> > How hard would it be to make the SATA bits conditionally compiled in,
> > depending on CONFIG_ATA?
> 
> I took a look at doing this. It got a bit messy with a bunch of ifdefs,
> then I realized that doing this would break module dependencies. If
> ipr does not depend on CONFIG_ATA, then libata will not automatically
> get loaded (or built into initrd's) when ipr is needed.
> 
> The best way I can see to accomplish your desired goal is to do something
> like the fusion driver did and separate out the sas bits from the scsi
> bits and essentially end up with multiple ipr modules. Unfortunately,
> this is not 2.6.19 material, but I could start working on it if you
> thought it sounded like a reasonable direction.

Yeah, something like

                    /--- SATA sub-modules (depends on CONFIG_ATA)
 - core IPR module /
                   \
                    \--- SAS sub-module (depends on CONFIG_SCSI)
                     \ 
                      \--- SCSI sub-module (depends on CONFIG_SCSI)


Or do you need SAS and SATA to be one and only one ?

Cheers,
Ben.
