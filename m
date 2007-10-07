Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18184.23379.478676.911097@cargo.ozlabs.ibm.com>
Date: Sun, 7 Oct 2007 14:06:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: TASK_SIZE default 0x80000000 ?
In-Reply-To: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
References: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> In a discussion with Hollis over beer he raised the question why  
> TASK_SIZE is 0x80000000 on ppc32.
> 
> I was wondering if anyone know why this was still the case?  Seems  
> like we have a 1Gb whole between TASK_SIZE & KERNELBASE.

Two reasons: (a) PReP used to map PCI stuff with BATs in the
0x80000000 - 0xbfffffff region, and (b) some embedded ports with
software-loaded TLBs test just the high bit of the address to
determine whether to use the kernel or user page tables.

Paul.
