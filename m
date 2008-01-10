Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 02133DE01B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 02:42:51 +1100 (EST)
Date: Thu, 10 Jan 2008 09:52:25 -0600
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Platform matching style (was:: [RFC] add phy-handle property
	for fec_mpc52xx)
Message-ID: <20080110155225.GA3944@lixom.net>
References: <fa686aa40801100731k62b004ecq4f6058aea5df9da0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801100731k62b004ecq4f6058aea5df9da0@mail.gmail.com>
Cc: olaf@aepfle.de, sven@genesi-usa.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2008 at 08:31:18AM -0700, Grant Likely wrote:

> 1. Apply a device tree fixup to change device_type from "chrp" to
> "efika" (the current solution)
> 2. Modify chrp_probe() to check specifically for the Efika when probing
> 3. Modify the link order so that Efika is probed before CHRP.
>
> All three of these solutions will work, but I'd like to get opinions
> on which is stylistically the best approach (or if there is another
> approach I'm missing).
> 
> In general, I'm trying to reduce the Efika fixups down to only what is
> absolutely necessary and as much as possible work with the provided
> device tree.

(3) sounds fragile to me.

There's already code in the kernel that does (2): pSeries_probe checks
to make sure it's not running on a cell blade. That has the benefit of
presenting something closer to the real device tree to the user through
/proc/device-tree, not that I'm sure it has all that much value.


-Olof
