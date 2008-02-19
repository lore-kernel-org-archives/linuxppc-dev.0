Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id D5E07DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 01:18:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so2172553anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 06:18:40 -0800 (PST)
Date: Tue, 19 Feb 2008 08:17:17 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: "Nicolas Genevrier" <Nicolas.Genevrier@jdsu.com>
Subject: Re: Ethernet breakdown on a Yosemite evaluation board
Message-ID: <20080219081717.6b10d60d@zod.rchland.ibm.com>
In-Reply-To: <8C40729B7184DC459A15060FA1AF589602045556@ENIEXCH01.ds.jdsu.net>
References: <8C40729B7184DC459A15060FA1AF589602045556@ENIEXCH01.ds.jdsu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 14:00:19 +0100
"Nicolas Genevrier" <Nicolas.Genevrier@jdsu.com> wrote:

> Hello all,
> 
> I noticed an Ethernet blocking on a Yosemite evaluation board when we
> are using both Ethernet devices (eth0 and eth1).
> To reproduce the issue, I just telnet the board from a PC (PC1) through
> eth0 and then telnet another PC (PC2) from the first telnet session
> through eth1. Then I display a lot of characters on the last telnet
> session:
> 	$ for i in `seq 1 100000`; do echo "$i
> aaaaaaaaaaa..(x160)..aaa"; done
> 
> After a while, transmission is blocked and leads to an rxde interruption
> from the MAL.
> 
> Yosemite evaluation kit runs Linux 2.16.13 but I reproduced the issue
> with our board running Linux-2.6.16 on a 440EP.
> In Linux 2.6.16, the new ibm_emac driver tries to recover the error but
> Ethernet remains very very slow even one day after the end of the
> transmission.
>  I didn't notice any evolution related to this neither any discussion on
> the topic. Sorry if I missed them.
> 
> I am working on the subject but an idea or related information would be
> helpful.

There was a patch from Wolfgang Ocker recently that fixed some interrupt
settings for 440EP in arch/ppc.  You might want to look at that.  I
still need to evaluate if the arch/powerpc port needs fixing.

http://patchwork.ozlabs.org/linuxppc/patch?person=1210&id=16789

josh
