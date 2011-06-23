Return-Path: <dedekind1@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C1D8B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 18:30:45 +1000 (EST)
Received: by pvg18 with SMTP id 18so1065083pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 01:30:41 -0700 (PDT)
Subject: RE: NAND BBT corruption on MPC83xx
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Atlant Schmidt <aschmidt@dekaresearch.com>
Date: Thu, 23 Jun 2011 11:31:25 +0300
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD32A7208F91B@dekaexchange07.deka.local>
References: <20110617163442.204348a0@schlenkerla.am.freescale.net>
	<F87D23B7E1F84E4AB52E4FA4A55F85DC0259E343@tpamail.elutions.com>
	<0A40042D85E7C84DB443060EC44B3FD32A7208F91B@dekaexchange07.deka.local>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308817889.18119.98.camel@sauron>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"Matthew L. Creech" <mlcreech@gmail.com>,
	'Mike Hench' <mhench@elutions.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-20 at 07:22 -0400, Atlant Schmidt wrote:
> 
>   As far as I know (and I'm sure the list will correct
>   me if I'm wrong! ;-) ), neither UBI nor UBIFS nor any
>   Linux layer provides this routine scrubbing; you have
>   to code it up yourself, probably by accessing the
>   device at the UBI (underlying block device/LEB) layer. 

UBI will scrub all LEBs with bit-flips once they are read.
But if you have bit-flips in an LEB and it is never read, it will never
be scrubbed. And erasures of the neighboring PEBs may turn bit-flips
into hard errors.

To force scrubbing, the easies way is to just read all volumes, like

dd if=/dev/ubi0_i of=/dev/null bs=4096

for each i.

-- 
Best Regards,
Artem Bityutskiy
