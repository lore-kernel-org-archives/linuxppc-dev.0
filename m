Date: Tue, 13 Nov 2001 18:09:37 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: scop@digitel.com.br
Message-ID: <19756.011113@digitel.com.br>
To: Dan Malek <dan@embeddededge.com>
Cc: Ricardo Scop <scop@vanet.com.br>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: Linuxppc and MPC8255 routing performance
In-reply-To: <3BF164B2.8080000@embeddededge.com>
References: <3BF164B2.8080000@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Tuesday, November 13, 2001, 3:21:38 PM, you wrote:

DM> Ricardo Scop wrote:


>> As for our performance troubles, there have been some improvements; we were
>> making some mistakes regarding both FCC and PHY programming.


DM> FYI, a major telecommuniation company paid for independent laboratory
DM> certifcation of this driver (and Linux) under a variety of performance
DM> and error conditions.  After a couple of iterations, it passed the
DM> certification testing and I believe all of the modifications are in
DM> this driver (at least it was my intention to ensure they are public).

I'm really glad to know about that. FYI, we never had any doubts about
linuxppc implementation quality, or we wouldn't use it in the first
place.

DM> I don't remember which PHY was used for the testing, but please don't
DM> attack this as a "can't possibly work" problem and start hacking it up.

Oh, we don't! The 'mistakes' I referred were made by _myself_, in two
places:
       - LXT970A PHY in PPCBoot (our hardware MDIO interface don't
       conform to Linux MDIO driver, so I hacked PPCBoot to program
       the chip to megotiate full-duplex, but I did it wrong in our
       earlier tests);

       - in arch/ppc/8260io/fcc_enet.c: the driver we have, pulled
       from linuxppc_2_4 mvista cvs mirror some two weeks ago,
       programs the FCC to half-duplex mode, by default; so, I tryed to
       hack it to full-duplex for our tests and, again, made a
       mistake, which is now fixed).

As I said, all _my_ mistakes. Linux FCC driver works perfectly well!

Thanks again.

~Ricardo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
