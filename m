Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57BDBDDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 07:26:25 +1100 (EST)
Subject: Re: [PATCH] ppc32: remove secondary_ti
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <31226871825643c98694.1714636915.miltonm@bga.com>
References: <31226871825643c98694.1714636915.miltonm@bga.com>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 07:26:01 +1100
Message-Id: <1226867161.7178.167.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-11-16 at 15:43 -0600, Milton Miller wrote:
> Instead of copying current_set[cpu] to secondary_ti, directly index into
> current_set by the cpu number like head_64.S.  In addition to removing
> the variable, a slow to respond cpu will not clobber another cpus
> stack.

Except that we don't know our CPU number at this stage do we ? IE. r24
is our HW number, is it guaranteed to be what we want to index
current_set ?

Ben.
