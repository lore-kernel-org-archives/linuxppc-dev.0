Return-Path: <jeyu@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ13p1GpNzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 05:26:30 +1100 (AEDT)
Date: Thu, 2 Mar 2017 13:26:25 -0500
From: Jessica Yu <jeyu@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
 David Daney <david.daney@cavium.com>, Jason Baron <jbaron@akamai.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Chris Metcalf <cmetcalf@mellanox.com>, Ralf Baechle <ralf@linux-mips.org>,
 Russell King <linux@armlinux.org.uk>, Rabin Vincent <rabin@rab.in>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>
Subject: Re: [PATCH] module: set __jump_table alignment to 8
Message-ID: <20170302182625.GB13268@packer-debian-8-amd64.digitalocean.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <20170302131119.6f52203f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170302131119.6f52203f@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+++ Steven Rostedt [02/03/17 13:11 -0500]:
>
>Can I get an Ack from a module maintainer?

Acked-by: Jessica Yu <jeyu@redhat.com>

Thanks!

Jessica

>On Wed,  1 Mar 2017 14:04:53 -0800
>David Daney <david.daney@cavium.com> wrote:
>
>> For powerpc the __jump_table section in modules is not aligned, this
>> causes a WARN_ON() splat when loading a module containing a __jump_table.
>>
>> Strict alignment became necessary with commit 3821fd35b58d
>> ("jump_label: Reduce the size of struct static_key"), currently in
>> linux-next, which uses the two least significant bits of pointers to
>> __jump_table elements.
>>
>> Fix by forcing __jump_table to 8, which is the same alignment used for
>> this section in the kernel proper.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>> ---
>>  scripts/module-common.lds | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
>> index 73a2c7d..53234e8 100644
>> --- a/scripts/module-common.lds
>> +++ b/scripts/module-common.lds
>> @@ -19,4 +19,6 @@ SECTIONS {
>>
>>  	. = ALIGN(8);
>>  	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
>> +
>> +	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>>  }
>
