Message-ID: <3988F65E.9DBBAF68@home.com>
Date: Wed, 02 Aug 2000 21:34:38 -0700
From: William Blew <wblew@home.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-t5 lockup on shutdown.
References: <200008022120.WAA28609@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> Does anyone know the cause of the (sometimes) complete lock-up of 2.4.0-t5
> when shutdown & restart is selected from run level 5?
>
> Observations/Symptoms:
>
> the switch of VC occurs OK
> Then *zilch*.  No panic, no response to SysRq keys... no response to
> telnet...  three finger salute is the only way I've found out of it.

It does sound familiar. I have found that occasionally (under high IDE?
loads
like digital audio CD ripping) the CUDA (VIA under 2.2) interrupt ceases
(as
in its /proc/interrupts counter stops increasing). Under these
circumstances
my beige G3/266's ADB bus has stopped at the software level as it is
handled
by the CUDA (noted as the VIA interrupt with 2.2 on my beige G3/266).

The symptoms that I observe are identical: An otherwise healthy mac
ignores
its keyboard completely (until the three finger salute is used).

I diagnosed my situation by ssh'ing in from another workstation and
watching
the /proc/interrupts file while ripping a digital audio CD.

I find that my bug is fairly easy to create on my beige G3/266. Just rip
a
cd with the grip under helix-gnome and wait. Anywhere from 1 to 11
tracks
layer, the VIA (CUDA) interrupt dies *grin*.

Another side effect of this interrupt failure is that the
'reboot/shutdown'
commands do not work. After all they are also via the CUDA on my G3. So,
when I reboot via ssh the G3 'hangs' at right at the end of the shutdown
sequence.

Be warned: my bug may be a red herring and unrelated to your issue. On
the
other hand... (isn't debugging fun?).

> bk-tree  (linuxppc_2_3) as of 19:00 (BST) today. (but it's been happening on
> & off with the 2.4.0 tree since I've been trying it).
>
> Iain.
>

--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
