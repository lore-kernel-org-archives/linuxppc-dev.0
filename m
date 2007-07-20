Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <46A0E6F8.9020101@smiths-aerospace.com>
Date: Fri, 20 Jul 2007 12:46:48 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
References: <20070719183415.7458.42622.stgit@trillian>	<20070719183734.7458.83695.stgit@trillian>	<469FB47D.4030009@freescale.com>	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>	<20070719164036.f3d4c86d.kim.phillips@freescale.com>	<469FDB3B.5000901@freescale.com>
	<46A01733.6080609@gmail.com> <46A0DF76.90409@freescale.com>
In-Reply-To: <46A0DF76.90409@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: u-boot-users <u-boot-users@lists.sourceforge.net>, linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Jerry Van Baren wrote:
>> Scott Wood wrote:
>>> Kim Phillips wrote:
>>>> The LIBFDT implementation replaces any existing /chosen with its fixed
>>>> up version.
>>
>> Sort of.  If /chosen doesn't exist, it creates it.
>>
>> If /chosen exists and "force" parameter is false, it doesn't touch it. 
>> If "force"  is true, it creates or fixes up properties.  The "bootm" 
>> command passes in force == false.  The "fdt" command passes in force == 
>> true.
>>
>> The "force" parameter was added to sort of emulate the previous bootm 
>> command behavior (but behave better in the case where /chosen already 
>> existed).
> 
> The problem is that "force" is node-granular, rather than 
> property-granular -- If I add a /chosen/linux,stdout-path in the 
> original dts (or via an fdt command), then bootm will decline to add 
> bootargs and initrd information to the /chosen node.
> 
> -Scott

Hi Scott,

Yes, making "force" property-granular makes more sense.  I'll add that 
to my u-boot-fdt repo.

FWIIW, my original proposal (and code) was to *REMOVE* the automagic 
modifications of the fdt blob from the bootm command.  My original 
proposal was to replace "bootm" in scripts (or in the user's fingers) 
with "fdt chosen && fdt env && fdt bd_t && bootm" (or an appropriate 
combination thereof).  I was shouted down.  ;-)

IMHO, having bootm modify the fdt blob is a poor practice.  Bootm's 
mandate is to boot an image from memory, it *shouldn't* be to rewrite 
the fdt blob.  Unfortunately, we had an existing practice (poor, IMHO) 
of having bootm rewrite the fdt blob and so the current implementation 
was done to meet the "user expectation" of bootm "just working" without 
needing to add "fdt xyz" before the bootm command.

gvb
(wipes the foamy spit off his face)
