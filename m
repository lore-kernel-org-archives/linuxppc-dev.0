Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
Date: Fri, 5 May 2006 16:03:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/13] cell: remove broken __setup_cpu_be function
In-Reply-To: <20060429233920.295209000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233920.295209000@localhost.localdomain>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

>  From: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> This patch removes the incorrect Cell processor setup routine
> __setup_cpu_be.  This routine improperly accesses the hypervisor
> page size configuration at SPR HID6.  The correct behavior is for
> firmware, or if needed, platform setup code, to set the correct
> page size.

> -		.cpu_setup		= __setup_cpu_be,
> +		.cpu_setup		= __setup_cpu_power4,

That looks a bit dodgy.  Either just remove the contents of
__setup_cpu_be (leaving only the blr), or define a __setup_cpu_null
that does nothing, or make the identify_cpu not call the cpu setup
function if the pointer is NULL.

Paul.
