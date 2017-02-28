Return-Path: <David.Daney@cavium.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0077.outbound.protection.outlook.com [104.47.34.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXqZF4zxzzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 07:15:17 +1100 (AEDT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To: Jason Baron <jbaron@akamai.com>, David Daney <ddaney@caviumnetworks.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
 <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
 <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
Cc: linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Ralf Baechle <ralf@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>,
 Rabin Vincent <rabin@rab.in>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Zhigang Lu <zlu@ezchip.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
Date: Tue, 28 Feb 2017 12:15:10 -0800
MIME-Version: 1.0
In-Reply-To: <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
Content-Type: multipart/mixed; boundary="------------2F06A5F2FED84D3DFBAD5183"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------2F06A5F2FED84D3DFBAD5183
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/28/2017 11:34 AM, Jason Baron wrote:
>
>
> On 02/28/2017 02:22 PM, David Daney wrote:
>> On 02/28/2017 11:05 AM, David Daney wrote:
>>> On 02/28/2017 10:39 AM, Jason Baron wrote:
>>>>
>> [...]
>>>>> I suspect that the alignment of the __jump_table section in the .ko
>>>>> files is not correct, and you are seeing some sort of problem due to
>>>>> that.
>>>>>
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> Yes, if you look at the trace that Sachin sent the module being loaded
>>>> that does the WARN_ON() is nfsd.ko.
>>>>
>>>> That module from Sachin's trace has:
>>>>
>>>>   [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0
>>>> 18 WAM  0   0  1
>>>
>>> The problem is then the section alignment (last column) for power.
>>>
>>> On mips with no patches applied, we get:
>>>
>>>   [17] __jump_table      PROGBITS        0000000000000000 00d2c0 000048
>>> 00  WA  0   0  8
>>>
>>> Look, proper alignment!
>>>
>>> The question I have is why do the power ".llong" and ".long" assembler
>>> directives not force section alignment?  Is there an alternative that
>>> could be used that would result in the proper alignment?  Would ".word"
>>> work?
>>>
>>> If not, then I would say patch only power with your balign thing. 8-byte
>>> alignment for 64-bit kernel, 4-byte alignment for 32-bit kernel
>>>
>>
>> I think the proper fix is either:
>>
>> A) Modify scripts/module-common.lds to force __jump_table alignment for
>> all architectures.
>>
>> B) Add arch/powerpc/kernel/module.lds to force __jump_table alignment
>> for powerpc only.
>>
>> David.
>>
>>
>
> Ok, I can try adding it to the linger script.
>
> FWIW, here is my before and after with the .balign thing for the nfsd.ko
> module on powperc (using a cross-compiler):
>
> before:
>
>   [31] __jump_table      PROGBITS        0000000000000000 03ee3e 0000f0
> 00  WA  0   0  1
>
> after:
>
>  [31] __jump_table      PROGBITS        0000000000000000 03ee40 0000f0
> 00  WA  0   0  4
>

Try the (lightly tested) attached.

If it works and Steven likes it, perhaps someone can merge it.

David.






--------------2F06A5F2FED84D3DFBAD5183
Content-Type: text/x-patch;
 name="0001-module-set-__jump_table-alignment-to-8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-module-set-__jump_table-alignment-to-8.patch"

>From 89d4deafbc920351b93afb1ac4b4124995e1f19d Mon Sep 17 00:00:00 2001
From: David Daney <david.daney@cavium.com>
Date: Tue, 28 Feb 2017 12:10:02 -0800
Subject: [PATCH] module: set __jump_table alignment to 8

For powerpc the __jump_table section in modules is not aligned, this
causes an OOPS when loading a module containing a __jump_table.

Fix by forcing __jump_table to 8, which is the same alignment used for
this section in the kernel proper.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 scripts/module-common.lds | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/module-common.lds b/scripts/module-common.lds
index 73a2c7d..53234e8 100644
--- a/scripts/module-common.lds
+++ b/scripts/module-common.lds
@@ -19,4 +19,6 @@ SECTIONS {
 
 	. = ALIGN(8);
 	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
+
+	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
-- 
2.9.3


--------------2F06A5F2FED84D3DFBAD5183--
