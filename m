Message-ID: <40CDDAC7.4090608@mvista.com>
Date: Mon, 14 Jun 2004 10:05:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
References: <1087207803.7360.83.camel@newt>
In-Reply-To: <1087207803.7360.83.camel@newt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox wrote:

> <snip>
>
>-	if (host_bridge != MPC10X_BRIDGE_106) {
>+	if (host_bridge == MPC10X_BRIDGE_106) {
>+		/* On-chip peripherals were introduced with the MPC107/MPC8240 */
>+		core_ocp[0].vendor = OCP_VENDOR_INVALID;
>

><snip>
>

> 		OpenPIC_Addr =
> 			ioremap(phys_eumb_base + MPC10X_EUMB_EPIC_OFFSET,
> 				MPC10X_EUMB_EPIC_SIZE);
>+#endif
>+		core_ocp[0].paddr = phys_eumb_base + MPC10X_EUMB_I2C_OFFSET;
> 	}
>
>

That's great that you're OCP-ifying the mpc10x code!  My only comment is
thatI don't like hardcoding the position of an entry in the OCP (e.g.,
core_ocp[0].vedor/paddr).  I don't think its safe to assume that any
particular piece of code will always know all of the entries in the OCP
and therefore what an entry's position will be.  You can use
'ocp_for_each_device()' and a routine that checks for the fields that
you want to accomplish the same thing.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
