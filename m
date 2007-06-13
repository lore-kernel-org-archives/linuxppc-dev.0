Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1FB4DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:47:59 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5D7lsCG022344
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:47:54 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5D7lq6K001173
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:47:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 15:49:44 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2AC84@zch01exm26.fsl.freescale.net>
In-Reply-To: <1181720633.12936.19.camel@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Zang Roy-r61911" <tie-fei.zang@freescale.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On Behalf
Of
> Zang Roy-r61911
> Sent: Wednesday, June 13, 2007 3:44 PM
> To: Segher Boessenkool
> Cc: linuxppc-dev list; Paul Mackerras
> Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
>=20
> On Wed, 2007-06-13 at 15:26, Segher Boessenkool wrote:
> > >>> +                             printk (KERN_EMERG "Error: reset
> > >> control \
> > >>> +                                     register not mapped,
> > >> spinning!\n");
> > >>
> > >> ...(... "bla bla bla "
> > >>         "bla bla bla\n");
> > >>
> > >> instead?  Or there'll be a lot of whitespace in your string.
> > > I just do not know the difference of these two style.
> >
> > Your code puts a bunch of extra whitespace in the string (all
> > the tabs before "register not mapped").  Two strings after
> > each other (like in my example) are just pasted together.
> >
> > There is no real reason to break the string in two anyway, it
> > is fine to have a more-than-80-char line in printk messages.
> >
> I separate it, because I am afraid I will be  challenged by 80 char
> column rule.
>=20
> Please check the CodeStyle file and its example:
>=20
> Statements longer than 80 columns will be broken into sensible chunks.
> Descendants are always substantially shorter than the parent and are
> placed
> substantially to the right. The same applies to function headers with
a
> long
> argument list. Long strings are as well broken into shorter strings.
> [snip]
> void fun(int a, int b, int c)
> {
> 	if (condition)
> 		printk(KERN_WARNING "Warning this is a long printk with
"
> 						"3 parameters a: %u b:
%u "
> 						"c: %u \n", a, b, c);
> 	else
> 		next_statement;
> }
It will be good if you do:
+				printk (KERN_EMERG "Error: reset
control"
+					"register not mapped,
spinning!\n");

Instead of:
+				printk (KERN_EMERG "Error: reset control
\
+					register not mapped,
spinning!\n");

- Leo
