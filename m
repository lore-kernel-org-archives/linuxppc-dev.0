Return-Path: <lacombar@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) by ozlabs.org (Postfix) with ESMTP id E5523B71A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 15:47:18 +1100 (EST)
Received: by qyk5 with SMTP id 5so1053074qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 20:47:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1290052544.32570.1.camel@pasglop>
References: <20101025135237.337b8321.sfr@canb.auug.org.au>
	<1287978429-18542-1-git-send-email-lacombar@gmail.com>
	<20101025170322.851780f3.sfr@canb.auug.org.au>
	<1290052544.32570.1.camel@pasglop>
Date: Wed, 17 Nov 2010 23:47:15 -0500
Message-ID: <AANLkTikPsNTYy82GviASbiT3gjnBKynnYUZ9z5c3iObp@mail.gmail.com>
Subject: Re: linux-next: build warning in Linus' tree
From: Arnaud Lacombe <lacombar@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, Jan Beulich <JBeulich@novell.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Nov 17, 2010 at 10:55 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2010-10-25 at 17:03 +1100, Stephen Rothwell wrote:
>> Hi Arnaud,
>>
>> On Sun, 24 Oct 2010 23:47:09 -0400 Arnaud Lacombe <lacombar@gmail.com> w=
rote:
>> >
>> > The following patch should fix this warning.
>>
>> I think the following is preferable. =A0Not tested yet, I will test
>> tomorrow and submit properly then.
>
> I agree. Tho I don't understand the original problem. Both definitions
> have no parenthesis for me and I don't see warnings, or am I missing
> some changes still in -next that cause this ?
>
The warning was caused by part of the following commit which came
through the x86 tree, afaik during the merge window:

       commit 3234282f33b29d349bcada40204fc7c8fda7fe72
       Author: Jan Beulich <JBeulich@novell.com>
       Date:   Tue Oct 19 14:52:26 2010 +0100
       x86, asm: Fix CFI macro invocations to deal with shortcomings in gas

It looks to have been fixed by:

commit 95a2f6f72d37762ba1b3d6c8031f66a6467a63df
Author: David Howells <dhowells@redhat.com>
Date:   Wed Oct 27 17:28:32 2010 +0100

    Partially revert patch that encloses asm-offset.h numbers in brackets

    Partially revert patch:

        commit 3234282f33b29d349bcada40204fc7c8fda7fe72
        Author: Jan Beulich <JBeulich@novell.com>
        Date:   Tue Oct 19 14:52:26 2010 +0100
        x86, asm: Fix CFI macro invocations to deal with shortcomings in ga=
s
[...]

which came in through the mn10300 tree. So if you're no longer seeing
the warning, no ppc specific patch seems to be needed.

 - Arnaud
