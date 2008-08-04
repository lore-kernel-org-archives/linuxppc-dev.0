Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C1E56DE22C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 01:48:19 +1000 (EST)
Date: Mon, 4 Aug 2008 17:48:13 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: PS3 early lock-up
Message-ID: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-173765489-1217861143=:31424"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-173765489-1217861143=:31424
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0808041648421.31424@vixen.sonytel.be>

On PS3, recent kernels lock up in the very early stage (i.e. before mere
mortals get to see a working console). The kernel crashes with

| kernel BUG at linux/arch/powerpc/platforms/ps3/htab.c:141!

Bisecting shows this happens since:

| commit a1f242ff460e4b50a045fa237c3c56cce9eabf83
| Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
| Date:   Wed Jul 23 21:27:08 2008 -0700
| 
|     powerpc ioremap_prot
|     
|     This adds ioremap_prot and pte_pgprot() so that one can extract protection
|     bits from a PTE and use them to ioremap_prot() (in order to support ptrace
|     of VM_IO | VM_PFNMAP as per Rik's patch).
|     
|     This moves a couple of flag checks around in the ioremap implementations
|     of arch/powerpc.  There's a side effect of allowing non-cacheable and
|     non-guarded mappings on ppc32 which before would always have _PAGE_GUARDED
|     set whenever _PAGE_NO_CACHE is.
|     
|     (standard ioremap will still set _PAGE_GUARDED, but ioremap_prot will be
|     capable of setting such a non guarded mapping).
  
Inside ps3_hpte_insert(), lv1_write_htab_entry() fails with error code 5
(LV1_ACCESS_VIOLATION) when adding the PS3 hotplug memory.

debug_dump_hpte() prints for the offending hpte:

| pa     = 500001000000h
| lpar   = 500001000000h
| va     = adc7d4c2d0000000h
| group  = 6168h
| bitmap = 0h
| hpte.v = adc7d4c2d011h
| hpte.r = 500001000115h
                      ^
| psize  = 0h
| slot   = 6168h

After manually reverting the offending commit, the system boots again. The only
change is:

| pa     = 500001000000h
| lpar   = 500001000000h
| va     = adc7d4c2d0000000h
| group  = 6168h
| bitmap = 0h
| hpte.v = adc7d4c2d011h
| hpte.r = 500001000117h
                      ^
| psize  = 0h
| slot   = 6168h

Note that when adding the initial (non-hotplug) memory, hpte.r always ends in
`194', both before and after reverting the offending commit.

ps3_hpte_insert() seems to be called during system initialization with the
following values of rflags:
  - first call: 0x190
  - initial memory: 0x194 (455 times)
  - hotplug memory:
      o crash: 0x115
      o OK: 0x117

Do you have an idea of what's really going on?

Thanks!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis 293-0376800-10 GEBA-BE-BB
---584349381-173765489-1217861143=:31424--
