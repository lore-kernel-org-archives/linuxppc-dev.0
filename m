Return-Path: <philip@turmel.org>
Received: from atl.turmel.org (atl.turmel.org [74.117.157.138])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F8B51A0205
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 15:04:00 +1100 (AEDT)
Subject: Re: Bisected Regression 4.3.5 => 4.4.1 booting HP ZBook in EFI mode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <56B518C4.8030007@turmel.org> <20160205222936.GA7139@kroah.com>
 <56B53344.3090300@turmel.org> <20160206010958.GA2205@kroah.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
From: Phil Turmel <philip@turmel.org>
Message-ID: <56B570AA.8050208@turmel.org>
Date: Fri, 5 Feb 2016 23:03:54 -0500
MIME-Version: 1.0
In-Reply-To: <20160206010958.GA2205@kroah.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/05/2016 08:09 PM, Greg Kroah-Hartman wrote:

> Ah, you have versioned modules / builds enabled, that's what caused the
> rebuild, if you disable CONFIG_MODVERSIONS and
> CONFIG_MODULE_SRCVERSION_ALL you shouldn't rebuild everything.
> 
> If those options are disabled, then something really odd is going on
> here...

So, MODVERSIONS was off, but MODULE_SRCVERSIONS_ALL and
LOCALVERSION_AUTO were on.

Repeating with those turned off, nothing was rebuilt.

That was bootable, too.  So I turned them on individually
and each was still bootable.  I verified the config matched
the originals I started with.

So I cleaned my tree and started over building v4.3.5 then v4.4.1.
They both booted.  So I can no longer reproduce this.

Sorry for the noise.

Phil
