Date: Thu, 18 Mar 2004 12:11:03 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux and RTAI on the Motorola VME Boards
In-Reply-To: <40597103.3090704@fh-landshut.de>
Message-ID: <Pine.LNX.4.56.0403181202500.4114@mag.sysgo.com>
References: <40597103.3090704@fh-landshut.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 18 Mar 2004, Oliver Korpilla wrote:

> Unfortunately, I didn't find very much documentation on RTAI. I'm
> actually wondering what I need to communicate with the VME bus in
> realtime. Can I safely call the Linux drivers functions? Do I need to
> use a modified version of the driver? What features in a driver do not
> mix with RTAI?

RTAI is a kernel on its own. It has an own scheduler and API to control (eg.
to create threads and allowing them to synchronize with each other).
Therefore an RTAI thread cannot call Linux kernel services.

However, RTAI does share the kernel memory map, so any memory region mapped
by the Linux kernel (or a driver) is also visible to RTAI.

I don't know the VME driver you're about to use, but you should be
able to safely use the VME memory regions it maps.

BTW, you may want to join the RTAI list, where these kinds of
questions are better directed to.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com> | Project Manager

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14 | 55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
