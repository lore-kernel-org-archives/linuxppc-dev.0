Return-Path: <paulus@ozlabs.org>
Message-ID: <18260.59921.473117.994246@cargo.ozlabs.ibm.com>
Date: Tue, 4 Dec 2007 16:48:01 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powermac: proper sleep management
In-Reply-To: <1194981933.6695.17.camel@johannes.berg>
References: <1194981933.6695.17.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> +		printk(KERN_INFO
> +		       "via-pmu: the PMU_IOC_SLEEP ioctl is deprecated.\n");
> +		printk(KERN_INFO "via-pmu: use \"echo mem >"
> +		       " /sys/power/state\"  instead!\n");
> +		printk(KERN_INFO
> +		       "via-pmu: this ioctl will be removed soon.\n");

I don't like this.  I would rather keep the ioctls indefinitely and
not make any noise about programs using them.  The ioctls are part of
the kernel/user ABI, and thus need to be preserved, especially since
it only takes about 6 or 7 lines of code to implement them.

Paul.
