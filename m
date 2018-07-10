Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: vrbagal1 <vrbagal1@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, sachinp <sachinp@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linuxppc-dev
 <linuxppc-dev-bounces+vrbagal1=linux.vnet.ibm.com@lists.ozlabs.org>
Subject: Re: [powerpc/powervm]Oops: Kernel access of bad area,
 sig: 11 [#1] while running stress-ng
In-Reply-To: <920d9bc6a2c3449700dec191c271bdff@linux.vnet.ibm.com>
References: <8595a4f915a7344210a8cc7ad6923a2b@linux.vnet.ibm.com>
 <20180710180708.6e0cd26b@roar.ozlabs.ibm.com>
 <920d9bc6a2c3449700dec191c271bdff@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2018 23:42:00 +1000
Message-ID: <877em3b42f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vrbagal1 <vrbagal1@linux.vnet.ibm.com> writes:

> On 2018-07-10 13:37, Nicholas Piggin wrote:
>> On Tue, 10 Jul 2018 11:58:40 +0530
>> vrbagal1 <vrbagal1@linux.vnet.ibm.com> wrote:
>> 
>>> Hi,
>>> 
>>> Observing kernel oops on Power9(ZZ) box, running on PowerVM, while
>>> running stress-ng.
>>> 
>>> 
>>> Kernel: 4.18.0-rc4
>>> Machine: Power9 ZZ (PowerVM)
>>> Test: Stress-ng
>>> 
>>> Attached is .config file
>>> 
>>> Traces:
>>> 
>>>   [12251.245209] Oops: Kernel access of bad area, sig: 11 [#1]
>> 
>> Can you post the lines above this? Otherwise we don't know what address
>> it tried to access (without decoding the instructions and 
>> reconstructing
>> it from registers at least, which the XFS devs wouldn't be inclined to
>> do).
>> 
>
> ah my bad.
>
>   [12251.245179] Unable to handle kernel paging request for data at address 0x6000000060000000
>   [12251.245199] Faulting instruction address: 0xc000000000319e2c

Which matches the regs & disassembly:

r4 = 6000000060000000 
r9 = 0
ldx     r9,r4,r9	<- pop

So object was 0x6000000060000000.

That looks like two nops, ie. we got some code?

And there's only one caller of prefetch_freepointer() in slab_alloc_node():

	prefetch_freepointer(s, next_object);


So slab corruption is looking likely.

Do you have slub_debug=FZP on the kernel command line?

cheers
