Return-Path: <pku.leo@gmail.com>
Received: from mail-qy0-f175.google.com (mail-qy0-f175.google.com
	[209.85.221.175]) by ozlabs.org (Postfix) with ESMTP id A9E59B7D6D
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 16:49:03 +1000 (EST)
Received: by qyk5 with SMTP id 5so1413316qyk.3
	for <linuxppc-dev@ozlabs.org>; Thu, 06 May 2010 23:49:01 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20100507053851.GA25173@drongo>
References: <3A45394FD742FA419B760BB8D398F9ED0183AF33@zch01exm26.fsl.freescale.net>
	<u2ted82fe3e1005050451q96498ce9jc9f5c0650e00ae2d@mail.gmail.com>
	<m2x2a27d3731005052128w3e9fe517ie3a068b352adb7f3@mail.gmail.com>
	<20100507053851.GA25173@drongo>
Date: Fri, 7 May 2010 14:49:01 +0800
Message-ID: <t2k2a27d3731005062349r4f12256bh7bffc6389b1dfcea@mail.gmail.com>
Subject: Re: Page fault on vmalloc'ed memory
From: Li Yang <leoli@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur.tabi@gmail.com>,
	Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 7, 2010 at 1:38 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Thu, May 06, 2010 at 12:28:44PM +0800, Li Yang wrote:
>
>> The root cause of this oops might not be related with the vmalloc'ed
>> area processing in Instruction Storage Interrupt. =C2=A0But x86 does hav=
e
>> the code for processing it while we don't. =C2=A0Is it because we have
>> nothing to do with the vmalloc'ed ISI on PowerPC architecture?
>
> On PowerPC we always read the kernel page tables rooted at
> swapper_pg_dir to get translations for kernel addresses (those above
> KERNELBASE). =C2=A0We can do that because it is kernel code (software) th=
at
> reads the Linux page tables. =C2=A0On x86, it is hardware that reads the
> Linux page tables, and it always reads the page tables for the current
> process. =C2=A0This means that the kernel part of each process's page
> tables needs to contain copies of all the kernel PTEs on x86. =C2=A0To
> avoid having to set a PTE in every process's page tables when doing a
> vmalloc or ioremap, x86 just creates them in swapper_pg_dir and then
> creates them on demand in each process's page tables as needed.
> That's why they have code to handle vmalloc faults in their page fault
> handler.

Thanks a lot for the explanation.

- Leo
