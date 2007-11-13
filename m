Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18233.4267.193447.339119@cargo.ozlabs.ibm.com>
Date: Tue, 13 Nov 2007 13:49:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] [POWERPC] Optimize counting distinct entries in
	therelocation sections
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27017BC13C@az33exm24.fsl.freescale.net>
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com>
	<18231.60427.229658.485287@cargo.ozlabs.ibm.com>
	<598D5675D34BE349929AF5EDE9B03E270174DB3E@az33exm24.fsl.freescale.net>
	<598D5675D34BE349929AF5EDE9B03E27017BC13C@az33exm24.fsl.freescale.net>
Cc: sfr@canb.auug.org.au, rusty@rustcorp.com.au, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Medve Emilian writes:

> Seems like there are R_PPC_REL24 with r_addend != 0. Within a set of 41
> modules (featuring 5457 R_PPC_REL24 relocations) already included within
> the kernel tree I found 37 such relocations (R_PPC_REL24) with r_addend
> != 0. In my test case, from 35K relocations, 7K are R_PPC_REL24 and from
> those only 8 have r_addend != 0.

I did a quick scan and the ones with r_addend != 0 all seem to be
references to .text from the .init.text, .exit.text or .fixup
sections.  Assuming we can get those allocated near each other they
shouldn't need trampolines.

Rusty, do we manage to put .init.text and .fixup near .text?

Also, do you know what we see in r_info for a relocation that is
relative to a section rather than a symbol?

Paul.
