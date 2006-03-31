Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 711CD679EB
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 04:03:24 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VH3LQs008299
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 12:03:21 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VH3LLt202394
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 12:03:21 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2VH3LIH002243
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 12:03:21 -0500
Date: Fri, 31 Mar 2006 11:03:19 -0600
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
	reset.
Message-ID: <20060331170319.GV2172@austin.ibm.com>
References: <20060330213928.GQ2172@austin.ibm.com>
	<20060331000208.GS2172@austin.ibm.com>
	<442C8069.507@wolfmountaingroup.com>
	<20060331003506.GU2172@austin.ibm.com>
	<442CACC0.1060308@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <442CACC0.1060308@wolfmountaingroup.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jesse.brandeburg@intel.com, linuxppc-dev@ozlabs.org,
	john.ronciak@intel.com, jeffrey.t.kirsher@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 30, 2006 at 09:14:56PM -0700, Jeffrey V. Merkey wrote:
> Yes, we need one. The adapter needs to maintain these stats from the
> registers in the kernel structure and not
> its own local variables. 

Did you read the code to see what the adapter does with these stats? 
Among other things, it uses them to adaptively modulate transmit rates 
to avoid collisions. Just clearing the hardware-private stats will mess
up that function.

> That way, when someone calls to clear the stats
> for testing and analysis purposes,
> they zero out and are reset.

1) ifdown/ifup is guarenteed to to clear things. Try that.

2) What's wrong with taking deltas? Typical through-put performance
measurement is done by pre-loading the pipes (i.e. running for
a few minutes wihtout measuring, then starting the measurement).
I'd think that snapshotting the numbers would be easier, and is 
trivially doable in user-space. I guess I don't understand why 
you need a new kernel featre to imlement this.

--linas
