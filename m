Return-Path: <gvb.linuxppc.dev@gmail.com>
Message-ID: <46A01733.6080609@gmail.com>
Date: Thu, 19 Jul 2007 22:00:19 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
References: <20070719183415.7458.42622.stgit@trillian>	<20070719183734.7458.83695.stgit@trillian>	<469FB47D.4030009@freescale.com>	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>	<20070719164036.f3d4c86d.kim.phillips@freescale.com>
	<469FDB3B.5000901@freescale.com>
In-Reply-To: <469FDB3B.5000901@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Kim Phillips wrote:
>> the old FLAT_TREE u-boot fdt fixup code renames any existing chosen
>> node out of the way, and adds its fixed up version as /chosen.

Not in my experience.  My experience is that it blindly created a second 
/chosen node.

>> The LIBFDT implementation replaces any existing /chosen with its fixed
>> up version.

Sort of.  If /chosen doesn't exist, it creates it.

If /chosen exists and "force" parameter is false, it doesn't touch it. 
If "force"  is true, it creates or fixes up properties.  The "bootm" 
command passes in force == false.  The "fdt" command passes in force == 
true.

The "force" parameter was added to sort of emulate the previous bootm 
command behavior (but behave better in the case where /chosen already 
existed).

Such is the price for not totally breaking user expectations.  Hopefully 
we recalibrate user expectations in the future and improve this.

> Could you point out the code that does this?  I don't see it in either 
> the old code or the new.
> 
> -Scott

Old code - I don't think so.

New code...
u-boot-fdt repo:
<http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot/u-boot-fdt.git;a=blob;f=common/fdt_support.c;h=259bd42cc62c55d11370579a7af0d6519fc34c8d;hb=01f771763ed822145b54819abb9c4516c8216d48#l96>

u-boot repo:
<http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=blob;f=common/fdt_support.c;h=69099c4275ccb925cce7b7c69afc5ab4f76cfe6f;hb=HEAD#l92>

Hope this makes sense,
gvb
