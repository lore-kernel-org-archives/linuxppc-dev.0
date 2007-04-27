Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83A68DDFBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:34:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 12:34:42 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F2@MERCURY.inside.istor.com>
In-Reply-To: <46324428.7070401@ru.mvista.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> transmit and 20 for receive.

> A 'cat /proc/interrupts' shows the 1st TSEC transmit as 93 and the
> receive as 94, so I am puzzled how we get from 19 to 93 for the
transmit
> and from 20 to 94 for the receive. Perhaps understanding this will
help

   I'd suspect you also have CPM on this SoC (or have CONFIG_CPM*
wrongly enabled?).

> me figure out what number to put into the pci_dev structure for
external
> IRQ0.

   Could you post your /proc/interrupts?

 > Charles Krinke

WBR, Sergei

Dear Sergei:

Here is the result of /proc/interrupts

root@sff1:~# cat /proc/interrupts
           CPU0
  2:          0   i8259     Edge      82c59 secondary cascade
 32:          0   CPM2 SIU  Level     ichar
 93:      10701   OpenPIC   Level     enet_tx
 94:      13945   OpenPIC   Level     enet_rx
 98:          0   OpenPIC   Level     enet_error
106:        542   OpenPIC   Level     serial
107:          0   OpenPIC   Level     i2c-mpc
110:          0   OpenPIC   Level     cpm2_cascade
128:          0   OpenPIC   Level     <NULL>
BAD:          0
root@sff1:~#

The current issue is understanding how enet_tx, enet_rx & serial get to
be 93, 94 & 106 respectively. Once I understand that, I may have a clue
how to deal the one labelled ichar, which is the one that doesn't quite
work. This is a PCI chip our company designed.

Charles Krinke
