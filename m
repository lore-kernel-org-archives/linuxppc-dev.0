Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8727DE082
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 04:28:09 +1000 (EST)
Subject: Re: [PATCH: dtc take 2] Assemble the blob in memory before writing
	it out.
From: Jon Loeliger <jdl@freescale.com>
To: Jerry Van Baren <gvb.uboot@gmail.com>
In-Reply-To: <20070419015951.GA9339@dellserver.lan>
References: <20070419015951.GA9339@dellserver.lan>
Content-Type: text/plain
Message-Id: <1177007241.14328.21.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 19 Apr 2007 13:27:22 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>,
	u-boot-users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-18 at 20:59, Jerry Van Baren wrote:
> This makes padding out the blob if the user requested extra size much
> easer.  The assembly and writing to the file is more straight forward too.
> 
> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
> ---
> 
> Hi David, Jon,
> 
> I wasn't happy with David's suggestion on the -S handling.  I also wasn't
> all that wild about how the blob was assembled and then written to the
> file piecemeal with "ad-hoc" alignment padding.  I realized I could fix
> both by assembling the blob in memory as a "struct data" and then write
> the whole thing out in one fell swoop.
> 
> Makes it a lot simpler and cleaner to my eyes.
> 
> Hope y'all agree,
> gvb

Jerry and David,

Sorry.  I've been out sick for a couple days here and am
just now catching up.  I've read through the last week's
worth of mail here now, so let me see if I have properly
summarized where things stand and what's needed for the DTC:

These patches need to be applied:

    [PATCH dtc] Add -o <output file> to the usage message.
    Sat, 14 Apr 2007 18:16:47 -0400

    [PATCH dtc take 3] Fix reserve map output for asm format.
    Tue, 17 Apr 2007 18:14:41 -0400

    [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
    Wed, 18 Apr 2007 21:59:51 -0400

The last patch there replaces the "Improve -S handling" patches.
But does the last patch replace or depend on the second one?

And I agree with David that last patch is a better approach.

Thanks,
jdl
