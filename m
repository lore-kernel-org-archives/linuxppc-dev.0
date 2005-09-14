Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC4F1682A0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 00:17:14 +1000 (EST)
Date: Wed, 14 Sep 2005 11:11:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@intracom.gr>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20050914141131.GA6830@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet>
	<20050901085319.GB6285@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050901085319.GB6285@isilmar.linta.de>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 01, 2005 at 10:53:19AM +0200, Dominik Brodowski wrote:

> > +typedef struct  {
> > +	u_int regbit;
> > +	u_int eventbit;
> > +} event_table_t;
> 
> No typedefs, please.

OK, I've converted it to a plain "struct".

I think this code is just following PCMCIA style:

typedef struct pccard_mem_map { 
	u_char	map;
	u_char	flags;
	u_short	speed;
	u_long	static_start;
	u_int	card_start;
	struct resource *res;
} pccard_mem_map;

Any reason why this typedef and similar ones in ss.h 
are wanted? 

PCMCIA is also using u_xxx "weird data types" extensively.
