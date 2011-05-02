Return-Path: <Hollis_Blanchard@mentor.com>
Message-ID: <4DBED5E9.2070201@mentor.com>
Date: Mon, 02 May 2011 09:03:53 -0700
From: Hollis Blanchard <hollis_blanchard@mentor.com>
MIME-Version: 1.0
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Re: [PATCH 2/2] powerpc: add support for MPIC message register API
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>	<1303232375-25014-3-git-send-email-meador_inge@mentor.com>	<071A08F2C6A57E4E94D980ECA553F8741959CA@039-SN1MPN1-004.039d.mgd.msft.net>	<4DBAED5D.4060906@mentor.com>	<071A08F2C6A57E4E94D980ECA553F8741967EC@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110429123051.4ed1ca01@schlenkerla.am.freescale.net>
	<071A08F2C6A57E4E94D980ECA553F8741984EE@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F8741984EE@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Meador Inge <meador_inge@mentor.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"openmcapi-dev@googlegroups.com" <openmcapi-dev@googlegroups.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2011 08:41 PM, Kushwaha Prabhakar-B32579 wrote:
>>>>> Hi,
>>>>>
>>>>> I have no comments about coding and architecture. It looks fine.
>>>>>
>>>>> Only have a query about its use case..
>>>>>     "Any application intended to use message interrupt requires to
>>>>> know
>>>> reg_num because of struct mpic_msgr* mpic_msgr_get(unsigned int
>>>> reg_num) API"
>>>>> It will be good to search available unit internally and provide
>>>>> its
>>>> pointer. It will make application more flexible.
>>>> The problem is that you fundamentally cannot implement an allocator
>>>> for MSG registers if you're going to communicate with another kernel
>>>> (how would both kernels' allocators be synchronized?). So the
>>>> message register allocation must be decided at design time, not run time.
>>> I agree with you..  It is true while communicating with another kernel.
>>> But message interrupts can be used by different independent drivers
>> within same kernel. For eg. PCIe and Ethernet driver.
>>> As per current design both drivers needs to be in sync before
>> requesting any message unit for avoiding any conflict. As these drivers
>> are completely independent. It is very difficult.
>>> Can it be possible to provide new API to take care it.
>> Do you have a real use case in mind where these message registers (not
>> MSIs) are used internally in this manner?
> Yes, we use for PCIe host/agent test case scenario.
> Host usage message register to interrupt Agent...
> Agent uses message register to generate irq_out (automatically generate MSI) to interrupt master. Please see RM for more details about irq_out
>
>
> Note: PCIe host/agent test scenario is used internally and we are working on pushing it out..

I believe this has been true for several years.

>> Perhaps an allocator could be added in the same patchset that adds such a
>> user.
> Yaa. It can be done. Otherwise module has to query each message unit for its availability.

No, instead the system designer should pick one. If it doesn't matter 
which one, then the designer is free to pick any.

An allocator can't work if you're going to mix drivers. For example, 
driver A needs MSRG0, and driver B doesn't care. Driver B loads first, 
the allocator selects MSGR0; driver A loads and fails. Having an 
allocator at all will create this conflict.

To prevent this scenario, either don't use a MSGR (can you configure 
anything else for irq_out?), or have the system designer choose all MSGRs.

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
