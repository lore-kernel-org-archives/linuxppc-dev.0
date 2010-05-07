Return-Path: <paulus@ozlabs.org>
Date: Fri, 7 May 2010 15:38:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: Page fault on vmalloc'ed memory
Message-ID: <20100507053851.GA25173@drongo>
References: <3A45394FD742FA419B760BB8D398F9ED0183AF33@zch01exm26.fsl.freescale.net>
	<u2ted82fe3e1005050451q96498ce9jc9f5c0650e00ae2d@mail.gmail.com>
	<m2x2a27d3731005052128w3e9fe517ie3a068b352adb7f3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2x2a27d3731005052128w3e9fe517ie3a068b352adb7f3@mail.gmail.com>
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

On Thu, May 06, 2010 at 12:28:44PM +0800, Li Yang wrote:

> The root cause of this oops might not be related with the vmalloc'ed
> area processing in Instruction Storage Interrupt.  But x86 does have
> the code for processing it while we don't.  Is it because we have
> nothing to do with the vmalloc'ed ISI on PowerPC architecture?

On PowerPC we always read the kernel page tables rooted at
swapper_pg_dir to get translations for kernel addresses (those above
KERNELBASE).  We can do that because it is kernel code (software) that
reads the Linux page tables.  On x86, it is hardware that reads the
Linux page tables, and it always reads the page tables for the current
process.  This means that the kernel part of each process's page
tables needs to contain copies of all the kernel PTEs on x86.  To
avoid having to set a PTE in every process's page tables when doing a
vmalloc or ioremap, x86 just creates them in swapper_pg_dir and then
creates them on demand in each process's page tables as needed.
That's why they have code to handle vmalloc faults in their page fault
handler.

Paul.
