Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Optimize counting distinct entries in
	therelocation sections
Date: Tue, 13 Nov 2007 15:27:39 +1100
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com>
	<598D5675D34BE349929AF5EDE9B03E27017BC13C@az33exm24.fsl.freescale.net>
	<18233.4267.193447.339119@cargo.ozlabs.ibm.com>
In-Reply-To: <18233.4267.193447.339119@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711131527.39491.rusty@rustcorp.com.au>
Cc: sfr@canb.auug.org.au, linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 13 November 2007 13:49:15 Paul Mackerras wrote:
> Medve Emilian writes:
> > Seems like there are R_PPC_REL24 with r_addend != 0. Within a set of 41
> > modules (featuring 5457 R_PPC_REL24 relocations) already included within
> > the kernel tree I found 37 such relocations (R_PPC_REL24) with r_addend
> > != 0. In my test case, from 35K relocations, 7K are R_PPC_REL24 and from
> > those only 8 have r_addend != 0.
>
> I did a quick scan and the ones with r_addend != 0 all seem to be
> references to .text from the .init.text, .exit.text or .fixup
> sections.  Assuming we can get those allocated near each other they
> shouldn't need trampolines.
>
> Rusty, do we manage to put .init.text and .fixup near .text?

Definitely not.  That's why we trampoline between them.  But since we discard 
the init sections and the tramps with them, I wouldn't bother uniquifing 
them: just alloc that many.

> Also, do you know what we see in r_info for a relocation that is
> relative to a section rather than a symbol?

Can't remember off the top of my head, sorry.

Rusty.
