Return-Path: <David.Daney@cavium.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0045.outbound.protection.outlook.com [104.47.34.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXFWz6YqczDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 08:41:19 +1100 (AEDT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To: Steven Rostedt <rostedt@goodmis.org>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
Cc: Jason Baron <jbaron@akamai.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Rabin Vincent <rabin@rab.in>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Chris Metcalf <cmetcalf@mellanox.com>, Zhigang Lu <zlu@ezchip.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
Date: Mon, 27 Feb 2017 13:41:13 -0800
MIME-Version: 1.0
In-Reply-To: <20170227160601.5b79a1fe@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2017 01:06 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 11:59:50 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> For me the size is not the important issue, it is the alignment of the
>> struct jump_entry entries in the table.  I don't understand how your
>> patch helps, and I cannot Acked-by unless I understand what is being
>> done and can see that it is both correct and necessary.
>
> You brought up a very good point and I'm glad that I had Jason Cc all
> the arch maintainers in one patch.
>
> I think jump_labels may be much more broken than we think, and Jason's
> fix doesn't fix anything. We had this same issues with tracepoints.
>
> I'm looking at jump_label_init, and how we iterate over an array of
> struct jump_entry's that was put together by the linker. The problem is
> that jump_entry is not a power of 2 in size.
>

ELF sections may have an ENTSIZE property exactly for arrays.  Since 
each jump_entry will have a unique value they cannot be merged, but we 
can tell the assembler they are an array and get them properly packed. 
Perhaps something like (untested):

    .pushsection __jump_table,  \"awM\",@progbits,24
    FOO
    .popsection


> struct jump_entry {
> 	jump_label_t code;
> 	jump_label_t target;
> 	jump_label_t key;
> };
>
> When putting together arrays of this kind, the linker is in its right
> to add padding for alignment, in the middle of the array! It has no
> idea that this is an array, and there's nothing stopping the linker
> from messing it up.
>
> For those structs that are a power of 2 in size, there's no reason for
> the linker to do anything else, and it "just works". There's plenty of
> instances in the kernel that depend on this.
>
> I'm thinking that the sort algorithm either hid the problem or fixed it
> somehow (I'm guessing it hid the problem).
>
> I hit the same issue with trace event structures. The solution was to
> create the array of pointers to each structure, and dereference the
> structures from the array.
>
> See commit e4a9ea5ee ("tracing: Replace trace_event struct array with
> pointer array")
>
> -- Steve
>
