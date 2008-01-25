Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3DE0DE20E
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:24 +1100 (EST)
Message-Id: <9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080124154010.GE23246@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc,
	legacy_serial: add support for "soc" compatible matching
Date: Fri, 25 Jan 2008 10:35:06 -0600
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 24, 2008, at 9:40 AM, Anton Vorontsov wrote:

> We'll match on "soc" compatible for generic code, and "fsl,soc"
> for fsl specific code.
>
> Unfortunately it's still impossible to remove device_type = "soc"
> from the existing device tree, because older u-boots are looking for
> it.
>
> Neither we can remove model number from the soc name to heal
> arch/powerpc/boot/cuboot-85xx.c, because then dts'es will be
> incompatible with older u-boots again.
>
> So, just one machine converted so far: MPC8360E-RDK. It's new machine
> so we don't care about backward compatibility yet.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> I know, this patch will conflict with the legacy serial rework[1].
> It's okay though, if [1] will hit galak/powerpc.git first, I'll
> simply rebase that patch.
>
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050096.html
>
> Documentation/powerpc/booting-without-of.txt |   18 ++++------
> arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1 -
> arch/powerpc/kernel/legacy_serial.c          |    3 +-
> arch/powerpc/sysdev/fsl_soc.c                |   51 ++++++++++++++ 
> +-----------
> 4 files changed, 39 insertions(+), 34 deletions(-)

this needs a bit more discussion.  "fsl,soc" is terrible describe.  I  
think we want some generic for the compat that implies 'soc register  
space'.

- k
