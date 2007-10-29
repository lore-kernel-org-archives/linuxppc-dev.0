Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ABE8FDE107
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 07:44:50 +1100 (EST)
Date: Mon, 29 Oct 2007 15:52:54 -0500
From: Olof Johansson <olof@lixom.net>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] [powerpc] update xmon slb code
Message-ID: <20071029205254.GA27544@lixom.net>
References: <20071029195925.9773.94394.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029195925.9773.94394.stgit@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 02:59:27PM -0500, Will Schmidt wrote:
> 
> [powerpc] update xmon slb code
> 
> adds a bit more detail to the xmon SLB output.  When the valid bit is
> set, This displays the ESID and VSID values, as well as decoding the
> segment size. (1T or 256M).  This supresses the output for any slb entries
> that contain only zeros.
> 
> I debated a bit on whether to check for just (valid) versus checking for
> (valid|esid|vsid).  By inspection on power5, I do have SLB entries that
> contain values but without the valid bit set, so opted to display any
> non-zero values.

Yeah, newer versions of the architecture specify that invalid entries
must read as 0, while POWER5 doesn't. Printing them doesn't hurt.

> sample output from power6 (1T segment support):
> 
> 00 c000000008000000 40004f7ca3000500  1T  ESID=c00000  VSID=40004f7ca3
> 01 d000000008000000 4000eb71b0000400  1T  ESID=d00000  VSID=4000eb71b0
> 24 cf00000008000000 400011b260000500  1T  ESID=cf0000  VSID=400011b260
> 25 0000040008000000 4000a9e949000c80  1T  ESID=4  VSID=4000a9e949
> 26 0000000018000000 00005e93bfd49c80 256M ESID=1  VSID=5e93bfd49
> 27 00000f0008000000 4000e262a4000c80  1T  ESID=f  VSID=4000e262a4
> 28 0000000008000000 00005dd45172ec80 256M ESID=0  VSID=5dd45172e
> 
> sample output from power5 (notice the non-valid but non-zero entries)
> 
> 54 0000000048000000 0000cf33bb059c80 256M ESID=4  VSID=cf33bb059
> 55 0000000018000000 0000ccf56fe08c80 256M ESID=1  VSID=ccf56fe08
> 56 0000000010000000 0000dd82ce799c80
> 57 cf00000008000000 0000d59aca40f500 256M ESID=cf0000000  VSID=d59aca40f
> 58 c000000078000000 000045cb97751500 256M ESID=c00000007  VSID=45cb97751
> 59 0000040000000000 000061552db1bc80
> 
> Tested on power5 and power6.

Nice, I like it! I wonder if it would make sense to (space) pad the
ESID/VSID fields so they line up, it'd make output just a little tidier.

(If you end up changing that, please also break the long printf lines
in two.)

Beside that it looks good to me! :)


-Olof
