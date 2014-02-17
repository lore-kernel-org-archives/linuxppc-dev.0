Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C22572C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 06:37:14 +1100 (EST)
Message-ID: <1392665821.6733.630.camel@snotra.buserror.net>
Subject: Re: Anyone using SysRQ key sequences on console serial port ?
From: Scott Wood <scottwood@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 17 Feb 2014 13:37:01 -0600
In-Reply-To: <CAP=VYLpgMYaSVjTwJ2Q15XB+nozz=OhAPU85Nb9xG_FdP5dcyA@mail.gmail.com>
References: <CAGtOQbTRSk32p7U=v9V9GPb_ro+WYbKLLCCfrmdypePcHA++mw@mail.gmail.com>
 <CAP=VYLpgMYaSVjTwJ2Q15XB+nozz=OhAPU85Nb9xG_FdP5dcyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: John Donnelly <john.d@servergy.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-02-16 at 10:56 -0500, Paul Gortmaker wrote:
> On Fri, Feb 14, 2014 at 3:42 PM, John Donnelly <john.d@servergy.com> wrote:
> > Hi,
> >
> >  I tried using the SysRq hotkey sequence on a serial console -
> > 3.11.0-5-powerpc-e500mc system, by issuing a " break " and the system
> > immediately wedges after displaying "SysRQ : HELP : " using both "Putty" and
> > "Teraterm"  terminal emulators. I know the system is dead because my ssh
> > sessions stopped too.
> 
> Yes it does work -- or at least it _did_ work.  Make sure your dts has an entry
> 
>                         compatible = "fsl,ns16550", "ns16550";
> 
> since that enables a workaround I'd added for a hardware errata relating
> to sending breaks over the serial console.   What you describe above
> makes me think you aren't getting the workaround enabled.

Also make sure CONFIG_SERIAL_8250_FSL is enabled.

-Scott
