From: gopi@india.tejasnetworks.com
Date: Thu, 21 Feb 2002 17:34:49 +0000 (GMT)
To: Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unable to write to SIMASK
In-Reply-To: <02022018275201.01017@scop.digitel.com.br>
Message-ID: <Pine.LNX.4.21.0202210948300.26384-200000@tn100build.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809023-319490387-1014312889=:26531"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463809023-319490387-1014312889=:26531
Content-Type: TEXT/PLAIN; charset=US-ASCII

hi..

I tried the simple code attatched with this mail:

complied using:
ppc_8xx-gcc -c -D__KERNEL__ -DMODULE -O2 -Wall myMpc.c

Then, on the target board:

>  insmod myMpc.o ; rmmod myMpc
read0 = 3eed0000, read1 = 1eed0000, read2 = 1eed0000
(above was the output of printk from the driver)

> insmod myMpc.o ; rmmod myMpc
read0 = 3eed0000, read1 = 1eed0000, read2 = 1eed0000
(read0 is again 3eed0000 implying the original value is restored)

> insmod myMpc.o ; rmmod myMpc
read0 = 3eed0000, read1 = 1eed0000, read2 = 1eed0000

So, it looks like when we go out of the driver(exit from system call),
the value of simask is being restored by some code in the kernel.

I understand that this is not a good way of enabling/disabling
irqs(better use request_8xxirq etc..), but I thought this should work.

gopi


On Wed, 20 Feb 2002, Ricardo Scop wrote:

> On Wednesday 20 February 2002 21:53, gopi@india.tejasnetworks.com wrote:
> > hi..
> >
> >   We have an MPC860T based custom board.
> >
> >   We wanted to control interrupt on one of the irqs by writing to SIMASK
> > register using a small driver with two ioctls which will will do
> > the following:
> >
> >   // WRITE_MASK_IOCTL
> >   simask_write_ioctl(mask) {
> >     cli();
> better use save_flags(flags); cli();
>
> >     (volatile unsigned int *)(IMMR + simask_offset) = mask;
> You're missing a * operator here (don't know about your actual source code,
> though...)
  That was a typing error, it was ok in code.

>
> >     written_value = *(volatile unsigned int *)(IMMR + simask_offset);
> >     sti();
> better use restore_flags(flags)... and flags must be defined as an unsigned
> long.
>
> >     printk (written_value);
> >   }
> >
> >   // READ_MASK_IOCTL
> >   simask_read_ioctl() {
> >     cli(); // Not really needed..
> >     read_value = *(volatile unsigned int *)(IMMR + simask_offset);
> >     sti();
> >     printk (read_value);
> >   }
> >
> >
> <snip>
>
>
> HTH,
>
> R. Scop
>


---1463809023-319490387-1014312889=:26531
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="myMpc.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0202211734490.26531@tn100build.india.tejasnetworks.com>
Content-Description: 
Content-Disposition: attachment; filename="myMpc.c"

I2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KI2luY2x1ZGUgPGxpbnV4L3ZlcnNpb24uaD4NCiNpbmNsdWRl
IDxsaW51eC90eXBlcy5oPg0KI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQoj
aW5jbHVkZSA8bGludXgva2VybmVsLmg+DQojaW5jbHVkZSA8bGludXgvaW50
ZXJydXB0Lmg+DQojaW5jbHVkZSA8YXNtLzh4eF9pbW1hcC5oPg0KDQojZGVm
aW5lIElNQVBfQUREUiAgKCh1aW50KTB4ZmYwMDAwMDApDQoNCmludCBpbml0
X21vZHVsZSh2b2lkKSB7DQoNCiAgICB2b2xhdGlsZSBpbW1hcF90ICppbXAg
PSAoaW1tYXBfdCAqKUlNQVBfQUREUjsNCiAgICB2b2xhdGlsZSBzeXNjb25m
OHh4X3QgKnN5c3AgPSAoc3lzY29uZjh4eF90ICopICYoaW1wLT5pbV9zaXVf
Y29uZik7DQogICAgdW5zaWduZWQgaW50IHJlYWQwLCByZWFkMSwgcmVhZDI7
DQogICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCg0KICAgIHNhdmVfZmxhZ3Mo
ZmxhZ3MpOyBjbGkoKTsNCiAgICAgICAgcmVhZDAgPSBzeXNwLT5zY19zaW1h
c2s7DQogICAgICAgIHN5c3AtPnNjX3NpbWFzayA9IDB4MWVlZDAwMDA7DQog
ICAgICAgIHJlYWQxID0gc3lzcC0+c2Nfc2ltYXNrOw0KICAgIHJlc3RvcmVf
ZmxhZ3MoZmxhZ3MpOw0KICAgIHJlYWQyID0gc3lzcC0+c2Nfc2ltYXNrOw0K
ICAgIHByaW50aygicmVhZDAgPSAleCwgcmVhZDEgPSAleCwgcmVhZDIgPSAl
eFxuIixyZWFkMCwgcmVhZDEsIHJlYWQyKTsNCg0KICAgIHJldHVybiAwOw0K
DQp9DQoNCmludCBjbGVhbnVwX21vZHVsZSh2b2lkKSB7DQogICAgcmV0dXJu
IDA7DQp9DQo=
---1463809023-319490387-1014312889=:26531--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
