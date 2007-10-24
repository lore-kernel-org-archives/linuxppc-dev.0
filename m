Return-Path: <dmitry.torokhov@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 9EE6BDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 22:56:00 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so185047nfd
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 05:55:58 -0700 (PDT)
Message-ID: <d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
Date: Wed, 24 Oct 2007 08:55:58 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
In-Reply-To: <1193222676.4510.5.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1193222676.4510.5.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johannes,

On 10/24/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> The patch 46249ea60fbb61a72ee6929b831b1f3e6865f024 was obviously done
> without testing on a Geyser 1,

My fault, sorry. However Anton's device has product ID of 90x30B which
is Geyser 1 as far as I understand... But yes, we should not expect
other geysers respond to Geyser 3-specific commands.

>  and I'm a very annoyed that it was
> applied. It causes appletouch to continuously printk:
>
> drivers/input/mouse/appletouch.c: Could not do mode read request from device (Geyser 3 mode)
>
> because the Geyser 1 doesn't respond to that. The patch description also
> states:
>
> > if we see 10 empty packets the touchpad needs to be reset; good
> > touchpads should not send empty packets anyway.
>
> which is *TOTALLY* bogus since Geyser 1 touchpads have no notion of
> empty packets, the simply continuously send measurements. One look at
> the specification would have confirmed that.
>

Is there a way to "plug" these Geysers? Waking up the kernel
continuously is not nice.

-- 
Dmitry
