Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D3F2DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 23:00:33 +1000 (EST)
Message-ID: <48468C5A.6030504@semihalf.com>
Date: Wed, 04 Jun 2008 14:36:42 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Jon Loeliger <jdl@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	jdl@jdl.com
Subject: Re: [PATCH] Add support for binary includes.
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>	<20080226003955.GA24382@localhost.localdomain>	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>	<483C4C04.9020408@freescale.com>	<20080528235859.GA10260@yookeroo.seuss>	<20080529000227.GB10260@yookeroo.seuss>	<48404D83.4070108@freescale.com>
	<20080604041304.GD29085@yookeroo.seuss>
In-Reply-To: <20080604041304.GD29085@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, May 30, 2008 at 01:54:59PM -0500, Scott Wood wrote:
>> David Gibson wrote:
>>> What I don't like is the combination of the two.  Using the /word/
>>> form in (1) suggests that each /word/ is a lexically distinct symbol
>>> with functions in different contexts: consider /dts-v1/, /include/,
>>> /memreserve/ - they're all used only in their own distinct context.
>>> Use of /word/s in (2) would suggest that each /word/ is just an
>>> identifier for a different function, and should all be usable in a
>>> similar grammtical context - which won't be true of /memreserve/,
>>> /dts-v1/ and any other truly lexically distinct symbols we need to
>>> add.
>> I don't understand this conclusion -- I wouldn't expect to be able to  
>> use "for" or "while" at file scope of C code, just because I can use  
>> "struct", "int", or "sizeof" there.  The slashes are simply a way of  
>> creating reserved words, some of which happen to be function-like.
> 
> Heh, when I started revisiting this after my long hiatus doing other
> things, I was thinking the same way.  I still have a few misgivings,
> but then the nice thing about the slash-delimited reserved word thing
> is that even if we come up with a new, nicer syntax it's not going to
> hurt to keep the slash-form around for compatibility.
> 
> sizeof is an interesting example.  As you point out it's an example of
> a function-like reserved word, which given our existing approach to
> reserved words supports your syntax.  On the other hand, we may well
> want a sizeof operator in dtc itself as part of our expression
> support, and in that case, the "be like C" principle suggests it
> should be rendered as "sizeof" rather than "/sizeof/".
> 
> But as I said that can be dealt with in the future without breaking
> compatibility.  Objection withdrawn.

Hi,

To add one more point to the discussion: the /incbin/ syntax is being
used in the new image format of U-Boot (we're using dtc with original
patch by Scott Wood, i.e.,
http://www.nabble.com/-PATCH--Add-support-for-binary-includes.-td15596760.html).

If possible, it would be good to have the original syntax preserved once
the feature is merged into the mainline dtc. BTW: any idea on when this
might happen?

Regards,
Bartlomiej
