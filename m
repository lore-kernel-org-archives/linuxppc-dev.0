Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C51D8B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 06:07:10 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8RK1lhL026056
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2010 14:01:47 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8RK6uRO205848
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2010 14:06:56 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8RK6tKJ012175
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2010 14:06:55 -0600
Subject: Re: [PATCH 1/1]  Add config option for batched hcalls
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20100926034903.GA5473@lixom.net>
References: <1285364655.3016.25.camel@lexx> <20100926034903.GA5473@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Sep 2010 15:06:46 -0500
Message-ID: <1285618006.3016.27.camel@lexx>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-09-25 at 22:49 -0500, Olof Johansson wrote:
> On Fri, Sep 24, 2010 at 04:44:15PM -0500, Will Schmidt wrote:
> > 
> > Add a config option for the (batched) MULTITCE and BULK_REMOVE h-calls.
> > 
> > By default, these options are on and are beneficial for performance and
> > throughput reasons.   If disabled, the code will fall back to using less
> > optimal TCE and REMOVE hcalls.   The ability to easily disable these
> > options is useful for some of the PREEMPT_RT related investigation and
> > work occurring on Power.
> 
> Hi,
> 
> I can see why it's useful to enable and disable, but these are all
> runtime-checked, wouldn't it be more useful to add a bootarg to handle
> it instead of adding some new config options that pretty much everyone
> will always go with the defaults on?
> 
> The bits are set early, but from looking at where they're used, there
> doesn't seem to be any harm in disabling them later on when a bootarg
> is convenient to parse and deal with?
> 
> It has the benefit of easier on/off testing, if that has any value for
> production debug down the road.

Hi Olof, 
  Thats a good idea, let me poke at this a bit more, see if I can get
bootargs for this.  

Thanks, 
-Will

> 
> 
> -Olof
> 
