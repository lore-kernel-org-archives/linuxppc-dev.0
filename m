Message-ID: <004c01bf642b$a7c8a8a0$0e01a8c0@betamax.azkoul.com>
From: "Brad Douglas" <brad@neruo.com>
To: <khendricks@ivey.uwo.ca>, "Benjamin Herrenschmidt" <bh40@calva.net>,
        "anthony tong" <atong@uiuc.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Fri, 21 Jan 2000 11:22:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----Original Message-----
From: Benjamin Herrenschmidt <bh40@calva.net>

>
>>Okay, I went and looked at the latest aty128fb.c code and it does not use
>>eieio
>>anywhere.  I looked at ealier verions of this file and it at one time had
>>eieio
>>but they have since been removed.
>>
>>I also looked and the endian conversion routines do not use the output
>>contraint approach you took but do include the memory clobber on the
writes.
>
>I just looked at atyfb.c and aty128fb.c in my source tree (atyfb is
>2.2.14 one and aty128fb is the latest backport done by atong) and neither
>uses eieio nor mb(), wmb(), ...
>
>This looks bogus to me. I've spotted a few cases where those calls should
>be in.
>
>We can either put the eieio back in the access functions (less optimal,
>but we can also fix the constraints to get rid of the memory clobber as
>discussed previously), or we can fill the code with carefuly placed mb()
>and wmb() but this requires more knowledge of the chipset than I actually
>have.
>
>I'll put back eieio() in the access macros for my kernels until a
>definitive answer pops up on this issue.


I'm forwarding this to Anthony...

Thanks,

Brad Douglas
brad@neruo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
