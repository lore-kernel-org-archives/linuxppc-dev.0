Return-Path: <miltonm@bga.com>
In-Reply-To: <1177690940.24866.124.camel@luke-laptop>
References: <1177626236.24866.99.camel@luke-laptop> ,
	<1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177690940.24866.124.camel@luke-laptop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c21def285f4ad2e13914af73f7610c0b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
Date: Fri, 27 Apr 2007 11:59:07 -0500
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2007, at 11:22 AM, Luke Browni+	/*
> +	 * FIXME, the code below works for 16M, 64K, and 4K pages as these
> +	 * fall under the p<=23 rules for calculating the virtual address.
> +	 * In the case of 16M pages, an extra bit is stolen from the AVPN
> +	 * field to achieve the requisite 24 bits.
> +	 *
> +	 * You can use kexec -l to debug new page support!
> +	 */
> +	BUG_ON(hpte_v & 0x4000000000000000UL && !panic);   /* 1T segment */
> +	BUG_ON(size == MMU_PAGE_16G && !panic);
> +	BUG_ON(size == MMU_PAGE_64K_AP && !panic);
> +

I see I've achived my nefarious goal of making these bugs never happen.

(panic is a function, so you are checking that the staticly linked
non-weak function is available.   If you want to check on when
if its a panic kdump or not, you need to decode the flag and pass
it to kexec_sequence, pass it back here, and update all platforms
for the new parameter).

But I still say the check while clearing the table is too late,
it should be a debug scan before clearing any mappings.

milton
