Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 29FFD679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 07:28:16 +1000 (EST)
Date: Wed, 10 May 2006 23:30:28 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
Message-ID: <20060510213028.GG3878@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 06:04:13PM +0200, Johannes Berg wrote:

> Also, try snd-aoa.

Impossible here, it does not compile here. Neither with gcc 4.0 or 4.1

I took your instructions from
http://lists.debian.org/debian-powerpc/2006/03/msg00470.html

And if I understand them correctly it's not necessary to descend to
some directory level of the kernel source for my current kernel. I
slightly modified your instructions (being addicted to git, Sorry
about that ... :) .. :

Something like:

mkdir snd-aoa
cd snd-aoa/
git clone http://johannes.sipsolutions.net/snd-aoa.git/ 
cd snd-aoa/ 
make


The above did not work: compile problems:
-----------------
include/sound/pcm.h:742: error: dereferencing pointer to incomplete type
include/sound/pcm.h: In function 'snd_pcm_capture_empty':
include/sound/pcm.h:755: error: dereferencing pointer to incomplete type
include/sound/pcm.h: In function 'snd_pcm_trigger_done':
include/sound/pcm.h:762: error: dereferencing pointer to incomplete type
include/sound/pcm.h: At top level:
include/sound/pcm.h:844: error: syntax error before 'u_int32_t'
include/sound/pcm.h:844: warning: function declaration isn't a prototype
include/sound/pcm.h:846: error: syntax error before 'u_int64_t'
include/sound/pcm.h:846: warning: function declaration isn't a prototype
include/sound/pcm.h:901: error: syntax error before 'snd_pcm_format_size'
include/sound/pcm.h:901: error: syntax error before 'size_t'
include/sound/pcm.h:901: warning: type defaults to 'int' in declaration of 'snd_pcm_format_size'
include/sound/pcm.h:901: warning: function declaration isn't a prototype
include/sound/pcm.h:901: warning: data definition has no type or storage class
include/sound/pcm.h: In function 'snd_pcm_set_runtime_buffer':
include/sound/pcm.h:936: error: dereferencing pointer to incomplete type
include/sound/pcm.h:938: error: dereferencing pointer to incomplete type
include/sound/pcm.h:939: error: dereferencing pointer to incomplete type
include/sound/pcm.h:939: error: dereferencing pointer to incomplete type
include/sound/pcm.h:940: error: dereferencing pointer to incomplete type
include/sound/pcm.h:940: error: dereferencing pointer to incomplete type
include/sound/pcm.h:941: error: dereferencing pointer to incomplete type
include/sound/pcm.h:941: error: dereferencing pointer to incomplete type
include/sound/pcm.h:943: error: dereferencing pointer to incomplete type
include/sound/pcm.h:944: error: dereferencing pointer to incomplete type
include/sound/pcm.h:945: error: dereferencing pointer to incomplete type
include/sound/pcm.h:946: error: dereferencing pointer to incomplete type
include/sound/pcm.h: At top level:
include/sound/pcm.h:966: error: syntax error before 'size_t'
include/sound/pcm.h:966: warning: function declaration isn't a prototype
include/sound/pcm.h:969: error: syntax error before 'size_t'
include/sound/pcm.h:969: warning: function declaration isn't a prototype
include/sound/pcm.h:970: error: syntax error before 'size_t'
include/sound/pcm.h:970: warning: function declaration isn't a prototype
include/sound/pcm.h: In function 'snd_pcm_mmap_data_open':
include/sound/pcm.h:981: error: dereferencing pointer to incomplete type
include/sound/pcm.h:982: error: dereferencing pointer to incomplete type
include/sound/pcm.h: In function 'snd_pcm_mmap_data_close':
include/sound/pcm.h:987: error: dereferencing pointer to incomplete type
include/sound/pcm.h:988: error: dereferencing pointer to incomplete type
include/sound/pcm.h: At top level:
include/sound/pcm.h:1000: error: syntax error before 'size_t'
include/sound/pcm.h:1001: warning: function declaration isn't a prototype
include/sound/pcm.h: In function 'snd_pcm_limit_isa_dma_size':
include/sound/pcm.h:1002: error: 'max' undeclared (first use in this function)
include/sound/pcm.h:1002: error: 'dma' undeclared (first use in this function)
In file included from /home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/aoa.h:21,
                 from /home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:14:
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h: At top level:
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:37: error: syntax error before 'u64'
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:37: warning: no semicolon at end of struct or union
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:40: error: syntax error before 'transfer_in'
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:44: error: syntax error before '}' token
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:142: error: field 'ofdev' has incomplete type
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:169: error: syntax error before 'u32'
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:169: warning: no semicolon at end of struct or union
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:193: error: field 'driver' has incomplete type
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c: In function 'attach_codec_to_fabric':
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:33: error: 'ENOENT' undeclared (first use in this function)
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c: In function 'aoa_fabric_register':
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:85: error: 'EALREADY' undeclared (first use in this function)
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:89: error: 'EEXIST' undeclared (first use in this function)
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:91: error: 'EINVAL' undeclared (first use in this function)
make[3]: *** [/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.o] Error 1
make[2]: *** [/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa] Error 2
make[1]: *** [_module_/home/shorty/kernel-factory/git/snd-aoa/snd-aoa] Error 2
make[1]: Leaving directory `/home/shorty/kernel-factory/git/linux-2.6'
make: *** [modules] Error 2
----------------

FYI:
------------------------
$ gcc --version
gcc (GCC) 4.0.4 20060422 (prerelease) (Debian 4.0.3-2)
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-------------------------------------------

Same being true for this:


$ pwd 
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa
$ make clean
$ MAKEFLAGS="CC=gcc-4.1" make

The end from the latter command:

--------------
include/sound/pcm.h:669: error: 'struct snd_pcm_runtime' has no member named 'status'
include/sound/pcm.h:669: error: 'struct snd_pcm_runtime' has no member named 'control'
include/sound/pcm.h:671: error: 'struct snd_pcm_runtime' has no member named 'boundary'
include/sound/pcm.h: In function 'snd_pcm_playback_ready':
include/sound/pcm.h:695: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h:696: error: 'struct snd_pcm_runtime' has no member named 'control'
include/sound/pcm.h: In function 'snd_pcm_capture_ready':
include/sound/pcm.h:709: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h:710: error: 'struct snd_pcm_runtime' has no member named 'control'
include/sound/pcm.h: In function 'snd_pcm_playback_data':
include/sound/pcm.h:724: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h:726: error: 'struct snd_pcm_runtime' has no member named 'stop_threshold'
include/sound/pcm.h:726: error: 'struct snd_pcm_runtime' has no member named 'boundary'
include/sound/pcm.h: In function 'snd_pcm_playback_empty':
include/sound/pcm.h:741: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h: In function 'snd_pcm_capture_empty':
include/sound/pcm.h:755: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h: In function 'snd_pcm_trigger_done':
include/sound/pcm.h:762: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h: At top level:
include/sound/pcm.h:844: error: expected declaration specifiers or '...' before 'u_int32_t'
include/sound/pcm.h:846: error: expected declaration specifiers or '...' before 'u_int64_t'
include/sound/pcm.h:901: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'snd_pcm_format_size'
include/sound/pcm.h: In function 'snd_pcm_set_runtime_buffer':
include/sound/pcm.h:936: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h:938: error: 'struct snd_pcm_runtime' has no member named 'dma_buffer_p'
include/sound/pcm.h:939: error: 'struct snd_pcm_runtime' has no member named 'dma_area'
include/sound/pcm.h:940: error: 'struct snd_pcm_runtime' has no member named 'dma_addr'
include/sound/pcm.h:940: error: 'struct snd_dma_buffer' has no member named 'addr'
include/sound/pcm.h:941: error: 'struct snd_pcm_runtime' has no member named 'dma_bytes'
include/sound/pcm.h:941: error: 'struct snd_dma_buffer' has no member named 'bytes'
include/sound/pcm.h:943: error: 'struct snd_pcm_runtime' has no member named 'dma_buffer_p'
include/sound/pcm.h:944: error: 'struct snd_pcm_runtime' has no member named 'dma_area'
include/sound/pcm.h:945: error: 'struct snd_pcm_runtime' has no member named 'dma_addr'
include/sound/pcm.h:946: error: 'struct snd_pcm_runtime' has no member named 'dma_bytes'
include/sound/pcm.h: At top level:
include/sound/pcm.h:966: error: expected declaration specifiers or '...' before 'size_t'
include/sound/pcm.h:966: error: expected declaration specifiers or '...' before 'size_t'
include/sound/pcm.h:969: error: expected declaration specifiers or '...' before 'size_t'
include/sound/pcm.h:969: error: expected declaration specifiers or '...' before 'size_t'
include/sound/pcm.h:970: error: expected declaration specifiers or '...' before 'size_t'
include/sound/pcm.h: In function 'snd_pcm_mmap_data_open':
include/sound/pcm.h:981: error: 'struct vm_area_struct' has no member named 'vm_private_data'
include/sound/pcm.h:982: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h: In function 'snd_pcm_mmap_data_close':
include/sound/pcm.h:987: error: 'struct vm_area_struct' has no member named 'vm_private_data'
include/sound/pcm.h:988: error: 'struct snd_pcm_substream' has no member named 'runtime'
include/sound/pcm.h: At top level:
include/sound/pcm.h:1000: error: expected declaration specifiers or '...' before 'size_t'
include/sound/pcm.h: In function 'snd_pcm_limit_isa_dma_size':
include/sound/pcm.h:1002: error: 'max' undeclared (first use in this function)
In file included from /home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/aoa.h:21,
                 from /home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:14:
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h: At top level:
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:37: error: expected specifier-qualifier-list before 'u64'
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:142: error: field 'ofdev' has incomplete type
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:169: error: expected specifier-qualifier-list before 'u32'
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/../soundbus/soundbus.h:193: error: field 'driver' has incomplete type
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c: In function 'attach_codec_to_fabric':
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:33: error: 'ENOENT' undeclared (first use in this function)
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c: In function 'aoa_fabric_register':
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:85: error: 'EALREADY' undeclared (first use in this function)
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:89: error: 'EEXIST' undeclared (first use in this function)
/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.c:91: error: 'EINVAL' undeclared (first use in this function)
make[3]: *** [/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa/snd-aoa-core.o] Error 1
make[2]: *** [/home/shorty/kernel-factory/git/snd-aoa/snd-aoa/aoa] Error 2
make[1]: *** [_module_/home/shorty/kernel-factory/git/snd-aoa/snd-aoa] Error 2
make[1]: Leaving directory `/home/shorty/kernel-factory/git/linux-2.6'
make: *** [modules] Error 2
-------------

I should compile with gcc 4.1, IINM:

$ cat /proc/version
 Linux version 2.6.17-rc3-g5528e568-dirty (root@debby1-6) (gcc version
4.1.1 20060428 (prerelease) (Debian 4.1.0-2)) #1 Sun May 7 23:51:15
CEST 2006

Does it help?

Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
