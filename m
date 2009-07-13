Return-Path: <joakim.tjernlund@transmode.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF653B707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 02:01:13 +1000 (EST)
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BB8EDDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 02:01:10 +1000 (EST)
In-Reply-To: <20090713151911.GA28114@oksana.dev.rtsoft.ru>
References: <20090713151911.GA28114@oksana.dev.rtsoft.ru>
Subject: Re: [PATCH 0/2] Setting GPIOs simultaneously
To: avorontsov@ru.mvista.com
Message-ID: <OFF188389D.68E638A2-ONC12575F2.00568C5B-C12575F2.0057FC95@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 13 Jul 2009 18:01:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 13/07/2009 17:19:11:
>
> Hi all,
>
> I've been sitting on these patches for some time, but now it appears
> that the set_sync() feature is needed elsewhere. So here are the
> patches.
>
> Joakim, I think this is what you need.

Yes, it sure looks so :) I will have to look closer later as
I will be traveling the next few days.

Question though, have you considered using a bitmask instead of
an array:
static void qe_gpio_set_sync(struct gpio_chip *gc, unsigned int num,
	 		      unsigned int gpio_mask, unsigned int vals)
If you want to set bit 0, 3 and 8 you would set positions 0, 3 and 8 in gpio_mask
to ones. Similarly in vals, set bit positions 0, 3 and 8 to requested value.

While being at it, the reason for me needing this is that the spi_mpc83xx driver
was recently converted to a OF only driver so I have no way of defining my own
CS function anymore. While OF is good I don't feel that OF drivers should block the native
method, OF should be a layer on top of the native methods.

 Jocke
