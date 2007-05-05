Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 9564BDDEE9
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 04:43:20 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070504143645.GA10645@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00bf8e702554e7903d92f618ee236528@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Date: Sat, 5 May 2007 13:43:01 -0500
To: Olof Johansson <olof@lixom.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof wrote:

> > +static void ebony_exit(void)
> > +{
> > +     unsigned long tmp;
> > +
> > +     asm volatile (
> > +             "mfspr  %0,%1\n"
> > +             "oris   %0,%0,%2@h\n"
> > +             "mtspr  %1,%0"
> > +             : "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
>
> You don't have to pass in the constants here, you can specify them in
> the asm. Makes it a little more readable.

How?   CPP doesn't apply inside the strings.

Did you mean because these defines were immediately above:

> > +> +#define SPRN_DBCR0           0x134
> > +#define   DBCR0_RST_SYSTEM   0x30000000

could just be comments in the asm?

That works until someone moves them to an include file.

milton
