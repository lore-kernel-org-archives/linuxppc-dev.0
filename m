Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id 6E46867B59
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 03:00:37 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i20so603724wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 10:00:35 -0700 (PDT)
Message-ID: <a0bc9bf80608291000m5d444709h965a4b436724a937@mail.gmail.com>
Date: Wed, 30 Aug 2006 01:00:35 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Esben Nielsen" <nielsen.esben@gogglemail.com>
Subject: Re: atomic operations in user space
In-Reply-To: <Pine.LNX.4.64.0608291804260.22067@frodo.shire>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <a0bc9bf80608290637q165d1f54x2d80e771671c894f@mail.gmail.com>
	<Pine.LNX.4.64.0608291804260.22067@frodo.shire>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/30/06, Esben Nielsen <nielsen.esben@gogglemail.com> wrote:
>
>
> On Tue, 29 Aug 2006, Li Yang wrote:
>
> >> This is exactly how it is supposed to work! That's why there is a loop
> >> in the atomic increment - you check if you still had the reservation
> >> after the transaction by checking the result from the stwcx, and if not,
> >> retry.
> >
> > I surely know all the theories you mentioned clearly.  But please do
> > look at the case I gave.  Correct me if I missed anything.  Thanks
> >
> > All the lwarx and stwcx operate on the same address.
> >
> >> Task A               Task B
> >> lwarx
> > // Get RESERVATION
> >>                      ......
> >>                      lwarx
> >>                      stwcx
> >
> > // RESERVATION cleared
> >>
> >>                      .....
> >>                      .....
> >>                      lwarx
> >
> > // Get RESERVATION again
>
> Now we do a task switch involving atomic operations, and thus an
> reservation on another address.
>

This makes sense for me.
