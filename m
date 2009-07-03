Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ED876B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jul 2009 07:06:50 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8532ADDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2009 07:06:50 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Brad Boyer <flar@allandria.com>
Subject: Re: Inline assembly queries [2]
References: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
	<20090703174031.GA12410@cynthia.pants.nu>
Date: Fri, 03 Jul 2009 22:57:12 +0200
In-Reply-To: <20090703174031.GA12410@cynthia.pants.nu> (Brad Boyer's message
	of "Fri, 3 Jul 2009 10:40:31 -0700")
Message-ID: <m23a9deb87.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	kernel mailz <kernelmailz@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brad Boyer <flar@allandria.com> writes:

> On Fri, Jul 03, 2009 at 12:14:41PM +0530, kernel mailz wrote:
>> b. using m or Z  with a memory address. I tried replacing m/Z but no change
>> Is there some guideline ?
>> gcc documentation says Z is obsolete. Is m/Z replaceable ?
>
> No idea. I don't remember ever seeing 'Z' used in anything. Maybe somebody
> else remembers what it used to mean.

The 'Z' constraint is required for a memory operand for insns that don't
have an update form (which would be selected by the %U modifier).  It
should only be used together with the %y operand modifier, which makes
sure that the first register is never 0.  If the 'm' constraint were
used the operand could contain a pre-in/decrement operation, and without
%U the side effect would be lost.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
