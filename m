Return-Path: <kallepokki@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id 58F2667BD9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 22:52:08 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id z31so1351425nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 03:52:03 -0800 (PST)
Message-ID: <a425f86c0610310352w1cdf7e20l438b098f109bebde@mail.gmail.com>
Date: Tue, 31 Oct 2006 13:52:03 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
In-Reply-To: <200610311124.46698.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4537A263.3010104@fabiotec.com>
	<a425f86c0610191207i3a9977c9ree3f66cbfb52950e@mail.gmail.com>
	<200610311124.46698.laurent.pinchart@tbox.biz>
Cc: Boris Shteinbock <boris@fabiotec.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/31/06, Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:
> Ditto. Your patch fixed my problems. I'd like to see a fix (either this one or
> another one, there are different solutions) pushed upstream soon, as the
> problem is quite serious. I'm quite amazed nobody had ever reported it
> before.

I think cpm_uart_startup() is the right place to enable both
transmitter and receiver, since they are disabled in the corresponding
shutdown() function. Or actually, one might be just fine with never
disabling the hardware at all. I can't see any reason other than power
consumption that they are disabled by the shutdown() function.

It seems the reason of not enabling the transmitter at startup() is
that the serial core specification only states that reception should
be enabled with that function call. However enabling also the
transmitter does not by itself initiate any transmissions, so it
should be just fine. It just makes the hardware ready to transmit.
