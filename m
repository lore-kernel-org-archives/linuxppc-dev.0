To: Liu HongXun-a16975 <a16975@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: how to disable the swap on embedded system? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Sep 2001 15:48:12 +0800."
             <01139FC052A0D411900B00508B9535FC0334D03D@ZCH07EXM04.corp.mot.com>
Date: Mon, 01 Oct 2001 09:00:30 +0200
Message-Id: <20011001070036.09A0A100A2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Rolf,

in message <01139FC052A0D411900B00508B9535FC0334D03D@ZCH07EXM04.corp.mot.com> you wrote:
>
> Because there is no disk support, I wonder if there is also the need
> to use the swap function which load needed page from disk to memory?
> If that swap function is not needed, how I can disable such function for
> linuxppc?

Just do not enable it. As long as you don't announce a swap device to
the kernel (using the "swapon" command) the kernel will  not  attempt
to do any swapping.

> The current version linuxppc on my FADS823 always gives some problems.
> When there is a page fault, the system will halt and oops

This has nothing to do with swapping.

I see two likely causes for this problem:

(1) You are running  with  a  BDM  debugger  attached,  and  did  not
    configure  the  DER register correctly, so that you trap into BDM
    mode  on  each  page  fault.  Make  sure  to  initialize  DER  as
    0x2002000F or similar (i. e. don't trap on page faults).

(2) You have real problems, most probably with your hardware. I  have
    seen a couple of FADS boards that were just broken.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I haven't lost my mind -- it's backed up on tape somewhere.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
