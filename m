Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id B1E20DDF8F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Sep 2007 23:41:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so252327anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Sep 2007 06:41:35 -0700 (PDT)
Message-ID: <fa686aa40709030641w5bc57fd9iac8f4f1d7f4ad648@mail.gmail.com>
Date: Mon, 3 Sep 2007 07:41:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: schardt <g.schardt@fz-juelich.de>,
	"Linux PPC Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Re: Newbie and linux on virtex-II ppc
In-Reply-To: <46DBA4F9.2010703@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46D2C9A5.9030708@fz-juelich.de> <46D4257C.7060208@fz-juelich.de>
	<fa686aa40708280655mf0c08cct43eb9dbd75452690@mail.gmail.com>
	<46D42D40.9040204@fz-juelich.de>
	<fa686aa40708280743i7b3b4ef3g9df015e4be39a9cd@mail.gmail.com>
	<fa686aa40708280744g29cb8e17r6153271cd67117ed@mail.gmail.com>
	<46D53C82.8030308@fz-juelich.de> <46D5753C.70702@fz-juelich.de>
	<fa686aa40708290744w261adfe8ya617a045e4860656@mail.gmail.com>
	<46DBA4F9.2010703@fz-juelich.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/3/07, schardt <g.schardt@fz-juelich.de> wrote:
> Hi Grant,
>
> i added the devices, but stil no tty access
> i have no vga-card or something to use, i'm listening on one serial
> port. i think i must forward the tty to ttyUL0 or something like that ???=
?

You should check that /etc/inittab is using the correct device.

BTW, Please remember to CC: the mailing list

Cheers,
g.
>
> Georg
>
>
> Grant Likely wrote:
> > On 8/29/07, schardt <g.schardt@fz-juelich.de> wrote:
> >
> >> me again :)
> >>
> >> i added a /dev/ttyUL0 (mknod ttyUL0 c 204 187) device and and a consol=
e
> >> link to it.
> >>
> >
> > Yeah, you don't want a symlink, you want a console device node instead:
> >
> > mknod /dev/tty 5 0
> > mknod /dev/console 5 1
> >
> >
> >> no warning anymore, but i think i'm listen on the "wrong" console ??? =
i
> >> see bootmessages
> >> and an errormessage from init ("init: can't open /dev/null: no such
> >> device or directory")
> >>
> >
> > I would say you need to add a /dev/null device node, or fix it's
> > permissions.  :-)
> >
> > mknod /dev/null 1 3
> >
> >
> >> but the messages from init.d/rcS did not appear
> >>
> >> this is my inittab (from klingauf mkrootfs):
> >>
> >> ::sysinit:/etc/init.d/rcS
> >> ::askfirst:-/bin/sh
> >> ::ctrlaltdel:/sbin/reboot
> >> ::shutdown:/sbin/swapoff -a
> >> ::shutdown:/bin/umount -a -r
> >> ::restart:/sbin/init
> >> ::respawn:/sbin/getty 9600 tts/0
> >>
> >> Georg
> >>
> >> schardt wrote:
> >>
> >>> Step by step i becomes running :)
> >>>
> >>> kernel is booting, root-fs is mounting on systemace, busybox compiled
> >>> and rootfs installed (i used klingauf's mkrootfs)
> >>>
> >>> but now it says:
> >>> [    2.964978] Freeing unused kernel memory: 92k init
> >>> [    3.081332] Warning: unable to open an initial console.
> >>> [    3.306406] request_module: runaway loop modprobe binfmt-4c46
> >>> [    3.375612] request_module: runaway loop modprobe binfmt-4c46
> >>> [    3.446800] request_module: runaway loop modprobe binfmt-4c46
> >>>
> >>> and i don't know what this is :(
> >>>
> >>> Can give me a hint, where to look ?
> >>>
> >>> thx
> >>> Georg
> >>>
> >>> Grant Likely wrote:
> >>>
> >>>
> >>>> On 8/28/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>> Okay, im really blind i think, so i started again :
> >>>>>>
> >>>>>> - 2.6.22 kernel from kernel.org
> >>>>>> - cp /arch/ppc/configs/ml300_defconfig .config
> >>>>>>
> >>>>>>
> >>>>>>
> >>>> BTW, "make ml300_defconfig" does this for you.
> >>>>
> >>>> g.
> >>>>
> >>>>
> >>>>
> >>>>
> >>>
> >>> ---------------------------------------------------------------------=
--------------------
> >>> ---------------------------------------------------------------------=
--------------------
> >>> Forschungszentrum J=FClich GmbH
> >>> 52425 J=FClich
> >>>
> >>> Sitz der Gesellschaft: J=FClich
> >>> Eingetragen im Handelsregister des Amtsgerichts D=FCren Nr. HR B 3498
> >>> Vorsitzende des Aufsichtsrats: MinDirig'in B=E4rbel Brumme-Bothe
> >>> Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (s=
tellv.
> >>> Vorsitzender)
> >>> ---------------------------------------------------------------------=
--------------------
> >>> ---------------------------------------------------------------------=
--------------------
> >>> _______________________________________________
> >>> Linuxppc-embedded mailing list
> >>> Linuxppc-embedded@ozlabs.org
> >>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>
> >>>
> >>>
> >>
> >> ----------------------------------------------------------------------=
-------------------
> >> ----------------------------------------------------------------------=
-------------------
> >> Forschungszentrum J=FClich GmbH
> >> 52425 J=FClich
> >>
> >> Sitz der Gesellschaft: J=FClich
> >> Eingetragen im Handelsregister des Amtsgerichts D=FCren Nr. HR B 3498
> >> Vorsitzende des Aufsichtsrats: MinDirig'in B=E4rbel Brumme-Bothe
> >> Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (st=
ellv.
> >> Vorsitzender)
> >> ----------------------------------------------------------------------=
-------------------
> >> ----------------------------------------------------------------------=
-------------------
> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >>
> >
> >
> >
>
>
>
> -------------------------------------------------------------------------=
----------------
> -------------------------------------------------------------------------=
----------------
> Forschungszentrum J=FClich GmbH
> 52425 J=FClich
>
> Sitz der Gesellschaft: J=FClich
> Eingetragen im Handelsregister des Amtsgerichts D=FCren Nr. HR B 3498
> Vorsitzende des Aufsichtsrats: MinDirig'in B=E4rbel Brumme-Bothe
> Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stell=
v.
> Vorsitzender)
> -------------------------------------------------------------------------=
----------------
> -------------------------------------------------------------------------=
----------------
>


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
