Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 608A7B7334
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:33:38 +1100 (EST)
Received: by yxe11 with SMTP id 11so355870yxe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 17:33:37 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1255564276.9651.14.camel@concordia>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<91cec5c64da4ca31a025fc7c45d9f1b93c8b98da.1255499081.git.michael@ellerman.id.au>
	<fa686aa40910141144y1776c476uc8e26e06eb57e6ac@mail.gmail.com>
	<1255564276.9651.14.camel@concordia>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 18:33:17 -0600
Message-ID: <fa686aa40910141733r466f327meab2d52f21618aff@mail.gmail.com>
Subject: Re: [PATCH 6/6] powerpc: Enable sparse irq_descs on powerpc
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2009 at 5:51 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Wed, 2009-10-14 at 12:44 -0600, Grant Likely wrote:
>> Why not make sparse IRQs manditory for all platforms? =A0Is there a
>> performance concern with doing so? =A0From a maintenance perspective,
>> I'd rather see IRQ descs manged in one way only to keep the code
>> simple.
>
> I agree on the maintenance angle. My thinking was we'd run with it
> optional but default y for a release or two, and if no one complains we
> can make it mandatory.
>
> It does make some code paths bigger, and looking up an irq_desc is going
> to take slightly more cycles. I don't think it's a big issue, but I
> thought we should try it for a while before making it mandatory. The
> code has only been tested on x86 and sh as far as I know.

No guts, no glory.  I say throw it into linux-next to give it some
time before the next merge window.  I don't think you'll get any
better results by having it optional for a few releases (in fact, I
suspect that people who do have problems will just end up turning it
off and waiting for someone else to report/fix the problems).  If this
is the direction IRQ handling is going, then just make the change and
force any bugs to be dealt with before the next release.

> ps. thanks for the review

You're welcome.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
