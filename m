Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linas@austin.ibm.com
Subject: Re: can't write
Date: Fri, 30 May 2003 07:09:59 -0400
References: <200305282319.27041.ppc339@vtnet.ca> <20030529100632.A22378@forte.austin.ibm.com>
In-Reply-To: <20030529100632.A22378@forte.austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <200305300710.00024.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 29, 2003 11:06 am, you wrote:
> On Wed, May 28, 2003 at 11:19:27PM -0400, Trevor Woerner wrote:
> > contains are zeros.
>
> presumably, you tried two different cards & controllers, to rule out
> a hardware failure?

Thanks for your help and suggestions!

I discovered the problem with writing yesterday, a byte-swapping issue
was causing the LBA address to be inserted into the registers
incorrectly. So it was writing, just not to the sector Linux was
calculating. I'm handling registers 6 and 7 as special cases so the ATA
command was always correct, but not the LBA address!

As you suggested, a hardware issue was at the heart of the "lost
interrupt" problem I was getting. A CF card manufactured by Canon
worked perfectly with no interrupt problem, SanDisk CF cards (as well
as Kingston) don't appear to generate interrupts between the transfer
of each sector in a multi-sector read or write. I think there's a
setting (ATA command) I can look into, and I think there's something in
the 'ide_drive_t' structure to play with (two members starting with
"mult_"). I could also modify the code to create N single sector
read/writes from single read/writes of N sectors.

So everything appears to be working fine, thanks for everyone's help!!

	Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
