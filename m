From: jtm@smoothsmoothie.com
Date: Thu, 13 Dec 2001 14:25:47 -0600
To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/nfs on sbc8260
Message-ID: <20011213202547.GA24294@shamus.smoothsmoothie.com>
References: <3C17E07F.7144B7BF@seranoa.com> <3C18445A.80505@embeddededge.com> <3C18CC34.5CF24CDA@seranoa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C18CC34.5CF24CDA@seranoa.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 13, 2001 at 10:41:40AM -0500, Andrew Dixon wrote:
>
> Here is something very strange.  In PPCBoot I set the ethernet address
> to 00:a0:1e:90:15:55.
>
> ....
>
> Now, as I watch Linux try to come up I see the following:
>
> ....
>
> Has anyone else seen this before?

In the ethernet driver for the FCC, it changes the MAC address based on
the FCC number.h

In a standard 2.4.4 kernel, arch/ppc/8260_io/fcc_enet.c is the
following code (around line 1315):
       /* Set Ethernet station address.
         *
         * This is supplied in the board information structure, so we
         * copy that into the controller.
         * So, far we have only been given one Ethernet address. We make
         * it unique by setting a few bits in the upper byte of the
         * non-static part of the address.
         */
        eap = (unsigned char *)&(ep->fen_paddrh);
        for (i=5; i>=0; i--) {
                if (i == 3) {
                        dev->dev_addr[i] = bd->bi_enetaddr[i];
                        dev->dev_addr[i] |= (1 << (7 - fip->fc_fccnum));
                        *eap++ = dev->dev_addr[i];
                }
                else {
                        *eap++ = dev->dev_addr[i] = bd->bi_enetaddr[i];
                }
        }


You can here see that the ethernet port's MAC address is dependent on
the fcc number.

--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
