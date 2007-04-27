Return-Path: <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <c21def285f4ad2e13914af73f7610c0b@bga.com>
References: <1177626236.24866.99.camel@luke-laptop>
	, <1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177690940.24866.124.camel@luke-laptop>
	<c21def285f4ad2e13914af73f7610c0b@bga.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 14:30:45 -0300
Message-Id: <1177695045.24866.135.camel@luke-laptop>
Mime-Version: 1.0
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

On Fri, 2007-04-27 at 11:59 -0500, Milton Miller wrote:

> 
> I see I've achived my nefarious goal of making these bugs never happen.
> 
> (panic is a function, so you are checking that the staticly linked
> non-weak function is available.   If you want to check on when
> if its a panic kdump or not, you need to decode the flag and pass
> it to kexec_sequence, pass it back here, and update all platforms
> for the new parameter).
> 
> But I still say the check while clearing the table is too late,
> it should be a debug scan before clearing any mappings.

How about the following as an alternative. 

  BUG_ON((hpte_v & 0x4000000000000000UL) && (crashing_cpus == -1));
  BUG_ON((size == MMU_PAGE_16G) && (crashing_cpus == -1));
  BUG_ON((size == MMU_PAGE_64K_AP) && (crashing_cpus == -1));

I don't have time to work on a multi-platform solution.

Regards,
Luke
