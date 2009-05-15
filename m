Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22A61DE0E4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 00:16:26 +1000 (EST)
In-Reply-To: <d2b9ea600905150552u6951a92es5dd119dcc37e641d@mail.gmail.com>
References: <4A0BD1DB.4090305@doredevelopment.dk>	
	<20090514083453.GB3043@pengutronix.de>
	<4A0BDAD6.5020005@doredevelopment.dk>	
	<OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se>
	<d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>	
	<OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se>
	<d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com>	
	<OFCADC684E.A2599121-ONC12575B7.003B8AB5-C12575B7.003CF795@transmode.se>
	<d2b9ea600905150552u6951a92es5dd119dcc37e641d@mail.gmail.com>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
To: Esben Haabendal <esbenhaabendal@gmail.com>
Message-ID: <OF70B2DB02.88CE51EF-ONC12575B7.004DE1DE-C12575B7.004E66A5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 15 May 2009 16:16:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Esben Haabendal <esbenhaabendal@gmail.com> wrote on 15/05/2009 14:52:28:
>
> Your new patch also does not work.
>
> Have you tested it?

sure, works fine. I haven't stressed it too much though.

>
> I already tried something very much what you sent here, I believe the
> only difference was that I named the "last" variable "stop". I also
> tried several other aproaches, and none of them worked.  I would
> appreciate not to have to test all of them seperately again through
> this mailing list ;-)

:), point taken.

>
> Anyway, your patch also is in conflict with the MPC8360ERM. The spec
> specifies that a repeated start must follow an ACK, and not a "NO
> ACK".

Ouch, will have to check too, but later.

>
> When doing a repeated start after a NO ACK, the slave does not ACK the
> address (I get an RXAK).  When doing as specified, ACK'ing the last
> byte read and then doing a repeated START, i2c_wait() fails due to
> CSR_MCF bit missing.  I thought it would be possible to find somewhere
> to do a dummy read to get around this, but failed to do so without
> breaking something else.
>
> Could we go forward with my initial patch, and then continue the work
> on this repeated START approach for future releases?

Yes, go ahead.

 Jocke
