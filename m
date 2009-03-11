Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 1A7ACDDF70
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 04:10:55 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so346533ywb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 10:10:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1236731097.7086.32.camel@pasglop>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
	<1236731097.7086.32.camel@pasglop>
Date: Wed, 11 Mar 2009 11:10:54 -0600
Message-ID: <fa686aa40903111010l7bd7e2f8r47c7d42184d0a36a@mail.gmail.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 6:24 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-03-10 at 19:22 -0500, Timur Tabi wrote:
>>
>> Alan did have one valid point though. =A0Determining how long to loop
>> for is architecture-specific. =A0Using jiffies is bad, because even one
>> jiffy is too long. =A0Adding a udelay() inside the loop means that it
>> only checks he condition every microsecond. =A0So the real solution is
>> to use keep looping until a certain amount of time has passed. =A0This
>> means using an architecture-specific timebase register.
>
>> Now we can create a generic version of the function that uses jiffies,
>> and then arch-specific versions where possible. =A0But Alan still needs
>> to be convinced. =A0I already posted a length rebuttal to his email, but
>> I haven't gotten a reply yet.
>>
> There are several aspects here:
>
> =A0- The amount of time to wait should be specified by the caller since
> it's generally going to come from HW specs
>
> =A0- The amount of time between the polls ... that could also be an
> argument to the macro, not sure there
>
> =A0- The precision of the actual wait calls... I vote for microseconds fo=
r
> everything and udelay. The arch will do its best.

No, not udelay.  Or any delay for that matter.  If spinning on a
condition, then there is no advantage to burning cycles with a
udelay().  Those cycles may as well be used to keep testing the
condition so the loop can be exited faster.  a udelay() would only
serve to always make the busywait longer.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
