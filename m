Return-Path: <mlcreech@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 1DBD9DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 09:22:26 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1657107yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 15:22:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49D28A7E.2090703@mlbassoc.com>
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
	<49D280E0.9020701@mlbassoc.com>
	<5ee96a840903311403r331943d2wf9dbb16491f6bc3@mail.gmail.com>
	<49D28A7E.2090703@mlbassoc.com>
Date: Tue, 31 Mar 2009 18:22:24 -0400
Message-ID: <5ee96a840903311522t10af5c64n53ab6f834ad475ff@mail.gmail.com>
Subject: Re: MPC83xx console : no output after handover
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
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

On Tue, Mar 31, 2009 at 5:26 PM, Gary Thomas <gary@mlbassoc.com> wrote:
>
> The fact that you get the ttyS1 line printed is interesting. =A0At
> this point, the kernel is switching from raw console I/O (only
> suitable for bring-up messages) to the general serial driver
> (interrupt driven, etc). =A0I'm curious about what the ttyS1 driver
> is causing to break...
>
> A couple of things you could try:
> =A0* Disable ttyS1 (take it out of your device tree)

I tried taking ttyS1 out - the results are no different (other than
the fact that "console handover" is now the last line that prints).
My debug printk()s at the end of 8250_init() show up, which would seem
to imply that ttyS0 was initialized correctly, so I'm not sure what
else could be stomping on it.

> =A0* Look at the console log when this happens. =A0Look in your system
> =A0 =A0map for the symbol '__log_buf', e.g.
> =A0 =A0 =A0 c031ca54 b __log_buf
> =A0 =A0This will get stored at physical location '0x31ca54' and will
> =A0 =A0often contain data that didn't get a chance to print, for example
> =A0 =A0if you have stuck interrupts that prevent the console from working=
.
> =A0 =A0I'd just run it to this point and then examine the memory - either
> =A0 =A0using a BDI if one is attached, or press RESET (I hope you have on=
e!)
> =A0 =A0and then look using your boot loader (uBoot, RedBoot, ...)
>

I think I can get my hands on a BDI tomorrow, so I'll give this a try
then.  Thanks for the reply

--=20
Matthew L. Creech
