From: "T Michael Turney" <tmike@recipes4linux.com>
To: "Andrew Williams" <awilliam@nortelnetworks.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FEC support for 8260 in kernel 2.4.25
Date: Tue, 27 Apr 2004 19:22:59 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHEEEKCJAA.tmike@recipes4linux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <E380A44D523BD5118EAE0002A52CE5C40B87C883@zcard0k8.ca.nortel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all the inputs I received on the original query.

Update: All FCC ports are functional at 100 Mbps, but not
at 10 Mbps.

I had made some changes to the do/while loop in fec_enet_init,
investigating this problem.  When I backed those changes out
and removed the 10Mbps traffic, the 3 FCCs started to play.

Not sure why the 10 Mbps traffic is causing problems,
the LEDs seem to indicate the PHY (BCM5221) is correctly
auto-negotiating.
Cheers,
T.mike

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Andrew
> Williams
> Sent: Monday, April 26, 2004 11:49 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: FEC support for 8260 in kernel 2.4.25
>
>
>
> -- Fourth Attempt.. hoping to have disabled HTML output in Outlook --
>
> Not just the GPIO pins, be sure to note the different
> clock sources. (Which in the code is clearly labeled as
> "This is board specific", but then goes on to declare
> constant values in the common fcc_enet.c file).
>
>   This bothered me enough that I changed the fcc_enet
> files from:
>
> #define PC_F1RXCLK      ((uint)0x00000800)
> #define PC_F1TXCLK      ((uint)0x00000400)
> #define CMX1_CLK_ROUTE  ((uint)0x3e000000)
>
> to
>
> #ifndef PC_F1RXCLK
> #define PC_F1RXCLK      ((uint)0x00000800)
> #endif
> #ifndef PC_F1TXCLK
> #define PC_F1TXCLK      ((uint)0x00000400)
> #endif
> #ifndef CMX1_CLK_ROUTE
> #define CMX1_CLK_ROUTE  ((uint)0x3e000000)
> #endif
>
>  (repeat for all 3 interfaces)
>
> I know it looks a bit kludgy, but you can now declare board
> specific values in your platform/<platform>.h file, and have these
> override the current default hard coded values. Furthermore this
> change won't break any existing platforms. :o)
>
> One other potential 'gotcha' is if you have different FPSMR values
> depending on the interface. The current code (2.4.22) limits you to
> a single value that applies to all three interfaces. I worked around
> this one, by adding a field to 'fcc_info' for the fpsmr. Then in the
> declaration of 'fcc_ports' I once again used conditional
> compiles to allow FPSMR values in the platforms file to override
> the default FCC_PSMR_ENCRC value.
>
>
> Andrew
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
