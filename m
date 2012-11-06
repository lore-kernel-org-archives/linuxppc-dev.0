Return-Path: <anton@samba.org>
Date: Tue, 6 Nov 2012 12:25:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/perf: Fix finding overflowed PMC in interrupt
Message-ID: <20121106122559.38ea906f@kryten>
In-Reply-To: <1352164118-19450-1-git-send-email-mikey@neuling.org>
References: <20120921003805.GA4507@us.ibm.com>
 <1352164118-19450-1-git-send-email-mikey@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <^Cnh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Thanks for looking into this mess. One small thing we can fix in a
follow up patch:

> +	if (!found)
> +		printk(KERN_WARNING "Can't find PMC that caused

I think it would be worth making that a printk_ratelimited. We are
probably dead at this stage but we shouldn't spam the console
at ludicrous speed in the process.

Anton
