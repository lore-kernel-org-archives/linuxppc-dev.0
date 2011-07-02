Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80BA1B6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 20:23:52 +1000 (EST)
Date: Sat, 2 Jul 2011 12:23:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm: Fix memory_block_size_bytes() for
	non-pseries
Message-ID: <20110702102333.GC17482@elte.hu>
References: <1308013071.2874.785.camel@pasglop>
	<20110701121516.GD28008@elte.hu>
	<1309562112.14501.257.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309562112.14501.257.camel@pasglop>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2011-07-01 at 14:15 +0200, Ingo Molnar wrote:
> 
> > > +/* WARNING: This is going to override the generic definition whenever
> > > + * pseries is built-in regardless of what platform is active at boot
> > > + * time. This is fine for now as this is the only "option" and it
> > > + * should work everywhere. If not, we'll have to turn this into a
> > > + * ppc_md. callback
> > > + */
> > 
> > Just a small nit, please use the customary (multi-line) comment 
> > style:
> > 
> >   /*
> >    * Comment .....
> >    * ...... goes here.
> >    */
> > 
> > specified in Documentation/CodingStyle.
> 
> Ah ! Here goes my sneak attempts at violating coding style while 
> nobody notices :-)
> 
> No seriously, that sort of stuff shouldn't be such a hard rule... 
> In some cases the "official" way looks nicer, on some cases it's 
> just a waste of space, and I've grown to prefer my slightly more 
> compact form, at least depending on how the surrounding code looks 
> like.
>
> Since that's all powerpc arch code, I believe I'm entitled to that 
> little bit of flexibility in how the code looks like :-) It's not 
> like I'm GoingToPlayWithCaps() or switching to 3-char tabs :-)

It's certainly not a hard rule - but note that the file in question 
(arch/powerpc/platforms/pseries/hotplug-memory.c) has a rather 
inconsistent comment style, sometimes even within the same function:

        /*
         * Remove htab bolted mappings for this section of memory
         */
...

        /* Ensure all vmalloc mappings are flushed in case they also
         * hit that section of memory
         */

That kind of inconsistency within the same .c file and within the 
same function is not defensible with a "style is a matter of taste" 
argument.

As i said, it's just a small nit.

Thanks,

	Ingo
