Return-Path: <scottwood@freescale.com>
Message-ID: <46A0DF76.90409@freescale.com>
Date: Fri, 20 Jul 2007 11:14:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
References: <20070719183415.7458.42622.stgit@trillian>	<20070719183734.7458.83695.stgit@trillian>	<469FB47D.4030009@freescale.com>	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>	<20070719164036.f3d4c86d.kim.phillips@freescale.com>
	<469FDB3B.5000901@freescale.com> <46A01733.6080609@gmail.com>
In-Reply-To: <46A01733.6080609@gmail.com>
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

Jerry Van Baren wrote:
> Scott Wood wrote:
>> Kim Phillips wrote:
>>> The LIBFDT implementation replaces any existing /chosen with its fixed
>>> up version.
> 
> 
> Sort of.  If /chosen doesn't exist, it creates it.
> 
> If /chosen exists and "force" parameter is false, it doesn't touch it. 
> If "force"  is true, it creates or fixes up properties.  The "bootm" 
> command passes in force == false.  The "fdt" command passes in force == 
> true.
> 
> The "force" parameter was added to sort of emulate the previous bootm 
> command behavior (but behave better in the case where /chosen already 
> existed).

The problem is that "force" is node-granular, rather than 
property-granular -- If I add a /chosen/linux,stdout-path in the 
original dts (or via an fdt command), then bootm will decline to add 
bootargs and initrd information to the /chosen node.

-Scott
