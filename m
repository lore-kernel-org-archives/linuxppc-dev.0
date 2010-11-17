Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4CE33C14.9030503@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
	<9129f0a21ea48fb2dcb89cea290e88f3e8c0d8a2.1289943240.git.dirk.brandewie@gmail.com>
	<4CE32453.2090403@caviumnetworks.com> <4CE33C14.9030503@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Nov 2010 19:58:54 -0700
Message-ID: <AANLkTi=T_bqEswe32dTAfL4++WAitc7+VHnyjqP2sQfi@mail.gmail.com>
Subject: Re: [PATCH 1/5] of: Add support for linking device tree blobs into
	vmlinux
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	arjan@linux.intel.com, devicetree-discuss@lists.ozlabs.org,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 7:21 PM, Dirk Brandewie
<dirk.brandewie@gmail.com> wrote:
>
> On 11/16/2010 04:39 PM, David Daney wrote:
>>
>> Thanks for doing this. However I have a few comments...
>>
>> On 11/16/2010 02:41 PM, dirk.brandewie@gmail.com wrote:
>>>
>>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>>
>>> /* .data section */
>>> #define DATA_DATA \
>>> *(.data) \
>>> @@ -468,7 +482,8 @@
>>> MCOUNT_REC() \
>>> DEV_DISCARD(init.rodata) \
>>> CPU_DISCARD(init.rodata) \
>>> - MEM_DISCARD(init.rodata)
>>> + MEM_DISCARD(init.rodata) \
>>> + KERNEL_DTB()
>>>
>>
>> I thought the init.rodata was only for data used by __init things.
>> Although the
>> current linker scripts do not put it in the section that gets recycled as
>> usable
>> memory.
>>
>> IIRC the unflattened version of the device tree has pointers to the
>> flattened
>> data. Since the device tree nodes are live for the entire kernel
>> lifecycle,
>> shouldn't the device tree blobs be in non-init memory?
>>
>
> The contents of the blob get copied to allocated memory during
> unflatten_device_tree() so the blob that is linked in is no longer needed
> after init.

Have you written a patch to add this behaviour?  The current code doesn't.  :-)

g.
