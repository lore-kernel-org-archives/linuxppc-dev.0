Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC446DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:44:39 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5D7iKpx008172
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:44:21 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5D7iJ8O010806
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:20 -0500 (CDT)
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <cad6a9b0bd58df6298cb5f8402e512e7@kernel.crashing.org>
References: <1181717615.9397.40.camel@localhost.localdomain>
	<6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
	<1181718898.12936.6.camel@localhost.localdomain>
	<cad6a9b0bd58df6298cb5f8402e512e7@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181720633.12936.19.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 15:43:53 +0800
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

On Wed, 2007-06-13 at 15:26, Segher Boessenkool wrote:
> >>> +                             printk (KERN_EMERG "Error: reset
> >> control \
> >>> +                                     register not mapped,
> >> spinning!\n");
> >>
> >> ...(... "bla bla bla "
> >>         "bla bla bla\n");
> >>
> >> instead?  Or there'll be a lot of whitespace in your string.
> > I just do not know the difference of these two style.
> 
> Your code puts a bunch of extra whitespace in the string (all
> the tabs before "register not mapped").  Two strings after
> each other (like in my example) are just pasted together.
> 
> There is no real reason to break the string in two anyway, it
> is fine to have a more-than-80-char line in printk messages.
> 
I separate it, because I am afraid I will be  challenged by 80 char
column rule.

Please check the CodeStyle file and its example:

Statements longer than 80 columns will be broken into sensible chunks.
Descendants are always substantially shorter than the parent and are
placed
substantially to the right. The same applies to function headers with a
long
argument list. Long strings are as well broken into shorter strings.
[snip]
void fun(int a, int b, int c)
{
	if (condition)
		printk(KERN_WARNING "Warning this is a long printk with "
						"3 parameters a: %u b: %u "
						"c: %u \n", a, b, c);
	else
		next_statement;
}
[snip]
If it does not matter, I'd like to put them in one line :-).
Roy
