Message-ID: <3BF2A361.5FBB0246@mvista.com>
Date: Wed, 14 Nov 2001 09:01:21 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel on walnut
References: <3BDD855B.8D3FC72F@inn.ericsson.se>
	 <3BE971BC.34591FF1@inn.ericsson.se> <3BEBF4E5.B60BD9E3@inn.ericsson.se>
Content-Type: multipart/mixed;
 boundary="------------77DE98024417B714F36EBF3C"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------77DE98024417B714F36EBF3C
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Kenneth Johansson wrote:
>
> The saga continues.
>
> Well some of the problems I had was of the brown paperbag over head kind of
> error but now I can boot and run a version checked out a few hours ago.
>
> But the ethernet reporting of the line is wrong. This is a problem with the
> printout only as the function is right. The 100Mb full duplex is reported to
> be 10Mb half and vise verse.
>
> I have not run the walnut hardware for some time but I still have a quite
> severe problem with ethernet in 10Mb.
>
> What happens is this if I connect to a 3com 10Mb hub that is connected to the
> office net (cisco switch) the switch turns off the port after some time
> mostly when I run apt-get. Since the walnut card is never directly connected
> to the switch this must be some logical error in packets probably the
> intergap time is to small that is the only thing I can think of as the switch
> only care about the ethernet layer.
>
> This problem could maybee exist if I directly connect to the switch I have
> not done that and no I can not test this easy as I don't control the switch
> and now only have 1 working port in that room and it is really needed.
>
> --
> Kenneth Johansson
> Ericsson Business Innovation AB   Tel: +46 8 404 71 83
> Viderögatan 3                     Fax: +46 8 404 72 72
> 164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

Kenneth;

I finally got arround to looking into this and the problem is the
status.
We use the status to program the emac to the same speed as the PHY.

I have attach a patch the should correct this.


-- armin
--------------77DE98024417B714F36EBF3C
Content-Type: application/octet-stream;
 name="405_enet_1114.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="405_enet_1114.patch.gz"

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
kpPapIJVd6/6GJL+PxikHVdxIQAA
--------------77DE98024417B714F36EBF3C--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
