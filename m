Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 24F6ADDFB5
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 04:52:44 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so662632anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 10:52:39 -0700 (PDT)
Message-ID: <3ae3aa420803121052g6ded9c94xd23823a4e81f4bbf@mail.gmail.com>
Date: Wed, 12 Mar 2008 11:52:38 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
In-Reply-To: <1205197341.8656.5.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C750CE.7050202@austin.ibm.com>
	<1205197341.8656.5.camel@concordia.ozlabs.ibm.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/03/2008, Michael Ellerman <michael@ellerman.id.au> wrote:
> On Thu, 2008-02-28 at 18:24 -0600, Manish Ahuja wrote:

>  > +
>  > +/* Global, used to communicate data between early boot and late boot */
>  > +static struct phyp_dump phyp_dump_global;
>  > +struct phyp_dump *phyp_dump_info = &phyp_dump_global;
>
> I don't see the point of this. You have a static (ie. non-global) struct
>  called phyp_dump_global, then you create a pointer to it and pass that
>  around.

I did this. This is a style used to minimize disruption due to future
design changes. Basically, the idea is that, at some later time, for
some unknown reason, we decide that this structure shouldn't
be global, or maybe shouldn't be statically allocated, or maybe
should be per-cpu, or who knows.  By creating a pointer, and
just passing that around, you isolate other code from this change.

I learned this trick after spending too many months of my life hunting
down globals and replacing them by dynamically allocated structs.
Its a long and painful process, on many levels, often requiring major
code restructuring.  Code that touches globals directly is often
poorly thought out, designed.  But going in the opposite direction
is easy: if your code always passes everything it needs as args
to subroutines,  then you are free & clear ... if one of those args
just happens to be a pointer to a global, there's no loss (not even
a performance loss -- the arg passing overhead is about the same
as a global TOC lookup!)

So it may look weird if you're not used to seeing it; but the alternative
is almost always worse.

--linas
