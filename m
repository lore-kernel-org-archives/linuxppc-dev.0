Return-Path: <vitalywool@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 5881067C13
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 20:44:24 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so114913ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 01:44:20 -0800 (PST)
Message-ID: <acd2a5930612130144u2d75229etecb82611b0bea04a@mail.gmail.com>
Date: Wed, 13 Dec 2006 12:44:19 +0300
From: "Vitaly Wool" <vitalywool@gmail.com>
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
In-Reply-To: <1166001747.30422.43.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_134255_13775682.1166003059976"
References: <1166001747.30422.43.camel@gentoo-jocke.transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_134255_13775682.1166003059976
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/13/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> The MPC 832x has a different SPI controller i/f, probably due to
> its QUICC engine support. This patch adapts the spi_mpx83xx driver to
> be usable on QE based 83xx cpus.
>

First, I'm pretty much against sending such patches to arch lists and not to
subsystem lists.

@@ -99,31 +105,39 @@ static inline u32 mpc83xx_spi_read_reg(_
        return in_be32(reg);
 }

Then,  this
+       *rx++ = (type)(data >> shift);                                    \
and this
+       data = *tx++ << shift;                                  \

pieces of code are potentially dangerous (what if 'shift' is something like
'x & 0xf3 << 4' ?)

Vitaly

------=_Part_134255_13775682.1166003059976
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/13/06, <b class="gmail_sendername">Joakim Tjernlund</b> &lt;<a href="mailto:joakim.tjernlund@transmode.se">joakim.tjernlund@transmode.se</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
The MPC 832x has a different SPI controller i/f, probably due to<br>its QUICC engine support. This patch adapts the spi_mpx83xx driver to<br>be usable on QE based 83xx cpus.<br></blockquote></div><br>First, I'm pretty much against sending such patches to arch lists and not to subsystem lists.
<br><br>@@ -99,31 +105,39 @@ static inline u32 mpc83xx_spi_read_reg(_<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return in_be32(reg);<br>&nbsp;}<br><br>Then,&nbsp; this <br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rx++ = (type)(data &gt;&gt; shift);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>and this
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = *tx++ &lt;&lt; shift;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br><br>pieces of code are potentially dangerous (what if 'shift' is something like 'x &amp; 0xf3 &lt;&lt; 4' ?)<br><br>Vitaly<br>

------=_Part_134255_13775682.1166003059976--
