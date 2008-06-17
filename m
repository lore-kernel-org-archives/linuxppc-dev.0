Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id A4ABDDE297
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 07:00:12 +1000 (EST)
Date: Tue, 17 Jun 2008 23:00:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
Message-ID: <20080617210055.GA13468@uranus.ravnborg.org>
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<48581188.90102@freescale.com>
	<20080617195739.GB13147@uranus.ravnborg.org>
	<485818AA.8090701@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <485818AA.8090701@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, John Rigby <jrigby@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 03:03:54PM -0500, Scott Wood wrote:
> Sam Ravnborg wrote:
> >On Tue, Jun 17, 2008 at 02:33:28PM -0500, Scott Wood wrote:
> >>John Rigby wrote:
> >>>config FS_ENET
> >>>       tristate "Freescale Ethernet Driver"
> >>>-       depends on CPM1 || CPM2
> >>>+       depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
> >>>       select MII
> >>>       select PHYLIB
> >>>
> >>>+config FS_ENET_MPC5121_FEC
> >>>+	bool "Freescale MPC512x FEC driver"
> >>>+	depends on PPC_MPC512x
> >>>+	select FS_ENET
> >>>+	select PPC_CPM_NEW_BINDING
> >>>+	default y
> >>No default y.
> >I by the way do not see the need for the prompt of FS_ENET.
> 
> Agreed, especially since it's overly broad (there is Freescale ethernet 
> hardware that this driver doesn't support).  We'd need to change depends 
> into selects in the more specific entries.
> 
> >Do you ever want to change it if one of the dependencies
> >are selected?
> 
> Do you mean if CPM1 or CPM2 is selected?  Yes, it's quite possible that 
> the user has no need for the CPM ethernet and would rather reclaim the 
> memory (especially on CPM1, which has boards as small as 8MiB).

I took a closer look now.
And I can see that FS_ENET is indeed a driver and CPM1, CPM2,  FS_ENET_MPC5121_FEC
are all booleans that say that it may make sense to use this driver.

But I was misguided by:
>+config FS_ENET_MPC5121_FEC
>+  select FS_ENET
This is not good.

In general when you select a symbol that has dependencies you are almost
always on the wrong track.
Use a dependency here with a sane default - then people can 
set it to 'n' if they really do not want this driver.

Spreading selects too much is just causing you pain in the long run.

	Sam
