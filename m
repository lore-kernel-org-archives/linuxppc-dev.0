Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 12:31:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070317013159.GH3969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 12:28:53PM -0500, Scott Wood wrote:
> This adds a library function that platform code can call to set the mac
> addresses of network devices with a linux,network-index property,
> according to a caller-provided table of mac address pointers.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

And I had a function similar to this one, too.  But I think my version
is better.  Extracting it out of the patch I had in progress:

void __dt_fixup_mac_addresses(u32 startindex, ...)
{
       va_list ap;
       u32 index = startindex;
       void *devp;
       void *addr;

       va_start(ap, startindex);
       while ((addr = va_arg(ap, void *))) {
               devp = find_node_by_prop_value(NULL,
linux,network-index",
                                              &index, sizeof(index));

               if (devp)
                      setprop(devp, "local-mac-address", addr, 6);
       }
       va_end(ap);
}

Then a wrapper in the header file to make it more convenient:

#define dt_fixup_mac_addresses(...) \
       __dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)

With this a cuboot platform can simply do:
	dt_fixup_mac_addresses(&bd.enetaddr, &bd.enet1addr, &bd.enet2addr);
or similar with as many parameters as are appropriate.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
