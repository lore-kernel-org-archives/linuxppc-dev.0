Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A0BF067A70
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 04:34:20 +1100 (EST)
In-Reply-To: <20050316221152.GZ8345@smtp.west.cox.net>
References: <20050316221152.GZ8345@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <a74c02a8aa54e529b296eeac31bdec4e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 17 Mar 2005 11:34:14 -0600
To: "Tom Rini" <trini@kernel.crashing.org>
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


On Mar 16, 2005, at 4:11 PM, Tom Rini wrote:

> On Wed, Mar 16, 2005 at 12:57:24AM -0600, Kumar Gala wrote:
>
> > Is there any reason not to make the following change so we build
> > ppc_htab only on PPC STD MMU?=A0 This would also require fixing up
> > fs/proc/proc_misc.c.
>
> I could have sworn, but maybe my memory sucks, that we no longer =
messed
> w/ fs/proc/proc_misc.c for any of the PPC-specific things (since in =
2.6
>  you can do all of that proc magic in your 'driver').=A0 So this patch
>  would make a great deal of sense to do, and if it lacks what I'm=20
> talking
>  about, we should do that part as well :)

I'm not exactly clear on what you are talking about.  There is this=20
snippet in fs/proc/proc_misc.c:

#ifdef CONFIG_PPC32
         {
                 extern struct file_operations ppc_htab_operations;
                 entry =3D create_proc_entry("ppc_htab", =
S_IRUGO|S_IWUSR,=20
NULL);
                 if (entry)
                         entry->proc_fops =3D &ppc_htab_operations;
         }
#endif

Are you suggesting this should live elsewhere?  I'm not that familiar=20
with proc code.

- kumar
