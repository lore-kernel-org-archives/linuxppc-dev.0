From: Benjamin Herrenschmidt <bh40@calva.net>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound (2.1.27pre10, 2.4.0-test1, 2.4.0-test3)
Date: Wed, 12 Jul 2000 23:12:26 +0200
Message-Id: <20000712211226.3228@192.168.1.10>
In-Reply-To: <200007121801.TAA14537@hyperion.valhalla.net>
References: <200007121801.TAA14537@hyperion.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Any ideas how the two changed areas could affect things would be appreciated
>- although from reports:
>
>    AWACS rev 2 *does* appear to work with the new version
>    AWACS rev 3 appears to work on G4 but not on G3... hmmm.
>
>I must be missing something obvious (yes I have tried altering the volume -
>kmixer seems to think all is OK as well).
>
>BTW there is a call that reads a particular byte in nvram (to determine
>initial volume)  - is this still valid at 2.4 ?

You should use my new "xpram" calls for that. They are defined in arch/
ppc/kernel/pmac_support.c in 2.2 and arch/ppc/kernel/pmac_nvram.c in 2.4.
Think about using the proper #ifndef around them in 2.4

You need to calculate the offset in xpram and replace the old absolute
offset by an xpram offset by substracting the oldworld xpram base (see
the nvram code and you should understand).

Some notes:
 - The timing when powering up the sound chip and initializing it must be
carefully followed, or you'll have no sound.
 - Some versions of HW handle only 44.1 KHz. That's the case of Burgundy
chips, I'm not sure about the various AWACS revs.
 - Some recent "screamer" revisions of awacs have more registers for
controlling input sources and output levels (not handled by current Linux
code, look at Darwin drivers for details).
 - Some beige G3s have the "bordeaux" chip, which is a bit special, I
think it's actually a kind of Burgundy
 - Some machines (early iMacs) need to send some I2C commands to the SRS
module to control the volume, balance, etc... (again, Darwin source is a
good source of infos).

The Darwin sound driver sources are in the "IO" module of the Apple CVS

That's all tips I have for now ;)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
