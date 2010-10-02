Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A65A4B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Oct 2010 05:49:35 +1100 (EST)
Date: Sat, 2 Oct 2010 11:49:57 -0700
From: Greg KH <greg@kroah.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] PPC4xx: ADMA separating SoC specific functions
Message-ID: <20101002184957.GA17774@kroah.com>
References: <1285865736-32074-1-git-send-email-tmarri@apm.com>
	<20100930190814.52268D2B48C@gemini.denx.de>
	<AANLkTi=CJOsayM1YnwE3a22D2S35aM+BTV6_YfXjcjiO@mail.gmail.com>
	<dc9b5d064d80ac2af2ccf932e94b2bb9@mail.gmail.com>
	<AANLkTi=JqTU898DfW1=4qcb2WbwHvroY6LqiAX_oBb5L@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=JqTU898DfW1=4qcb2WbwHvroY6LqiAX_oBb5L@mail.gmail.com>
Cc: Wolfgang Denk <wd@denx.de>, Tirumala Marri <tmarri@apm.com>,
	yur@emcraft.com, linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 30, 2010 at 05:57:10PM -0700, Dan Williams wrote:
> [ adding Greg ]
> 
> On Thu, Sep 30, 2010 at 5:16 PM, Tirumala Marri <tmarri@apm.com> wrote:
> >> Where ?iop_adma_alloc_slots() is implemented differently between
> >> iop13xx and iop3xx. ?In this case why does ppc440spe-adma.h exist? ?If
> >> it has code specific to ppe440spe it should just live in the ppe440spe
> >> C file. ?If it is truly generic it should move to the base adma.c
> >> implementation. ?If you want to reuse a ppe440spe routine just link to
> >> it.
> > [Marri]That is how I started changing the code. And I see tons of warnings
> > Saying "Used but not defined" or "Defined but not used". How should I
> > suppress
> > Some functions from adma.c are used in ppc440spe-adma.c and some from
> > ppc440spe-adma.c
> > Are used in adma.c.
> 
> This is part of defining a common interface.  Maybe look at the
> linkages of how the common ioat_probe() routine is used to support all
> three versions of its dma hardware.
> 
> > So I created intermediate file ppc440spe-adma.h with
> > inlined
> > Functions. In future this will be converted into ppc4xx_adma.h and move
> > existing
> > SoC specific stuff to ppc440spe-adma.c file.
> 
> You definitely need to be able to resolve "used but not defined" and
> "defined but not used" warnings before tackling a driver conversion
> like this.  In light of this comment I wonder if it would be
> appropriate to submit your original driver, that just duplicated
> routines from the ppc440spe driver, to the -staging tree.  Then it
> would be available for someone familiar with driver conversions to
> take a shot at unifying.
> 
> Greg, is this an appropriate use of -staging?

Possibly, but I really don't like duplication if possible.  What's
keeping this code from being fixed up now properly?

thanks,

greg k-h
