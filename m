Return-Path: <dan.j.williams@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id C6D92B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 10:57:13 +1000 (EST)
Received: by wyb42 with SMTP id 42so2519137wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 17:57:11 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <dc9b5d064d80ac2af2ccf932e94b2bb9@mail.gmail.com>
References: <1285865736-32074-1-git-send-email-tmarri@apm.com>
	<20100930190814.52268D2B48C@gemini.denx.de>
	<AANLkTi=CJOsayM1YnwE3a22D2S35aM+BTV6_YfXjcjiO@mail.gmail.com>
	<dc9b5d064d80ac2af2ccf932e94b2bb9@mail.gmail.com>
Date: Thu, 30 Sep 2010 17:57:10 -0700
Message-ID: <AANLkTi=JqTU898DfW1=4qcb2WbwHvroY6LqiAX_oBb5L@mail.gmail.com>
Subject: Re: [PATCH] PPC4xx: ADMA separating SoC specific functions
From: Dan Williams <dan.j.williams@intel.com>
To: Tirumala Marri <tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>, Greg KH <greg@kroah.com>, yur@emcraft.com,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ adding Greg ]

On Thu, Sep 30, 2010 at 5:16 PM, Tirumala Marri <tmarri@apm.com> wrote:
>> Where =A0iop_adma_alloc_slots() is implemented differently between
>> iop13xx and iop3xx. =A0In this case why does ppc440spe-adma.h exist? =A0=
If
>> it has code specific to ppe440spe it should just live in the ppe440spe
>> C file. =A0If it is truly generic it should move to the base adma.c
>> implementation. =A0If you want to reuse a ppe440spe routine just link to
>> it.
> [Marri]That is how I started changing the code. And I see tons of warning=
s
> Saying "Used but not defined" or "Defined but not used". How should I
> suppress
> Some functions from adma.c are used in ppc440spe-adma.c and some from
> ppc440spe-adma.c
> Are used in adma.c.

This is part of defining a common interface.  Maybe look at the
linkages of how the common ioat_probe() routine is used to support all
three versions of its dma hardware.

> So I created intermediate file ppc440spe-adma.h with
> inlined
> Functions. In future this will be converted into ppc4xx_adma.h and move
> existing
> SoC specific stuff to ppc440spe-adma.c file.

You definitely need to be able to resolve "used but not defined" and
"defined but not used" warnings before tackling a driver conversion
like this.  In light of this comment I wonder if it would be
appropriate to submit your original driver, that just duplicated
routines from the ppc440spe driver, to the -staging tree.  Then it
would be available for someone familiar with driver conversions to
take a shot at unifying.

Greg, is this an appropriate use of -staging?

--
Dan
