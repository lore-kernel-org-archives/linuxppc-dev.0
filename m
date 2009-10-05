Return-Path: <mike@terascala.com>
Received: from hermes.terascala.com (terascala.com [75.147.14.129])
	by ozlabs.org (Postfix) with ESMTP id A34D5B7BAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 02:09:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Regression detecting memory size on PPC440EPx
Date: Mon, 5 Oct 2009 10:57:10 -0400
Message-ID: <2C7DE72B9BD00F44BAECA5B0CBB873955CADF2@hermes.terascala.com>
From: "Mike Nuss" <mike@terascala.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was a fix a while back called "Correct memory size calculation for
Denali based boards" that corrected the data width detection in the 4xx
bootwrapper.

This seems to have had the unintended consequence of exposing another
bug in the same code.  I have a board very similar to Sequoia, except
that it uses a DDR2 DIMM module.  It uses a single 256MB DIMM.  After
upgrading to the latest kernel, which includes the previously mentioned
fix, U-Boot works fine, but the kernel detects 512MB instead, and of
course, the kernel panics.

The error seems to be in the calculation of row bits.  U-Boot's SPD
detection says that the DIMM uses 13 bits, but I added some printf()s to
the bootwrapper, and it is setting row to 14 instead.  I'm not too clear
on how this code works; it calculates the row bits by subtracting the
row from max_row, and maybe max_row is wrong?

It looks like the data width bug canceled out this bug before, since
these values end up changing the memory size by a factor of 2 (in
opposite directions).

Could someone with a better understanding of this code take a look?

Thanks,
Mike
