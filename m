Date: Mon, 18 Nov 2002 08:11:24 -0700
From: Matt Porter <porter@cox.net>
To: Nageswari S <nageswari@sanyo.co.in>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB - Interrupt problem
Message-ID: <20021118081124.B31148@home.com>
References: <6DF87017DA95D611AC6000606730DE9B1B51D5@BLREXSR>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6DF87017DA95D611AC6000606730DE9B1B51D5@BLREXSR>; from nageswari@sanyo.co.in on Mon, Nov 18, 2002 at 11:56:04AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 18, 2002 at 11:56:04AM +0530, Nageswari S wrote:
> but, there is no change in interrupts when I connect a USB device.
> cat /proc/interrupts output is
>
>
>            CPU0
>   2:     119608  405IAP UIC Edge      NE2000
>  11:          1  405IAP UIC Edge      usb-ohci
>  29:        604  405IAP UIC Edge      keyboard
> BAD:          0
>
> Also, whatever device I connect, it does not get listed in
> /proc/bus/usb/devices
> Could anybody please tell me as to where the problem is regarding the
> interrupts.
>
>
> Any help or suggestion would be very helpful....

Couple options off the top of my head:

1) Check your triggering/polarity for the ohci device.  Are you
   sure the UIC is set correctly for this device?  Is this something
   custom hanging off the ebc?

2) You have a bug in your custom ohci HCI driver which causes it
   to stall before device insertion.  Verify whatever status register
   ohci has that it is still running (I dunno, only know uhci stuffs
   here).

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
