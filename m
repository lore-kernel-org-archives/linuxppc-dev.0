Message-ID: <64110.213.107.143.172.1029538547.squirrel@www.solinno.co.uk>
Date: Fri, 16 Aug 2002 23:55:47 +0100 (BST)
Subject: [RFC][PATCH] Allow PReP boot loader to use OF calls
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This patch, which applies on top of my OF boot loader changes patches,
allows the PReP boot loader to use OF calls again.  I've implemented
it slightly differently to the previous way, and I'll try to explain
my rationale.

The 140 (and presumably all PReP+OF boxes) comes up with machine check
exceptions allowed and the exception table pointing to ram.  Presumablythis is so that of functions can use interrupts and what not.  If a
machine check or any other exception occurs on a prep+of box, the firmware
will catch it and give you a nice easy to debug error message, and you can
dump the registers and so on.  I get quite a few "hung trying to boot"
reports so this would help me enormously.

So, we want to keep this state as long as possible.  To achieve this, I
just don't set it if we have OF (as opposed to switching it back and
forward as was done the old way).  We absolutely must point the exception
table to the ROM before we overwrite it so I do that just before the
gunzip starts.

I have tested the patch on a prep+of box (140) and prep (no of) box (e30),
and  it appears to work fine.

Comments will be gratefully received.

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
