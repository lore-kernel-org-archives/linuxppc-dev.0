Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: lost interrupt
Date: Wed, 28 May 2003 23:22:59 -0400
References: <200305262341.59883.ppc339@vtnet.ca>
In-Reply-To: <200305262341.59883.ppc339@vtnet.ca>
MIME-Version: 1.0
Message-Id: <200305282322.59223.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 26, 2003 11:41 pm, Trevor Woerner wrote:
> I'm getting the dreaded "lost interrupt" whenever the kernel tries to
> access my onboard CF card.

It gets a bit stranger, but I think I'm onto something. I'll try to
confirm this in the next day or so, but it appears on the surface that
my device doesn't give an interrupt between the transfer of each
segment in a multi-segment transaction.

I enabled the debug statements in 'ide-disk.c' and what I found is that
sometimes I receive interrupts and Linux is happy, and other times I
don't. After thinking about it a little bit I believe the times I got
interrupts were when single segments at a time were being read (ATA
command 0x20) and when I didn't get interrupts were when multi-segment
reads (still command 0x20 but with number of sectors > 1) were
performed.

	Trevor

kernel: 2.4.20-rc1
cpu: PPC405gp
device: SanDisk 16MB CF

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
