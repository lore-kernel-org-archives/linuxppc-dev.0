Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C89C@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: [linux-usb-devel] General USB Hub question and 832e question
Date: Fri, 13 Sep 2002 15:54:38 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


FYI:

-----Original Message-----
From: Steve Calfee [mailto:stevecalfee@hotmail.com]
Sent: Thursday, September 12, 2002 8:42 PM
To: Hihn Jason
Subject: Re: [linux-usb-devel] General USB Hub question and 832e
question



At 10:57 PM 9/12/02 +0200, you wrote:
>I'm doing a design on a PPC 832e processor. Slave mode is known to work ok,
>but host mode is iffy. Apparently there is a issue with low-speed USB
>devices. I was wondering if anyone here could answer my question:
>
>If we were to go through a USB hub, would low-speed devices get converted
to
>high speed?
>
>Additionally your experiences with USB on the 823e (and 850) are welcome.
>
>Thank you for your time.
>
>
>----

Hi I wrote a host for the 823 USB circuitry. The 823 usb stuff is just a
very marginal design and therefore a huge amount of work. A single function
host for an embedded system is reasonable, a general purpose host just will
not work with the built in circuitry. I recommend you use an external chip
for host mode.

There should not be a problem with low speed, the 823 would need to change
its bus clock from 12000000 to 1500000. It needs to do this on a very tight
time frame, which is probably the problem..You would have to spin testing
the CPM after a SOF, so you know exactly when to change the clock. This is
just another of its marginal design features.

Hubs do not translate speeds, they prevent low speed devices from seeing
any high speed packets...SOF is sent as just a one bit pulse. The actual
data packets are just sent on through the hub at low speed. The host
actually sends the hub a special packet called a PRE PID, which tells it
and all other high speed devices that a low speed packet is coming.

Regards, Steve

__________________________________________
Steve Calfee    --      embedded systems consultant
stevecalfee@NOSPAMhotmail.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
