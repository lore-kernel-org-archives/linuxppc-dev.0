Message-ID: <3D010D47.5BEF2E47@motorola.com>
Date: Fri, 07 Jun 2002 14:45:11 -0500
From: Josh Horvath <Joshua.Horvath@motorola.com>
MIME-Version: 1.0
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823E USB controller - delay gates necessary?
References: <3CFFA5AF.DD247938@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To follow up on my original message, it appears that the delay gates are
indeed required for proper host mode operation on the 823e.  Using the
PDIUSBP11A transceiver, we measured about 6-8ns of skew between the single
ended and differential receive lines.  This is apparently too close to the
+8ns limit stated in the MPC850 device errata.

So you may get a lucky transceiver/processor combo that will work, but most
likely you'll need the delay gates on the differential receive pair to get
host mode to work reliably.

-Josh

Josh Horvath wrote:
>
> The device errata for the MPC850 includes the CPM17 bug that states delay
> gates are necessary on the USB pins.  The MPC823E errata sheet does not
> mention this bug.
>
> I recently read the message by Christian Schroeder about getting the USB
> controller working on the TQM823L board (with an 823E processor).  He states
> that the delay gates are necessary.  Is this true?
>
> I've got a custom 823E board that doesn't include these gates and I'm having
> trouble getting the controller working, and it's not totally clear to me if
> it's a hardware or software problem.
>
> Thanks,
> -Josh
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
