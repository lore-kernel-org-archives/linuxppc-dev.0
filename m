Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0120.outbound.protection.outlook.com [207.46.100.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBB981A0063
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 07:33:43 +1000 (AEST)
Message-ID: <1431034399.16357.403.camel@freescale.com>
Subject: Re: [PATCH 1/1] powerpc: mpc85xx: Add board support for ucp1020
From: Scott Wood <scottwood@freescale.com>
To: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
Date: Thu, 7 May 2015 16:33:19 -0500
In-Reply-To: <554BBD10.5050706@arcturusnetworks.com>
References: <1430841121-1997-1-git-send-email-oleks@arcturusnetworks.com>
 <1430968950.16357.369.camel@freescale.com>
 <554B934C.5090406@arcturusnetworks.com>
 <1431022714.16357.396.camel@freescale.com>
 <554BBD10.5050706@arcturusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Michael Durrant <mdurrant@arcturusnetworks.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-07 at 15:29 -0400, Oleksandr G Zhadan wrote:
> On 05/07/2015 02:18 PM, Scott Wood wrote:
> > On Thu, 2015-05-07 at 12:31 -0400, Oleksandr G Zhadan wrote:
> >>>> diff --git a/arch/powerpc/configs/ucp1020_defconfig b/arch/powerpc/configs/ucp1020_defconfig
> >>>> new file mode 100644
> >>>> index 0000000..62f99aa
> >>>> --- /dev/null
> >>>> +++ b/arch/powerpc/configs/ucp1020_defconfig
> >>>
> >>> Please explain why your board needs its own defconfig.
> >>>
> >>
> >> Because, it's our own board and it has some specific to board
> >> definitions like CONFIG_DEFAULT_HOSTNAME and some specific to product
> >> definitions.
> >>
> >> If I can do it in some other way could you please give me some example
> >> if it's possible.
> >
> > I don't think stuff like CONFIG_DEFAULT_HOSTNAME belongs upstream.
> > Could you list what you need to be set that mpc85xx_smp_defconfig
> > doesn't set?
> 
> I make diff "mpc85xx_smp_defconfig" vs "ucp1020_defconfig after make 
> savedefconfig" and it's some differences like:
> 
> - mpc85xx_smp_defconfig has:
> CONFIG_PHYS_64BIT=y
> CONFIG_NR_CPUS=8

These won't prevent your board from working.  If you want
CONFIG_PHYS_64BIT disabled for performance, I could see a fragment being
used for that as per the recent defconfig discussions.  I wouldn't
expect NR_CPUS being 8 instead of 2 to be noticeable.

> - it enabled almost all boards to build. What for ?

Because that's what the common defconfigs are for.  We don't want a
defconfig for each board (most of the board-specific configs that are
currently there were added long ago).  If you want a config that
contains nothing your board doesn't need, you can maintain that locally.

> - it has MTD related differences (doesn't enabled spi flashes support we 
> need):
> -CONFIG_MTD_M25P80=y
> -CONFIG_MTD_SST25L=y

So add them to the existing defconfig.

> - It includes some PHY support, but not phy we are using

This should not harm your board.

>  and we need include intel wifi support:
> -CONFIG_MICREL_PHY=y
> -CONFIG_IWLWIFI=y

So add them to the existing defconfig.

> - It doesn't enable EXT4 fs support.

I think this would be a reasonable thing to add.


> Etc...
> 
> You can see it yourself below:

That doesn't show me the set of changes that you *need*, only the set of
changes that you have.

-Scott
