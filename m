Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AFB8DDF2C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 01:24:06 +1100 (EST)
In-Reply-To: <20070124103621.GA22579@iram.es>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
Date: Wed, 24 Jan 2007 15:23:47 +0100
To: Gabriel Paubert <paubert@iram.es>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I believed that the patch also worked on desktops. Of course, one
> solution is to try to reset time from an NTP server on resume if you
> are connected (if you are not, then an error of a fraction of a second
> is less serious).

A fraction of a second is *never* serious, except with
broken apps ;-)

> The best solution may require informing the user space ntp code of
> such events. This requires very likely modifications to ntp itself
> (I may be wrong, I've not looked at NTP code for 5 years or so).

Doesn't the kernel send signals to init on suspend/resume
events, just like with power fail events?  You can hook on
that.


Segher
