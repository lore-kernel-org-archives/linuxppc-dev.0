From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Kerl, John" <John.Kerl@Avnet.com>
Subject: RE: MPC857T FEC/MII failure
Date: Fri, 23 Aug 2002 11:00:51 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJCEBDCIAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <C08678384BE7D311B4D70004ACA371050B7635B0@amer22.avnet.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I only whant to mention that we are using 857T with LXT972 and there is no
problem with the MDIO interface. Except that I don't get the PHY interrupt.
But That's a different story...


Regards, Stephan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kerl,
> John
> Sent: Donnerstag, 22. August 2002 22:13
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: MPC857T FEC/MII failure
>
>
>
> Hello,
>
> I am experiencing a problem with the MPC857T FEC's MII interface.
>
> I want to read MII registers for our PHY (ID 24 on our board).  Per the
> MPC857T
> manual:
>
> *	I write 0x36 to MII_SPEED (IMMR + 0xe84).  An oscilloscope probe
> 	on the PHY's MDC pin reveals a 1.235 MHz rate, within spec.
>
> *	I write 0x6c060000 to MII_DATA (IMMR + 0xe80).
> 	This is:
>
> 	-	ST=01
> 	-	OP=10
> 	-	ID=11000
> 	-	REG=00001
> 	-	TA=10
>
> The data read back in the second 16 bits of MII_DATA are always 0xffff.
> This is
> in fact regardless of the PHY ID (I've tried all 32) or register
> (I've tried
> all 32).
> There are two concomitant symptoms:
>
> *	If I put oscilloscope probes on the PHY's MDC and MDIO pins, then
> look
> 	at the MDIO pin's values at the rising edges of MDC, I see that the
> FEC
> 	has actually written the following:
>
> 	-	ST=01
> 	-	OP=10
> 	-	ID=11000
> 	-	REG=00001
> 	-	TA=11
>
> 	which is *not* what I asked it to do.
>
> *	If I read back the MII_DATA register, *even though* I wrote
> 0x6c060000,
> 	I read back the value 0x6c07ffff.  Note that the second 6 is now a
> 	7.
>
> In short, I formulate a compliant request (TA=10), then the FEC mangles it
> (TA=11) and drives that out.  It is no wonder the PHY doesn't respond.
>
> This problem is observable in our debug monitor using simple peek
> and poke.
> Thus, this is more of a PPC question than a Linux question.
>
> Has anyone seen anything similar?
>
> Thanks.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
