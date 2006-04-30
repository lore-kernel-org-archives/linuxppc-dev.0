Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20060429233922.167124000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233922.167124000@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] cell: split out board specific files
Date: Sun, 30 Apr 2006 04:52:50 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Split the Cell BE support into generic and platform
> dependant parts.
>
> Creates a new config variable CONFIG_PPC_IBM_CELL_BLADE.
> The existing CONFIG_PPC_CELL is now used to denote the
> generic Cell processor support.  Also renames spu_priv1.c
> to spu_priv1_mmio.c.

>  config CELL_IIC
> -	depends on PPC_CELL
> +	depends on PPC_IBM_CELL_BLADE
>  	bool
>  	default y

Erm no...  Make this

	depends on PPC_CELL && !SOME_HYPERVISOR_THING

to reflect the _real_ dependency please?  Similar in a few other
places perhaps.


Segher
