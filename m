Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id D101FDE20D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 06:00:33 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so811645anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Apr 2008 12:00:30 -0700 (PDT)
Message-ID: <fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
Date: Thu, 3 Apr 2008 13:00:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Detlev Zundel" <dzu@denx.de>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Question on mpc52xx_common.c
In-Reply-To: <m2wsne9a4c.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <m21w5map5f.fsf@ohwell.denx.de> <m2wsne9a4c.fsf@ohwell.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(cc'ing the mailing list in my reply)

On Thu, Apr 3, 2008 at 10:27 AM, Detlev Zundel <dzu@denx.de> wrote:
> I wrote,
>
>  > debugging a lite5200b kernel (linux-2.6-denx equivalent of 2.6.25-rc8) I
>  > noticed that in mpc52xx_map_common_devices (mpc52xx_common.c:161) the
>  > cdm module is tentatively mapped.  It seems strange to me that there is no
>  > error checking here.  Is a FDT without an cdm entry usable at all?

Sure, why not?  If the firmware has already set it up correctly and no
devices using it are in use, then the kernel should be okay.  :-)
That said, I can't imagine choosing to not put the cdm node into the
device tree.

>  > Checking for the usage of mpc52xx_cdm I found mpc52xx_set_psc_clkdiv
>  > (mpc52xx_common.c:186) only returning ENODEV when no CDM module is
>  > mapped - but still not even a warning.  Now the only user of
>  > set_psc_clkdiv seems to be drivers/spi/mpc52xx_psc_spi.c:342 where the
>  > return value is not even checked....
>  >
>  > Wouldn't at least a warning on a failed mapping be in order here?

By rights, the psc_spi driver should be fixed to report an error.
Other than that, there are no users of the CDM in-tree right now.

>
>  And yes, I've seen that the lite5200 specific code warns on a missing
>  cdm node but thats no help for other platforms....

And that's because older lite5200 firmware doesn't setup the CDM correctly.

Now, all of the mpc5200 common code needs some work I think.  There
are too many places where bestcomm or other code redundantly goes
looking for common device nodes.  I'd like to amalgamate a bunch of
that stuff to map them all at platform initialization time and provide
an api for retrieving the mapped region or for controlling the shared
device.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
