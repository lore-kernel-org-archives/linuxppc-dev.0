Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82E7ADDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 01:04:52 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0LE4leh015969
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 09:04:47 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0LE4f09092716
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 07:04:42 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0LE4dQU032046
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 07:04:40 -0700
Date: Mon, 21 Jan 2008 08:01:57 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Warp Watchdog
Message-ID: <20080121080157.0b66c7fc@zod.rchland.ibm.com>
In-Reply-To: <478FB93A.7040505@pikatech.com>
References: <478FB93A.7040505@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008 15:23:22 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> The taco, er warp, has a watchdog timer built into the fpga. The 
> watchdog is very trivial and very tied to the warp. I have put it has 
> part of the platform code rather than a standalone module.
> 
> Two reasons for this: one, once started it can't be stopped. A module 
> unload would be fatal ;) Two, it is so closely tied to the taco that it 
> really has no use otherwise.

The first isn't much of a reason.  The watchdog on the 44x and FSL
Book-E cores have the same behavior.

> The platform always starts the watchdog, assuming you asked for the 
> watchdog, but does not enable it until hit from user mode.
> 
> What is the general feeling about this implementation? I am not 
> submitting this for inclusion in the kernel right now, just feeling out 
> what others think.

I'm not thrilled with it being in the platform file itself.  It should
really go into drivers/watchdog.  It's OK that the watchdog is tied to
Warp, that really isn't an issue.  Just make it depend on Warp in the
Kconfig file.  And you can select it in your board config so that it's
built in-kernel and not as a module.

The code itself looks pretty clean.

josh
