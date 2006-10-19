Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7CCBD67B6F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 03:47:32 +1000 (EST)
Date: Thu, 19 Oct 2006 12:43:29 -0500
From: Olof Johansson <olof@lixom.net>
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Message-ID: <20061019124329.1f32257a@pb15>
In-Reply-To: <453771E5.4090808@bplan-gmbh.de>
References: <453771E5.4090808@bplan-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2006 14:39:01 +0200 Nicolas DET <nd@bplan-gmbh.de> wrote:

> We know this patch is not totaly compliant with Documentation/CodingStyle/.
> 
> We would like people to comment and review it. This way we would provide 
> a new patch with the changes required (if any) for an upcomming merge in 
> the kernel.

Hi,

Like others have said, a monolithic patch like this is really hard to
review. Please split it up, there are several logical ways it could be
cut, drivers vs base platform support, etc.

First reaction from just browsing through it:

* Lots of SillyCaps, i.e. codingstyle issues, especially in the
  bestcomm code
* No need to have filenames at top of files (they're even wrong in some
  cases)
* You reinvented pr_debug() (everyone loves doing this, myself included)
* Some hardcoded baudrate stuff in the serial driver. Should probably
  be passed in from somewhere -- device tree?
* Network drivers should be posted to netdev, not the arch list


More thorough review would be easier to do with split-up patches.


-Olof
