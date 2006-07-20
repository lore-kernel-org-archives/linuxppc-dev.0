Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C73B67B9D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 05:56:40 +1000 (EST)
Date: Thu, 20 Jul 2006 12:56:37 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Ian Remmler <ian@remmler.org>
Subject: Re: Problem with ibm_emac driver
Message-ID: <20060720195637.GA9327@gate.ebshome.net>
References: <20060720183242.GA22930@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060720183242.GA22930@localhost>
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

On Thu, Jul 20, 2006 at 01:32:42PM -0500, Ian Remmler wrote:
> Hi,
> 
> I'm having a problem with the ibm_emac driver for the built in
> gigabit ethernet on the 440gx.  I was hoping someone could shed
> some light or at least point me in the right direction.
> 
> I'm using a GMS P502 board runing 2.4.27-pre3 (from GMS).  The
> problem we are having is this: when we push data over the emac
> interface (eth0 and eth1 both show the problem), we sporadically
> get a "MAL: Rx descriptor error..." from mal_rxde in
> ibm_ocp_mal.c.
> 
> Occasionally, the interface will "freeze up" for a few seconds.
> An ifconfig down/up will bring it back, but from then on it will
> freeze up again right away.
> 
> It looks to me like this error indicates that we're out of RX
> buffers, but I don't how we would be running out.  I'm no kernel
> or networking expert, but I thought the TCP stack would take
> care of throttling itself to prevent that sort of thing.  I
> would appreciate any help.

No idea what GMS is, but they seem to use old buggy EMAC driver.

You can use kernel.org's 2.6 or 2.4.31 backport at 
http://kernel.ebshome.net/

As a side note, TCP cannot throttle _all_ Rx traffic, think for 
example of a fast box sending a lot of small UDP packets to the 440gx.

-- 
Eugene
