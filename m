Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D3E91E6.4000500@esd-electronics.com>
Date: Wed, 24 Jul 2002 13:39:18 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: How to get rid of unused data in LKM
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am writing a LKM that contains a huge constant array of data that is used
as firmware for a PCI card that is connected to the system where the LKM is loaded.

The module_init function writes the constant data array into the PCI card's RAM and triggers
a CPU on that card to jump to the firmware code. This works fine.

But after doing so, the firmware data is still wasting kernel memory on the host system
and is not used anymore.
How can I free that memory ? Is there a better way to handle that data ?
Currently I have a global variable in my module code:

unsigned char firmware[] = { ..., .... ,.... about 1.4 Meg, ...}

The firmware data (about 1.4 Meg) must be linked with the LKM.

Any idea ?

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
