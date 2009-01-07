Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7A5B247797
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:50:56 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 23:50:54 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090107225054.23010@gmx.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 7 Jan 2009 13:07:18 -0600
> Von: Scott Wood <scottwood@freescale.com>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne

> On Wed, Jan 07, 2009 at 02:54:57PM +0100, Gerhard Pircher wrote:
> > +void amigaone_show_cpuinfo(struct seq_file *m)
> > +{
> > +	struct device_node *root;
> > +	const char *model = "";
> > +
> > +	root = of_find_node_by_path("/");
> > +	if (root)
> > +		model = of_get_property(root, "model", NULL);
> > +	seq_printf(m, "machine\t\t: %s\n", model);
> > +
> > +	of_node_put(root);
> > +	return;
> 
> This is already printed by the generic cpuinfo.
I'll remove that. Is a vendor or machine entry actually required?
IIRC the debian-installer parses the machine entry.

> > +void __init amigaone_setup_arch(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	/* Initialization until calibrate_delay() runs. */
> > +	loops_per_jiffy = 50000000/HZ;
> 
> Is this really necessary?
Don't think so. It's a leftover from the CHRP setup code.

> > +	/* Flush and disable I/D cache. */
> > +	__asm__ __volatile__ ("mfspr	3, 1008"	::: "r3");
> > +	__asm__ __volatile__ ("ori	5, 5, 0xcc00"	::: "r5");
> > +	__asm__ __volatile__ ("ori	4, 3, 0xc00"	::: "r4");
> > +	__asm__ __volatile__ ("andc	5, 3, 5"	::: "r5");
> 
> Don't do this; instead, have one multi-line asm statement (or better yet,
> just use mfspr()/mtspr()/sync()/isync()).
> 
> GCC is perfectly free to trash your registers in between statements.
Okay, I'll try to rewrite it with mfspr() and friends (I don't understand gcc's
assembler syntax yet).

Thanks!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
