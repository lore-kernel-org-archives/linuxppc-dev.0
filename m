Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 8F5381A0942
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 18:56:05 +1100 (AEDT)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@freescale.com" <madalin.bucur@freescale.com>
CC: "scottwood@freescale.com" <scottwood@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "roy.pledge@freescale.com"
 <roy.pledge@freescale.com>, "igal.liberman@freescale.com"
 <igal.liberman@freescale.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joe@perches.com" <joe@perches.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [net-next v4 2/8] dpaa_eth: add support for DPAA Ethernet
Date: Tue, 3 Nov 2015 07:55:57 +0000
Message-ID: <1446537357.21216.49.camel@transmode.se>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-3-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1446485500-9782-3-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> +       if (unlikely(fd_status & FM_FD_STAT_RX_ERRORS) !=3D 0) {
> +               if (net_ratelimit())
> +                       netif_warn(priv, hw, net_dev, "FD status =3D 0x%0=
8x\n",
> +                                  fd_status & FM_FD_STAT_RX_ERRORS);
> +
> +               percpu_stats->rx_errors++;
> +               goto _release_frame;
> +       }

I cannot find any detailed error accounting(maybe I am not looking hard eno=
ugh) but I
would appreciate if both TX and RX errors where better accounted(rx_length_=
errors, rx_frame_errors,
rx_crc_errors, rx_fifo_errors etc.). This has helped me many times in the p=
ast diagnosing
board HW problems.

 Jocke=
