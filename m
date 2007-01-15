Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A542DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 03:00:42 +1100 (EST)
In-Reply-To: <20070115085557.GA4943@iram.es>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
	<20070115085557.GA4943@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4391e3fc8335446ddeedecb5670d4a00@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Date: Mon, 15 Jan 2007 17:01:12 +0100
To: Gabriel Paubert <paubert@iram.es>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It also avoids clobbering the carry, you don't know whether a future
> version of GCC will require explicit clobbers for the carry. For now
> they are useless: you can specify "xer" in the clobber list AFAIR but
> no pattern can be split between setters and users of the carry in the
> machine description.

You can specify "cc" in the clobber list already, don't use
"xer" unless you're clobbering something else in the XER.


Segher
