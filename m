Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 44576DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 19:44:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1158331anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 00:44:36 -0800 (PST)
Date: Mon, 14 Jan 2008 02:44:32 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Message-ID: <20080114024432.1dcba2f7@vader.jdub.homelinux.org>
In-Reply-To: <478AEB39.70106@pikatech.com>
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<478AEB39.70106@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 13 Jan 2008 23:55:21 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Stefan Roese wrote:
> >
> >> +#ifdef CONFIG_TACO
> >> +/* The NDFC may allow 32bit read/writes, but it sure doesn't work on
> >> + * the taco!
> >> + */
> >>     
> >
> > We definitely don't want to see such board specific stuff in the common
> > NDFC driver. And I really doubt that you need this change for your board.
> > We are using this ndfc driver on multiple boards, and all have no
> > problems accessing the controller with 32bit read/writes. So you most
> > likely have a problem with your board port. Perhaps something with
> > with the EBC setup. Please re-check and compare with boards that are know
> > to work, like Sequoia.
> >   
> How about adding a config option that lets you specify 8 bit access? 
> Something like CONFIG_NDFC_8BIT_ACCESS. We could default it to no and 
> put a little blurb that says something like:
> 
> On some platforms the 32bit read/writes cause a machine access 
> exception. If you get a machine access exception while reading the NAND 
> bad block table, try turning on 8 bit access.

But did you go back and verify the EBC settings were correct on your
board?  This shouldn't be needed at all if the EBC bank settings and
timings are correct.

josh
