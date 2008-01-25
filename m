Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CFBD8DE4DF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 10:56:35 +1100 (EST)
Date: Fri, 25 Jan 2008 20:26:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc,
	legacy_serial: add support for "soc" compatible matching
Message-ID: <20080125172605.GA20930@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
	<9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
	<20080125171355.GA9879@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080125171355.GA9879@localhost.localdomain>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 08:13:55PM +0300, Anton Vorontsov wrote:
[...]
> My thinking:
> 
> Freescale soc register space: "fsl,soc"
> generic soc device: "soc" (or maybe "linux,soc" better?)
> 
> I know, Scott Wood is pushing "xxxx-immr" thing forward... but
> I don't like that name because SOC isn't only device with the
> Internal Memory Mapped Registers. (Think of QE placed outside
> of "soc"/"immr" node).
> 
> Though, "soc" by itself is fully unfortunate name. QE is the
> part of SOC too, as we used to call it when speaking of hardware.
> But logically we divide things for "core soc" and "core soc's
> companion/communication/offload modules", i.e. QE/CPMs/...
> 
> We can remove that ambiguity by moving QE/CPMs nodes inside
> the soc node. Then indeed -immr would be the best compatible for
> the "soc" node.

Oh, and yes, I'm aware that CPM's IMMRs are relocatable, and
that's [most probably] why we have CPMs outside of soc node.
So, my point is that that -immr name is too vague, so in my
opinion we should avoid using it.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
