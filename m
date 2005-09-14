Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FE8B6829B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 00:27:59 +1000 (EST)
Date: Wed, 14 Sep 2005 16:27:46 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050914142746.GA14742@isilmar.linta.de>
References: <20050830024840.GA5381@dmt.cnet>
	<20050901085319.GB6285@isilmar.linta.de>
	<20050914141131.GA6830@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050914141131.GA6830@dmt.cnet>
Cc: linux-kernel@vger.kernel.org,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
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

On Wed, Sep 14, 2005 at 11:11:31AM -0300, Marcelo Tosatti wrote:
> On Thu, Sep 01, 2005 at 10:53:19AM +0200, Dominik Brodowski wrote:
> 
> > > +typedef struct  {
> > > +	u_int regbit;
> > > +	u_int eventbit;
> > > +} event_table_t;
> > 
> > No typedefs, please.
> 
> OK, I've converted it to a plain "struct".

Thanks.

> I think this code is just following PCMCIA style:
> 
> typedef struct pccard_mem_map { 
> 	u_char	map;
> 	u_char	flags;
> 	u_short	speed;
> 	u_long	static_start;
> 	u_int	card_start;
> 	struct resource *res;
> } pccard_mem_map;
>
> Any reason why this typedef and similar ones in ss.h 
> are wanted? 

There's no reason for this being typedef'ed, and it is contrary to the
kernel source CodingStyle. However, all pcmcia code was external at first,
that's why the CodingStyle differs.

> PCMCIA is also using u_xxx "weird data types" extensively.

Unfortunately, yes. However, I'm in the process of adapting it to the kernel
CodingStyle. I don't change something from "u_int" to "unsigned int" just for
the naming of it, though, but when I'm in the same area fixing one thing or
another, I try to take care of it. New structs, like struct pcmcia_device, 
already adhere the normal kernel policy on structs and typedefs.

Thanks,
	Dominik
