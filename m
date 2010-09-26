Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6879B70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 26 Sep 2010 13:49:05 +1000 (EST)
Date: Sat, 25 Sep 2010 22:49:03 -0500
From: Olof Johansson <olof@lixom.net>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH 1/1]  Add config option for batched hcalls
Message-ID: <20100926034903.GA5473@lixom.net>
References: <1285364655.3016.25.camel@lexx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285364655.3016.25.camel@lexx>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 04:44:15PM -0500, Will Schmidt wrote:
> 
> Add a config option for the (batched) MULTITCE and BULK_REMOVE h-calls.
> 
> By default, these options are on and are beneficial for performance and
> throughput reasons.   If disabled, the code will fall back to using less
> optimal TCE and REMOVE hcalls.   The ability to easily disable these
> options is useful for some of the PREEMPT_RT related investigation and
> work occurring on Power.

Hi,

I can see why it's useful to enable and disable, but these are all
runtime-checked, wouldn't it be more useful to add a bootarg to handle
it instead of adding some new config options that pretty much everyone
will always go with the defaults on?

The bits are set early, but from looking at where they're used, there
doesn't seem to be any harm in disabling them later on when a bootarg
is convenient to parse and deal with?

It has the benefit of easier on/off testing, if that has any value for
production debug down the road.


-Olof
