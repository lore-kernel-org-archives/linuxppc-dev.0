Message-Id: <5.1.0.14.2.20030604084903.020ea290@falcon.si.com>
Date: Wed, 4 Jun 2003 08:54:07 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: RE: Failsafe bootloader
In-Reply-To: <00048177.C22236@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:33 AM 6/4/2003 -0400, Darin.Johnson@nokia.com wrote:

> > Of course, this still doesn't protect you from loading a new
> > bootrom that
> > has a valid checksum but a fatal problem (doh-doh-doh).
> > Fortunately, in
> > that case the idiot is ourselves and we deserve the pain involved, and
> > hopefully learn from it ;-).
>
>The problems we had were first that upgrades could be done
>transparently without the user knowing, so you can't
>really protect from the user unplugging (though we were
>supposed to be an always-on-don't-turn-off product).
>Second, have an image with a good checksum that boots
>up ok is only part of the story, we have to make sure that
>it can communicate correctly on its network.  Ie, the application
>software has to communicate to the boot loader that the new
>image can be kept.
>
>Also from experience, I've really lost a lot of hair in
>situations with other products that say "do not turn off the
>power until this update is finished", only to have the product
>crash, or the computer that is talking to it crashes.

Yes, you REALLY need enough storage to have two copies: the working copy
and the new copy.  The bootrom must NEVER erase the working copy until the
new copy is verified to be completely and correctly loaded (checksums are a
pretty weak validation, CRCs are strongly preferred).

If you are trying to upload a new image in-place, your window vulnerability
(mentioned in my previous email) goes from the amount of time that it takes
to erase and reprogram a block of flash to the time it takes to upload a
program: typically this means going from hundreds of milliseconds
(reasonable risk) to hundreds of SECONDS (extremely high risk).

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
