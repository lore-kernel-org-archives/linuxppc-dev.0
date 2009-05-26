Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 206C4DDFDC
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 02:27:45 +1000 (EST)
Received: by qyk34 with SMTP id 34so6492396qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 09:27:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1C16DF.9090802@freescale.com>
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>
	<4A1C16DF.9090802@freescale.com>
Date: Tue, 26 May 2009 12:27:43 -0400
Message-ID: <9e4733910905260927h3a7bb9fmf6cc3f8d7a1a5624@mail.gmail.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
From: Jon Smirl <jonsmirl@gmail.com>
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 12:20 PM, Geoff Thorpe
<Geoff.Thorpe@freescale.com> wrote:
> Timur Tabi wrote:
>> On Mon, May 25, 2009 at 12:46 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>
>>> I just tried using this. The !rc has the effect of making the error
>>> return be zero instead the normal not zero.
>>
>> You're confused. =A0It's not a "return code", it's a return value. =A0I
>> guess I should have called the parameter "ret" instead of "rc", but I
>> didn't expect people to get confused.
>>
>> 'rc' is the value of the expression when the loop terminates. =A0That's
>> what makes the most sense, because the developer will want to know
>> what that value is. =A0If you're expression happens to rely on negative
>> logic (e.g. wait until a bit is cleared), then of course it's going to
>> appear "backwards" when you test it.
>
> I've just been going through some hassles associated with wait_event
> variants and their return codes.
>
> Eg. wait_event_interruptible()'s return value is documented as; "The
> function will return -ERESTARTSYS if it was interrupted by a signal and
> 0 if @condition evaluated to true." And wait_event_timeout()'s return
> value is; "The function returns 0 if the @timeout elapsed, and the
> remaining jiffies if the condition evaluated to true before the timeout
> elapsed."
>
> In all cases it seems, they don't return the what the expression
> evaluates to, but instead return an indication about the wait outcome.
> This is why I've taken to doing things like;
> =A0 wait_event_***(queue, !(ret =3D try_something()));

That's a good trick, if you want the result of the condition pass the
assignment in.
That frees up the return value to indicate the error of the time out expiri=
ng.

I'd really like to keep a consistent if(rc!=3D0)error; model.

> So from this user's perspective (FWIW), it would come as a surprise if
> the return value reflected the evaluated expression rather than what
> happened w.r.t. the spin/timeout.




>
> Cheers,
> Geoff
>
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
