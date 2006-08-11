Return-Path: <anton@ozlabs.org>
Date: Sat, 12 Aug 2006 07:40:21 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
Message-ID: <20060811214020.GG479@krispykreme>
References: <44D99F56.7010201@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44D99F56.7010201@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

>  drivers/net/ehea/ehea.h    |  452 

> +#define EHEA_DRIVER_NAME	"IBM eHEA"

You are using this for ethtool get_drvinfo. Im not sure if it should
match the module name, and I worry about having a space in the name. Any
ideas on what we should be doing here?

> +#define NET_IP_ALIGN 0

Shouldnt override this in your driver.

> +#define EDEB_P_GENERIC(level, idstring, format, args...) \
> +#define EDEB_P_GENERIC(level,idstring,format,args...) \
> +#define EDEB(level, format, args...) \
> +#define EDEB_ERR(level, format, args...) \
> +#define EDEB_EN(level, format, args...) \
> +#define EDEB_EX(level, format, args...) \
> +#define EDEB_DMP(level, adr, len, format, args...) \

There are a lot of debug statements in the driver. When doing a review
I stripped them all out to make it easier to read. As suggested by
others, using the standard debug macros (where still required) would be
a good idea.

Anton
