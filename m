Message-ID: <39017.62.252.32.8.1078411893.squirrel@www.chez-thomas.org>
In-Reply-To: <20040304143448.95898.qmail@web10603.mail.yahoo.com>
References: <20040304143448.95898.qmail@web10603.mail.yahoo.com>
Date: Thu, 4 Mar 2004 07:51:33 -0700 (MST)
Subject: Re: Serial ATA driver problem
From: "Gary Thomas" <gary@mlbassoc.com>
To: "sudhakar rajashekhara" <rsudhakar_blr@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sudhakar rajashekhara said:
>
> Hi All,
>
> We have ported u-boot and linux-2.4.22 on to a custom
> POwerPC MPC8280 board. Everything is working fine
> except the Serial ATA driver. We are using SATA150
> Tx2plus serial ata card which sits on PCI. We got the
> driver source code from the public domain. We have
> integrated the driver source code to the kernel and
> driver module loads itself when linux kernel is coming
> up. As soon the module is loaded we get a device
> information string as "aMtxro6 0Y080M". (We have
> tested the same driver on a x86 machine and there the
> driver works perfectly and the device identification
> string got there is "Maxtor 6Y080M0".) After this the
> board comes up correctly. When we try to partition the
> device using the fdisk command (fdisk /dev/sda), we
> get the following errors:

You obviously have an endian-ness problem here.  Don't
forget that the PowerPC is inherently BIG endian and the
PCI bus [devices] are LITTLE endian.  The driver that you
"ported" probably does not take this into account.  Any
place in the driver that accesses quantities larger than
8 bits across the PCI bus will have to be endian aware.

Clean this up and the rest will probably be happy.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
