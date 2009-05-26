Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 9752BDE0D7
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 13:27:19 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1844639qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 20:27:17 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
Date: Mon, 25 May 2009 22:27:17 -0500
Message-ID: <ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 12:46 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> I just tried using this. The !rc has the effect of making the error
> return be zero instead the normal not zero.

You're confused.  It's not a "return code", it's a return value.  I
guess I should have called the parameter "ret" instead of "rc", but I
didn't expect people to get confused.

'rc' is the value of the expression when the loop terminates.  That's
what makes the most sense, because the developer will want to know
what that value is.  If you're expression happens to rely on negative
logic (e.g. wait until a bit is cleared), then of course it's going to
appear "backwards" when you test it.

-- 
Timur Tabi
Linux kernel developer at Freescale
