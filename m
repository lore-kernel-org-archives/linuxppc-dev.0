Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC01BC068F@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Cross compiling : problem linking
Date: Thu, 2 Oct 2003 18:34:19 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Note to the list: sorry for the RFC2822

> Do you know the replacement for iopl to work on PowerPC?

There's no such crap on PowerPC. No separate IO bus either.


> Final goal is a kernel module, but now I'm writing a test program in
> user space (standalone, dynamic compiled).

Okay, let's use ESP for once :)

Toni, I don't know what's your "base" address, but it is really odd
(well, both ways :) on a PowerPC system. You should borrow some help
from your D-science lab, or have something like a PPC Linux training.


Wolfgang, you've got my agreement to put the following in the FAQ
if it's not already.


This code is for accessing hardware registers from *userland*.
You need CAP_SYS_RAWIO and /dev/mem permissions.

Basically:
	volatile void *p = ioremap(MY_HARD_REG_ADDR, 4096);
	...
	out_8(p, state ^= 0x1);




#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#ifdef __PPC__
extern inline void out_8(volatile unsigned char *addr, int val)
{
        __asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r"
(val));
}
#else
extern inline void out_8(volatile unsigned char *addr, int val)
{
        *add = val & 0xff;
}
#endif

extern inline volatile void * ioremap(unsigned long physaddr, unsigned size)
{
    static int axs_mem_fd = -1;
    unsigned long page_addr, ofs_addr, reg, pgmask;
    void* reg_mem = NULL;

    /*
     * looks like mmap wants aligned addresses?
     */
    pgmask = getpagesize()-1;
    page_addr = physaddr & ~pgmask;
    ofs_addr  = physaddr & pgmask;

    /*
     * Don't forget O_SYNC, esp. if address is in RAM region.
     * Note: if you do know you'll access in Read Only mode,
     *    pass O_RDONLY to open, and PROT_READ only to mmap
     */
    if (axs_mem_fd == -1) {
        axs_mem_fd = open("/dev/mem", O_RDWR|O_SYNC);
        if (axs_mem_fd < 0) {
                perror("AXS: can't open /dev/mem");
                return NULL;
        }
    }

    /* memory map */
    reg_mem = mmap(
        (caddr_t)reg_mem,
        size+ofs_addr,
        PROT_READ|PROT_WRITE,
        MAP_SHARED,
        axs_mem_fd,
        page_addr
    );
    if (reg_mem == MAP_FAILED) {
        perror("AXS: mmap error");
        close(axs_mem_fd);
        return NULL;
    }

    reg = (unsigned long )reg_mem + ofs_addr;
    return (volatile void *)reg;
}

extern inline int iounmap(volatile void *start, size_t length)
{
    unsigned long ofs_addr;
    ofs_addr = (unsigned long)start & (getpagesize()-1);

    /* do some cleanup when you're done with it */
    return munmap((void*)start-ofs_addr, length+ofs_addr);
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
