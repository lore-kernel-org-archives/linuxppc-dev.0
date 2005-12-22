Return-Path: <siman@bsysjob.sharella.com>
Received: from sharella.com (unknown [221.221.144.125])
	by ozlabs.org (Postfix) with ESMTP id 33CEB68939
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Dec 2005 14:29:26 +1100 (EST)
Received: from xbh ([192.168.0.2]) by bsysjob.sharella.com (bsysjob)
	(MDaemon.PRO.v7.1.0.R) with ESMTP id md50000031896.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Dec 2005 11:13:07 +0800
From: "siman" <siman@bsysjob.sharella.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 22 Dec 2005 11:29:51 +0800
Message-ID: <001b01c606a8$065d0670$1200a8c0@xbh>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <20051222010003.6CEF16895E@ozlabs.org>
Subject: port prpmc610
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi  All:
I am porting linux to  the prpmc610 board, powerpc610 has the ppc5debug
system, I have tried more deconfigs,but failed, The system can not run =
the
kernel  When I execute the kernel, Anybody have any experience to port =
this
system. Please tell me.
Thank you so much.



-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] =B4=FA=B1=ED
linuxppc-embedded-request@ozlabs.org
=B7=A2=CB=CD=CA=B1=BC=E4: 2005=C4=EA12=D4=C222=C8=D5 9:00
=CA=D5=BC=FE=C8=CB: linuxppc-embedded@ozlabs.org
=D6=F7=CC=E2: Linuxppc-embedded Digest, Vol 16, Issue 55

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. Re: [RFC] RTC subsystem (Simon Richter)
   2. Re: [RFC] RTC subsystem (Alessandro Zummo)
   3. Re: [RFC] RTC subsystem (Simon Richter)
   4. [RFC] genalloc !=3D generic DEVICE memory allocator (Andrey =
Volkov)
   5. Re: [RFC] RTC subsystem (Alessandro Zummo)
   6. Re: [RFC] RTC subsystem (Simon Richter)


----------------------------------------------------------------------

Message: 1
Date: Wed, 21 Dec 2005 13:18:25 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] RTC subsystem
To: Alessandro Zummo <azummo-lists@towertech.it>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	lm-sensors@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
	nslu2-developers@yahoogroups.com
Message-ID: <43A94811.4010704@hogyros.de>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hi,

Alessandro Zummo wrote:

>   I've posted a proposal for a new RTC subsystem  on lkml (=20
> http://lkml.org/lkml/2005/12/20/220 ) .

I agree that there is room for improvement. Do you have a specific =
structure
in mind? Specifically,

  - which functions do you believe to be generic,
  - how should multiple RTCs be handled,
  - are read-only (radio controlled) RTCs taken care of?

At present, I don't have time to help the cause, but I can provide =
hosting
for a git tree if desired.

    Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 307 bytes
Desc: OpenPGP digital signature
Url :
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20051221/05aa56=
40/
signature-0001.pgp

------------------------------

Message: 2
Date: Wed, 21 Dec 2005 16:07:12 +0100
From: Alessandro Zummo <azummo-lists@towertech.it>
Subject: Re: [RFC] RTC subsystem
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	lm-sensors@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
	nslu2-developers@yahoogroups.com
Message-ID: <20051221160712.2d322f42@inspiron>
Content-Type: text/plain; charset=3DUS-ASCII

On Wed, 21 Dec 2005 13:18:25 +0100
Simon Richter <Simon.Richter@hogyros.de> wrote:

> >   I've posted a proposal for a new RTC subsystem  on lkml (=20
> > http://lkml.org/lkml/2005/12/20/220 ) .
>=20
> I agree that there is room for improvement. Do you have a specific=20
> structure in mind? Specifically,

 Hi Simon,
  the proposal actually had a fully-working patch attached :)

>   - which functions do you believe to be generic,
>   - how should multiple RTCs be handled,

 In my code, the first rtc that register is bound  to /proc/driver/rtc =
and
/dev/rtc (if those interfaces  are compiled in, as they are all =
selectable).

 The other RTCs are available thru /sys/class/rtc/rtcX  (again, if =
compiled
in).

>   - are read-only (radio controlled) RTCs taken care of?

 You have full control of which functions you will provide  to the upper
layer. Obivously if you try to set the  time on a read-only rtc, you =
will
get an error.

> At present, I don't have time to help the cause, but I can provide=20
> hosting for a git tree if desired.

 Thanks, I'll consider it if the need arises.

--=20

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it



------------------------------

Message: 3
Date: Wed, 21 Dec 2005 17:02:55 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] RTC subsystem
To: Alessandro Zummo <azummo-lists@towertech.it>
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org,
	linuxppc-embedded@ozlabs.org
Message-ID: <43A97CAF.50301@hogyros.de>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hello,

Alessandro Zummo wrote:

>   the proposal actually had a fully-working patch attached :)

Ah, didn't see that, as I just skimmed over the web archive page you =
linked
to, which has no link to the actual patch (or I'm too stupid to find =
it).

>  In my code, the first rtc that register is bound  to /proc/driver/rtc =

> and /dev/rtc (if those interfaces  are compiled in, as they are all=20
> selectable).

It would be good to have a way to change which clock is the "primary"=20
one from userspace later (userspace because this is clearly site =
policy).

>  You have full control of which functions you will provide  to the=20
> upper layer. Obivously if you try to set the  time on a read-only rtc, =

> you will get an error.

Sure. I was thinking of the question which error that should be.

    Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 307 bytes
Desc: OpenPGP digital signature
Url :
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20051221/29bd58=
58/
signature-0001.pgp

------------------------------

Message: 4
Date: Wed, 21 Dec 2005 20:23:28 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Subject: [RFC] genalloc !=3D generic DEVICE memory allocator
To: jes@trained-monkey.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Message-ID: <43A98F90.9010001@varma-el.com>
Content-Type: text/plain; charset=3DKOI8-R

Hello Jes and all

I try to use your allocator (gen_pool_xxx), idea of which is a cute nice
thing. But current implementation of it is inappropriate for a _device_ =
(aka
onchip, like framebuffer) memory allocation, by next reasons:

 1) Device memory is expensive resource by access time and/or size cost.
    So we couldn't use (usually) this memory for the free blocks lists.
 2) Device memory usually have special requirement of access to it
    (alignment/special insn). So we couldn't use part of allocated
    blocks for some control structures (this problem solved in your
    implementation, it's common remark)
 3) Obvious (IMHO) workflow of mem. allocator look like:
 	- at startup time, driver allocate some big
	  (almost) static mem. chunk(s) for a control/data structures.
        - during work of the device, driver allocate many small
	  mem. blocks with almost identical size.
    such behavior lead to degeneration of buddy method and
    transform it to the first/best fit method (with long seek
    by the free node list).
 4) The simple binary buddy method is far away from perfect for a device
    due to a big internal fragmentation. Especially for a
    network/mfd devices, for which, size of allocated data very
    often is not a power of 2.

I start to modify your code to satisfy above demands, but firstly I wish =
to
know your, or somebody else, opinion.

Especially I will very happy if somebody have and could provide to all, =
some
device specific memory usage statistics.

--
Regards
Andrey Volkov



------------------------------

Message: 5
Date: Wed, 21 Dec 2005 18:41:22 +0100
From: Alessandro Zummo <azummo-lists@towertech.it>
Subject: Re: [RFC] RTC subsystem
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Message-ID: <20051221184122.5253df01@inspiron>
Content-Type: text/plain; charset=3DUS-ASCII

On Wed, 21 Dec 2005 17:02:55 +0100
Simon Richter <Simon.Richter@hogyros.de> wrote:

> >   the proposal actually had a fully-working patch attached :)
>=20
> Ah, didn't see that, as I just skimmed over the web archive page you=20
> linked to, which has no link to the actual patch (or I'm too stupid to =

> find it).

 right.. the link was to 0/6 of the patchset, which is
 actually only the introduction. real patch was in subsequent
 messages.

> >  In my code, the first rtc that register is bound
> >  to /proc/driver/rtc and /dev/rtc (if those interfaces
> >  are compiled in, as they are all selectable).
>=20
> It would be good to have a way to change which clock is the "primary"=20
> one from userspace later (userspace because this is clearly site =
policy).

 If I'm not wrong, the RTC is usually queried at bootup
 and written to on shutdown. If NTP mode is active,=20
 it is also written every 11 minutes.

 So my intention was to emulate that interface as a starting
 point. Then we can update the userspace utilities (hwclock)
 to let the user choose which clock he want to use.

 I guess /proc/driver/rtc will be deprecated sooner or
 later. The /dev/rtc interface only supports one clock.
 It can either be extended to have /dev/rtcX or we
 can extend the sysfs one to allow clock updating.

 NTP mode could then be adjusted to update one or more
 of the rtcs. Maybe each RTC could have an attribute
 (let's say /sys/class/rtc/rtcX/ntp) which tells the
 kernel whether to update it or not.
 =20
 This way we will not have a primary clock anymore.

> >  You have full control of which functions you will provide
> >  to the upper layer. Obivously if you try to set the
> >  time on a read-only rtc, you will get an error.
>=20
> Sure. I was thinking of the question which error that should be.

 -EPERM ? -EACCESS? :)

--=20

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it



------------------------------

Message: 6
Date: Thu, 22 Dec 2005 00:18:33 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] RTC subsystem
To: Alessandro Zummo <azummo-lists@towertech.it>
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Message-ID: <43A9E2C9.7080300@hogyros.de>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hello,

Alessandro Zummo schrieb:

>>It would be good to have a way to change which clock is the "primary"=20
>>one from userspace later (userspace because this is clearly site =
policy).

>  If I'm not wrong, the RTC is usually queried at bootup
>  and written to on shutdown. If NTP mode is active,=20
>  it is also written every 11 minutes.

A good ntpd will adjust the speed rather than write to the clock; the
ntpd shipped by most distributions can already handle multiple time =
sources.

I'm thinking of the case where a computer is not attached to a network
but needs accurate tim; in this case I'd give it a battery powered RTC
and a time signal receiver. As most time signals are low-bandwidth, they
may not carry full time information in each tick so it may take several
minutes to fully synchronize. In this case I'd like to use the battery
backed up clock first and switch later on when synchronized.

>  I guess /proc/driver/rtc will be deprecated sooner or
>  later. The /dev/rtc interface only supports one clock.
>  It can either be extended to have /dev/rtcX or we
>  can extend the sysfs one to allow clock updating.

/dev is the way to go IMO. As far as I've understood sysfs, it carries
meta information about devices and drivers only, the actual
communication then happens through device nodes still.

>  NTP mode could then be adjusted to update one or more
>  of the rtcs. Maybe each RTC could have an attribute
>  (let's say /sys/class/rtc/rtcX/ntp) which tells the
>  kernel whether to update it or not.

That's entirely a userspace thing. What the userspace needs to know from
the kernel is whether the clock is writable and whether its speed can be
adjusted.

>  -EPERM ? -EACCESS? :)

-EIO or -ENOSYS would also be possible options.

   Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 374 bytes
Desc: OpenPGP digital signature
Url :
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20051222/00d0d7=
c9/
signature-0001.pgp

------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 16, Issue 55
*************************************************
