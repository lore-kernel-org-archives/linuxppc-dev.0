Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091009063534.GC12948@yookeroo.seuss>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
	<20091009063534.GC12948@yookeroo.seuss>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Oct 2009 01:07:57 -0600
Message-ID: <fa686aa40910090007lef3fddbod0c5843abfe33be5@mail.gmail.com>
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device tree
	representation
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 9, 2009 at 12:35 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, Oct 06, 2009 at 10:30:59PM -0600, Grant Likely wrote:
>> Add a common header file for working with the flattened device tree
>> data structure and merge the shared data tags used by Microblaze and
>> PowerPC
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0arch/microblaze/include/asm/prom.h | =A0 12 +-----------
>> =A0arch/powerpc/include/asm/prom.h =A0 =A0| =A0 12 +-----------
>> =A0include/linux/of_fdt.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 30 +++++++++++++=
+++++++++++++++++
>> =A03 files changed, 32 insertions(+), 22 deletions(-)
>> =A0create mode 100644 include/linux/of_fdt.h
>>
>> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/includ=
e/asm/prom.h
>> index 64e8b3a..5f461f0 100644
>> --- a/arch/microblaze/include/asm/prom.h
>> +++ b/arch/microblaze/include/asm/prom.h
>> @@ -17,20 +17,10 @@
>> =A0#ifndef _ASM_MICROBLAZE_PROM_H
>> =A0#define _ASM_MICROBLAZE_PROM_H
>> =A0#ifdef __KERNEL__
>> -
>> -/* Definitions used by the flattened device tree */
>> -#define OF_DT_HEADER =A0 =A0 =A0 =A0 0xd00dfeed /* marker */
>> -#define OF_DT_BEGIN_NODE =A0 =A0 0x1 /* Start of node, full name */
>> -#define OF_DT_END_NODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2 /* End node */
>> -#define OF_DT_PROP =A0 =A0 =A0 =A0 =A0 0x3 /* Property: name off, size,=
 content */
>> -#define OF_DT_NOP =A0 =A0 =A0 =A0 =A0 =A00x4 /* nop */
>> -#define OF_DT_END =A0 =A0 =A0 =A0 =A0 =A00x9
>> -
>> -#define OF_DT_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
>
>
> So, if you're merging all these, I guess the question is do we also
> want to merge them with scripts/dtc/libfdt/fdt.h, and by extension
> with the upstream libfdt header file which defines the same things.

I see your question and raise you another.  Where should the merge
file live for it to be included both by dtc and kernel code? Or should
it just be cloned in the kernel tree?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
