Return-Path: <daniel.ng1234@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 93D75DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 17:47:24 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so275746rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 22:47:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49810367.5000904@consentry.com>
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
	<49810367.5000904@consentry.com>
Date: Thu, 19 Feb 2009 17:47:22 +1100
Message-ID: <547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Mike Ditto <mditto@consentry.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 29, 2009 at 12:16 PM, Mike Ditto <mditto@consentry.com> wrote:
> But I can't explain why the driver isn't attaching for you.  Did you
> try it built-in instead of as a module?
>

Hi Mike et al,

I am trying it built-in at the moment (ie. not as a module).

I've stuck a whole bunch of printks() in. This is what is happening
during boot-up:

1) fs_init() from fs_enet-main.c is called

2) This in turn calls driver_register() with the 'fs_enet' driver

3) This results in a call to bus_add_driver() with the following parameters:
driver = 'fs_enet' driver
bus = 'of_platform' bus

4) Then, driver_attach() is called with 'fs_enet' driver as the parameter

5) driver_attach() calls bus_for_each_dev() with "__driver_attach()"
and the 'of_platform' bus as the relevant parameters

However, __driver_attach() is never called from bus_for_each_dev() ie.
there seems to be no devices on the 'of_platform' bus.

Hence, is there some way to add an appropriate device to the
'of_platform' bus so that __driver_attach() can be called for that
device?

Or, perhaps it is ok for the 'of_platform' bus to have no devices on
it, and so I might be using the wrong bus?? Why would this be?

Or is it something else??

Either way, I still get the following boot error message:

IP-Config: Device `eth0' not found.

-and fs_enet_probe() is NEVER called.

Cheers,
Daniel
