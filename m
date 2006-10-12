Return-Path: <dbolcsfoldi@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id C7CF267B8B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 07:12:27 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so844874pyc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 14:12:26 -0700 (PDT)
Message-ID: <609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
Date: Thu, 12 Oct 2006 14:12:24 -0700
From: "David Bolcsfoldi" <dbolcsfoldi@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
In-Reply-To: <87ac41esap.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

No I did not know that unfortunately, it could have saved me some work.
You are of course right and I'd much prefer to make changes to your driver
instead of writing another one.

I've noticed that in the probe function it tries to get some resources
from the platform_device structure but it looks like that this
operation will always fail unless I add a 'uartlite' platform device
or have I completely misunderstood how platform devices work?

But yes, I will try to add support for the things I need to this
driver instead, most importantly early console support and move the
#defines for register offsets and such into a separate header file per
Grants comment.

Cheers,
David

On 10/12/06, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "David" == David Bolcsfoldi <dbolcsfoldi@gmail.com> writes:
>
> Hi David,
>
> David> here's a set of patches that adds support for Xilinx UART lite
> David> devices. It has been tested on an ML403-FX using xapp902
> David> (ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox
> David> userspace.
>
> I guess you didn't know, but there already exists a uartlite driver!
> It unfortunately didn't made it into 2.6.19-rc1 because Russell
> stopped maintaining serial stuff, but it's in -mm.
>
> It also has an official lanana.org assigned set of device nodes.
>
> I didn't look at your patch yet, but I think it would be more useful
> to add any features missing to my driver than writing yet another
> driver (I think we're up to 3 now).
>
> --
> Bye, Peter Korsgaard
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
