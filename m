From: "gguevel" <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Blocking functions and interrupt protection
Date: Mon, 28 Jan 2002 19:29:37 +0100
Message-ID: <000001c1a829$be44f400$3101a8c0@DOMAIN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I works on an embedded linux ppc pci target board in a linux PC.

I have a process on the PC  which sends ioctl commands to the target via a
write
in a pci doorbell register then sleeps on. The target must reply with a pci
interrupt.

The problem is that the target replies so fast that if the process is
interrupted between the
doorbell write function and the sleep function, the interrupt event from the
target may try to
awake a process which is not sleeping. The event is lost and the ioctl
command is locked
forever.

How can I protect the process to be interrupted between the start of the
doorbell write
function and the end of the sleep function.

This problem is a general case, not specific to my driver. It may happen in
all drivers wich
communicates with fast board which generates asynchronous interrupt events.

Any help would be welcome.

Thanks
Sorry for my poor english language.

Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
