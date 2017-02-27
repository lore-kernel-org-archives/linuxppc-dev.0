Return-Path: <David.Daney@cavium.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0060.outbound.protection.outlook.com [104.47.34.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXGyM2bGqzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 09:45:47 +1100 (AEDT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To: Steven Rostedt <rostedt@goodmis.org>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
 Jason Baron <jbaron@akamai.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Rabin Vincent <rabin@rab.in>,
 Russell King <linux@armlinux.org.uk>, Chris Metcalf <cmetcalf@mellanox.com>,
 Zhigang Lu <zlu@ezchip.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Date: Mon, 27 Feb 2017 14:45:37 -0800
MIME-Version: 1.0
In-Reply-To: <20170227173630.57fff459@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/27/2017 02:36 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 14:21:21 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> See attached for mips.  It seems to do the right thing.
>>
>> I leave it as an exercise to the reader to fix the other architectures.
>>
>> Consult your own  binutils experts to verify that what I say is true.
>
> It may still just be safer to do the pointers instead. That way we
> don't need to worry about some strange arch or off by one binutils
> messing it up.

Obviously it is your choice, but this is bog standard ELF linking.  In 
theory even the arrays of power-of-2 sized objects should also supply an 
entity size.  Think __ex_table and its ilk.


The benefit of supplying an entsize is that you don't have to change the 
structure of the existing code and risk breaking something in the process.

David Daney
