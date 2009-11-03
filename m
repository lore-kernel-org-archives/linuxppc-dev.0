Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.221])
	by ozlabs.org (Postfix) with ESMTP id ED218B7B9A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 20:11:44 +1100 (EST)
Message-ID: <4AEFEC64.3070608@neli.hopto.org>
Date: Tue, 03 Nov 2009 09:40:04 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: hank peng <pengxihan@gmail.com>,  linuxppc-dev@ozlabs.org
Subject: Re: mpc8548 does not make use of DMA when doing memory copy?
References: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>	<15E6E326-D17B-42D7-AA22-2CA319C2A808@kernel.crashing.org>
	<389deec70911021635v6e12a976t9e20fb5f12d8987b@mail.gmail.com>
In-Reply-To: <389deec70911021635v6e12a976t9e20fb5f12d8987b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hank peng wrote:
> I remember normal memory copy can also be done (chosen by user) by DMA
> engine on IOP80331(Intel embedded cpu, xscale arch), so why ppc
> platform didn't make use of DMA doing memory copy, I think it can
> increase performance, please correct me if I am wrong!

AFAIK the DMA engine has only an asynchronous mode (not very smart 
IMHO). This means you always have the overhead of context switch + 
interrupt + context switch, so the transfer has to be quite large for 
this to pay off.

Micha
