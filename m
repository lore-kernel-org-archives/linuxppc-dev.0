Return-Path: <miltonm@bga.com>
In-Reply-To: <46323F9F.2050205@linux.vnet.ibm.com>
References: <1177626236.24866.99.camel@luke-laptop> ,
	<1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
	<1177690940.24866.124.camel@luke-laptop>
	<c21def285f4ad2e13914af73f7610c0b@bga.com>
	<1177695045.24866.135.camel@luke-laptop>
	<46323F9F.2050205@linux.vnet.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ff9e68a2df4707129d64e37b7a68fb18@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
Date: Sun, 29 Apr 2007 00:35:33 -0500
To: Haren Myneni <haren@linux.vnet.ibm.com>
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

On Apr 27, 2007, at 1:23 PM, Haren Myneni wrote:
> Luke Browning wrote:
>> On Fri, 2007-04-27 at 11:59 -0500, Milton Miller wrote:
>>> (panic is a function, so you are checking that the staticly linked
>>> non-weak function is available.   If you want to check on when
>>> if its a panic kdump or not, you need to decode the flag and pass
>>> it to kexec_sequence, pass it back here, and update all platforms
>>> for the new parameter).
>>>
>>> But I still say the check while clearing the table is too late,
>>> it should be a debug scan before clearing any mappings.
>>
>> How about the following as an alternative.
>>   BUG_ON((hpte_v & 0x4000000000000000UL) && (crashing_cpus == -1));
>>   BUG_ON((size == MMU_PAGE_16G) && (crashing_cpus == -1));
>>   BUG_ON((size == MMU_PAGE_64K_AP) && (crashing_cpus == -1));
>>
> should be crashing_cpu -  contains the panic cpu ID

and that only exists (or is even declared) when CONFIG_KEXEC,
whereas this code is based on MMU.

>> I don't have time to work on a multi-platform solution.
>>
>> Regards,
>> Luke

We could move the comment to fix this next to the MMU definitions,
and drop the BUG.   For that matter, we probably don't need to
define or save slots for the sizes we don't support.  In other
words, tie adding support to including support for this function.

milton
