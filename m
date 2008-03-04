Return-Path: <linux.matthew@gmail.com>
Message-ID: <38e5df7d0803041356v1816aaabnf6917670a5e689c7@mail.gmail.com>
Date: Tue, 4 Mar 2008 16:56:03 -0500
From: "Matthew Clark" <linux.matthew@gmail.com>
To: Linuxppc-dev@ozlabs.org
Subject: Unable to set cache write-thru on 7447A
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to run my 2.6.14 Gentoo distro on a 7447A system I have
with different cache configurations (ie, write back vs write thru) for
both the kernel, system apps (sshd, etc) and user apps.  I first
wanted to run entirely in Write-Thru to get a worst-case benchmark,
but after discovering (to my chagrin) that the 7447A doesn't honor the
L2CR_L2WT bit, I tried something a bit more adventurous by setting the
WIMG bits on the linux PTE's in the arch/ppc files.

Rather, I thought I would.  Nothing I've tried seems to work.

In arch/ppc/mm/ppc_mmu.c
Adding _PAGE_WRITETHRU to the _PAGE_RAM flag in the setbat calls at
lines 112 & 120 results in a kernel that won't go past the
"Uncompressing" step.

In arch/ppc/mm/pgtables.c
If I add _PAGE_WRITETHRU to the _PAGE_RAM flag in mapin_ram and
map_page allows the kernel to boot, and in fact shows no noticable
performance difference.

I found in arch/ppc/mm/hashtable.S that the linux PTE's aren't
entirely transferred into the HPTE's of the PPC, so with some
reluctance, I tried adding a line turning on WRITETHRU at line 350 in
create_hpte:

ori r8,r8,_PAGE_WRITETHRU

The kernel will come up, but init promptly dies with Signal 11.

There's little documentation on PPC Memory management & the linux
kernel, so I'm not sure what do to from here.  Can anyone help me out
here?  Thanks.

Matt
