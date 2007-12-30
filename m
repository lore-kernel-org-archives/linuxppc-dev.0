Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 389FEDDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 11:31:11 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2098310uge.0
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 16:31:10 -0800 (PST)
Date: Sun, 30 Dec 2007 03:20:28 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
Message-ID: <20071230002028.GA14724@zarina>
References: <11970422334145-git-send-email-timur@freescale.com>
	<20071226165004.GA11449@localhost.localdomain>
	<4776C518.6060002@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4776C518.6060002@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <AFLEMING@freescale.com>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 29, 2007 at 04:07:20PM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >> +		firmware {
> >> +			id = "Soft-UART";
> >> +			extended_modes = <0 0>;
> >> +			virtual_traps = <0 0 0 0 0 0 0 0>;
> > 
> > I believe using underscores for the property name is discouraged.
> 
> Ugh, this one change would require me to repost all my patches.  Oh 
> well.  I wish someone else had noticed it before I got to version 5.

Yeah, sorry about that.

But you know it, reviewing is tedious, and only few of us are doing
reviews for the code they don't use.

I've started to use this code just now, so I reviewed it on the way.

> I'll post a new version on January 7, when I get back to the office.
> 
> >> +A Python program that creates firmware binaries from the header files normally
> >> +distributed by Freescale can be found on http://opensource.freescale.com.
> > 
> > Hm... I didn't find it there. Could you provide more specific pointer?
> 
> I'll add those files only after my patches have been applied.  The 
> layout may change between now and then, and I don't want to have to 
> repost the firmware.
> 
> >> +
> >> +	/*
> >> +	 * If we haven't checked yet, and a driver hasn't uploaded a firmware
> >> +	 * yet, then check the device tree for information.
> >> +	 */
> >> +	do {
> >         ^^^^
> > This is very unusual method of error handling. You could stick
> > to gotos and lower the indentation level.
> 
> Ok, I'll change it.  I wasn't crazy about it after I wrote it, anyway.
> 
> >> +		qe = of_find_node_by_type(NULL, "qe");
> > 
> > Please, add compatible "fsl,qe" matching, so this code could
> > work with new device trees.
> 
> Ok, but that new design was added after I posted this patch.
> 
> >> +		/* Find the 'firmware' child node */
> >> +		while ((fw = of_get_next_child(qe, fw)))
> >> +			if (strcmp(fw->name, "firmware") == 0)
> >> +				break;
> > 
> > Hmm. Maybe of_find_node_by_name? Or better by compatible.
> 
> What's wrong with looking for the firmware node inside the QE node? 
> That's the only place it can be?

Ah, I see it now. Revoking my comment.

> >> +		iprop = of_get_property(fw, "extended_modes", NULL);
> > 
> > Checking for size?
> 
> Ok.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
