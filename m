Return-Path: <linasvepstas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 31F34DDFB9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:34:28 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so4133858pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 10:34:26 -0800 (PST)
Message-ID: <3ae3aa420801081034m172bc25bi85ab755dd8b42f75@mail.gmail.com>
Date: Tue, 8 Jan 2008 12:34:26 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/8] pseries: phyp dump: use sysfs to release reserved mem
In-Reply-To: <20080108144537.39f21cd4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782B985.2090508@austin.ibm.com> <4782C225.3060305@austin.ibm.com>
	<20080108144537.39f21cd4.sfr@canb.auug.org.au>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07/01/2008, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Mon, 07 Jan 2008 18:21:57 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrote:
> >
> > +static int __init phyp_dump_setup(void)
> > +{
> >
> > +     /* Is there dump data waiting for us? */
> > +     rtas = of_find_node_by_path("/rtas");
> > +     dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
>                                                                ^^^^^^^^^^^
> You could pass NULL here as header_len appears to be unused. Also you
> need "of_node_put(rtas)" somewhere (probably just here would do).

Perhaps the routine should have been "of_get_node_by_path()" ?

In ye olden days, "finds" didn't require put, but "gets" did. I'm guessing
that this has now all been fixed up for the of_xxx routines, but I think
that pci_find_xxx still does not require a pci_put.

Why did I bother to write this email? I dunno...
--linas
