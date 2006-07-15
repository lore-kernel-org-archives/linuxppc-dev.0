Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8DF7567B7B
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jul 2006 02:42:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Date: Sat, 15 Jul 2006 18:42:26 +0200
References: <20060714233739.GA11487@monkey.ibm.com>
	<200607150200.03494.arnd@arndb.de>
	<20060715153053.GK31081@krispykreme>
In-Reply-To: <20060715153053.GK31081@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151842.27568.arnd@arndb.de>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 15 July 2006 17:30, Anton Blanchard wrote:
> > What happened to the question whether to use PURR values for also measuring
> > cycles spent executing the hcall as opposed to cycles that passed before
> > the hcall returns. Did that turn out not giving extra information after all
> > or was there a different reason to drop that idea?
> 
> You have to be careful with PURR since it may be context switched
> between partitions.
> 

Not sure I follow you. I would expect the PURR value to be restored after
a context switch, even if we continue on a different physical CPU.

The idea behind monitoring both PURR and timebase is that the difference
between the two tells you how long the partition was suspended during
the hcall.

	Arnd <><
