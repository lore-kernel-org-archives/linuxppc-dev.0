Return-Path: <chris.friesen@genband.com>
Received: from exprod7og101.obsmtp.com (exprod7og101.obsmtp.com [64.18.2.155])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE2FD2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 05:02:18 +1100 (EST)
Message-ID: <51545BF3.2090204@genband.com>
Date: Thu, 28 Mar 2013 09:04:19 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: weird elf header issues, is it binutils or my linker script?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi all,

We're running into an problem with a (somewhat complicated) 32-bit powerpc binary.
When we try to run it, it hits the null-terminated interpreter test in the kernel and
bails out with ENOEXEC.

Looking at the binary with readelf, the program headers contain the following:

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0xf2000034 0xf2000034 0x00120 0x00120 R   0x4
  INTERP         0x000154 0xf2000154 0xf2000154 0x00030 0x0002d R   0x4
      [Requesting program interpreter: /lib/ld.so.1]

Notice the unusually large size of the INTERP header--instead of 0xd it's 0x30.
This causes problems when we try to run, because while the string "/lib/ld.so.1"
is null-terminated it just so happens that the byte at 0x000154+0x00030-1
(which corresponds to elf_interpreter[elf_ppnt->p_filesz - 1] in the kernel code)
is not, and so it fails the kernel test.


We do use a custom linker script when building this binary.  I can only find
two entries related to the interpreter:

PHDRS
{
  headers PT_PHDR PHDRS ;
  interp PT_INTERP ;
<snip>
}

SECTIONS
{
  /* Read-only sections, merged into text segment: */
  PROVIDE (__executable_start = 0xf2000000); . = 0xf2000000 + SIZEOF_HEADERS;
  .interp         : { *(.interp) } :text :interp
<snip>
}

So I'm wondering...is this something wrong with our linker script, or is there a bug
in our binutils?  I'm no linker expert, but the interpreter sections in the script
seem to match the binutils documentation that I found and I don't see anything that
would be messing with the length.

Any suggestions on where to look?

Thanks,
Chris

-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
