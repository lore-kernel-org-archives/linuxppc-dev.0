Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 616E967A70
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 04:41:40 +1100 (EST)
Date: Thu, 17 Mar 2005 10:41:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050317174137.GH8345@smtp.west.cox.net>
References: <20050316221152.GZ8345@smtp.west.cox.net>
	<a74c02a8aa54e529b296eeac31bdec4e@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a74c02a8aa54e529b296eeac31bdec4e@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: building ppc_htab?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2005 at 11:34:14AM -0600, Kumar Gala wrote:
> 
> On Mar 16, 2005, at 4:11 PM, Tom Rini wrote:
> 
> >On Wed, Mar 16, 2005 at 12:57:24AM -0600, Kumar Gala wrote:
> >
> >> Is there any reason not to make the following change so we build
> >> ppc_htab only on PPC STD MMU?? This would also require fixing up
> >> fs/proc/proc_misc.c.
> >
> >I could have sworn, but maybe my memory sucks, that we no longer messed
> >w/ fs/proc/proc_misc.c for any of the PPC-specific things (since in 2.6
> > you can do all of that proc magic in your 'driver').? So this patch
> > would make a great deal of sense to do, and if it lacks what I'm 
> >talking
> > about, we should do that part as well :)
> 
> I'm not exactly clear on what you are talking about.  There is this 
> snippet in fs/proc/proc_misc.c:

Crap :(

> #ifdef CONFIG_PPC32
>         {
>                 extern struct file_operations ppc_htab_operations;
>                 entry = create_proc_entry("ppc_htab", S_IRUGO|S_IWUSR, 
> NULL);
>                 if (entry)
>                         entry->proc_fops = &ppc_htab_operations;
>         }
> #endif
> 
> Are you suggesting this should live elsewhere?  I'm not that familiar 
> with proc code.

Yes, it should live in ppc_htab.c.  See the CONFIG_SYSCTL stuff already
in ppc_htab.c for l2crvec.

-- 
Tom Rini
http://gate.crashing.org/~trini/
