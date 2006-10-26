Return-Path: <scop@digitel.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id 2A01667CF8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 08:44:05 +1000 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>, linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 SCC/SMC break handling broken
Date: Thu, 26 Oct 2006 19:18:37 -0200
References: <200610261002.44688.laurent.pinchart@tbox.biz>
In-Reply-To: <200610261002.44688.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Message-Id: <200610261918.37769.scop@digitel.com.br>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 26 October 2006 06:02, Laurent Pinchart wrote:
> Hi everybody,
>
> I need to generate a break on a CPM2 SMC serial port (same issue with S=
CC
> serial ports).
>
> The tcsendbreak() man page states that the function should generate a b=
reak
> between 250ms and 500ms, but testing showed that the break is one chara=
cter
> long (10 bits in 8N1 mode).

[snip]

> CPM_CR_STOP_TX is documented to generate a break of BRKCR characters. T=
he
> BRKCR register is initialized to 1, so only 1 break character is sent,
> which won't last between 250ms and 500ms.

[snip]

> Could anyone think of a proper solution which would not disturb the oth=
er
> drivers too much ?

Well, one could always set the BRKCR parameter to the maximum number of b=
reak=20
characters permitted by it's size, since the break condition will anyway =
end=20
as soon as the RESTART TX command is issued as a consequence of the=20
tty->driver->break_ctl(tty, 0) call. But I did not test this.

HTH,

--=20
Ricardo Scop.

        \|/
    ___ -*-
   (@ @)/|\
  /  V  \|  R SCOP Consult.
 /(     )\  Linux-based communications
--^^---^^+------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil
--
P. S.: "If you have any trouble sounding condescending, find a Unix user =
to
show you how it's done."  -- Scott Adams, creator of "Dilbert"
