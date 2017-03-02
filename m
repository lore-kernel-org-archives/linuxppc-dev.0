Return-Path: <jbaron@akamai.com>
Received: from prod-mail-xrelay07.akamai.com (prod-mail-xrelay07.akamai.com
 [23.79.238.175])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vYx99677mzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 02:30:52 +1100 (AEDT)
Subject: Re: [PATCH] module: set __jump_table alignment to 8
To: David Daney <david.daney@cavium.com>, Steven Rostedt
 <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
References: <20170301220453.4756-1-david.daney@cavium.com>
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Chris Metcalf <cmetcalf@mellanox.com>,
 Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>,
 Rabin Vincent <rabin@rab.in>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@kernel.org>,
 Zhigang Lu <zlu@ezchip.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <7bc6b5af-85e0-5b06-f979-368b8b840a16@akamai.com>
Date: Thu, 2 Mar 2017 10:30:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2017 05:04 PM, David Daney wrote:
> For powerpc the __jump_table section in modules is not aligned, this
> causes a WARN_ON() splat when loading a module containing a __jump_table.
>
> Strict alignment became necessary with commit 3821fd35b58d
> ("jump_label: Reduce the size of struct static_key"), currently in
> linux-next, which uses the two least significant bits of pointers to
> __jump_table elements.
>
> Fix by forcing __jump_table to 8, which is the same alignment used for
> this section in the kernel proper.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> ---

Looks good to me.

Reviewed-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason
