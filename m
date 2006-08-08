Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17624.11412.737888.950794@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 16:17:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: PATCH: Enable PCI by default on PPC_86xx boards
In-Reply-To: <1154378023.5107.39.camel@cashmere.sps.mot.com>
References: <1154378023.5107.39.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

>  config PCI
> -	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx ||
> PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) \
> -				  || MPC7448HPC2
> -	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx
> && !PPC_86xx
> +	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx
> \
> +		|| PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2
> +	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
> +		&& !PPC_85xx && !PPC_86xx

I see how that means we offer PCI if PPC_86xx, but I don't see how
that enables it by default...  All you've done to the default y line
is to stick backslash-newline-whitespace in the middle.

(Patch is linewrapped, by the way.)

Paul.
