Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-ID: <3BE9BD14.FD9D9DA8@midrivers.com>
Date: Wed, 07 Nov 2001 16:00:36 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: list <linuxppc-embedded@lists.linuxppc.org>
Subject: 405GP interrupts tip and looking for a little console help
References: <3BE7E505.DC9DE6E8@laposte.net> <3BE82BF7.5010207@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm bringing up the _devel kernel on a custom ppc405 board and
wanted to offer a little tip which might save some of you some
time.

if your boot rom doesn't have much to do w/ interrupts (and mine
doesn't) nothing will set the UIC polarity register so that the
UIC responds correctly to on-chip interrupts.  I mention the boot
rom as it seems linux depends upon this setup happening upstream
of it.

In my case, failing to set all the UIC_PR bits for on-chip peripherals
to 1 meant I kept getting unexpected interrupts.  the first
occasion of this was initing the ethernet controller ...

in any case, write the correct value for your processor to
DCRN_UICPR -- w/ a mask of 1s for each on-chip peripheral.

AND I'd appreciate a little help on getting my console to
talk w/ me -- I boot, mount a remote target filesystem w/ nfs,
and get console messages right up to:

NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Looking up port of RPC 100003/2 on
192.168.200.4
Looking up port of RPC 100005/1 on
192.168.200.4
VFS: Mounted root (nfs
filesystem).
Freeing unused kernel memory: 56k
init
echo
*
^^^^^^----- I typed this last line and it echo'd,
I passed in a command init=/sbin/sash, but don't get its prompt,

I debugged it to the point of seeing the exec of /bin/sash,
and would appreciate any views as to what I've forgotten here.

thanks,

Mark

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
