Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 328EDB70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 01:54:19 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id 60EBEDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 01:54:18 +1000 (EST)
Received: by gxk6 with SMTP id 6so238314gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 08:54:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A40E940.10201@marel.com>
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<4A40E940.10201@marel.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 23 Jun 2009 09:53:54 -0600
Message-ID: <fa686aa40906230853t5db35b11wae09cf46634d4758@mail.gmail.com>
Subject: Re: [PATCH v4] powerpc/5200: Add mpc5200-spi (non-PSC) device driver
To: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 23, 2009 at 8:40 AM, K=E1ri Dav=ED=F0sson<kari.davidsson@marel.=
com> wrote:
> Hi,
>
> I have been testing this driver a little bit (on 2.6.29.3)
>
> What happens for me is that the driver starves the system while sending
> data over the SPI interface.
>
> I think the problem is in the function (interrupt handler)
> mpc52xx_spi_irq() that calls the function mpc52xx_spi_fsm_process()
> which again is an loop that iterates over the whole data to be sent.

Hmmm, the state machine is supposed to yield after each byte sent, but
on fast transfers I could see it becoming ready to run again
immediately.

Unfortunately it is not an easy problem.  The SPI device can only
handle 1 byte at a time.  Maybe it would be better for CPU fairness if
all the work was done in a thread.  I didn't originally because I
didn't want to introduce a huge amount of scheduling overhead every
time a byte was transfered, and I wanted to keep transfers fast.  I
need to think about this some more.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
