Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F0D1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 17:15:14 +1100 (AEDT)
Message-ID: <1426140913.25936.11.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: comvert relocs_check to a shell script using grep
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 12 Mar 2015 17:15:13 +1100
In-Reply-To: <20150312151009.18077d0c@canb.auug.org.au>
References: <20150312151009.18077d0c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-12 at 15:10 +1100, Stephen Rothwell wrote:
> This runs a bit faster and removes another use of perl from
> the kernel build.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/Makefile        |  4 +--
>  arch/powerpc/relocs_check.pl | 66 --------------------------------------------
>  arch/powerpc/relocs_check.sh | 58 ++++++++++++++++++++++++++++++++++++++

Always good to see less Perl!

ShellCheck says:

   1  #!/bin/sh
   2  
   3  # Copyright © 2015 IBM Corporation
   4  
   5  # This program is free software; you can redistribute it and/or
   6  # modify it under the terms of the GNU General Public License
   7  # as published by the Free Software Foundation; either version
   8  # 2 of the License, or (at your option) any later version.
   9  
  10  # This script checks the relocations of a vmlinux for "suspicious"
  11  # relocations.
  12  
  13  # based on relocs_check.pl
  14  # Copyright © 2009 IBM Corporation
  15  
  16  if [ ${#*} -lt 2 ]; then
  17         printf "%s [path to objdump] [path to vmlinux]\n" $0 1>&2
                                                               ^––SC2086 Double quote to prevent globbing and word splitting.
  							       https://github.com/koalaman/shellcheck/wiki/SC2086

  18         exit 1
  19  fi
  20  
  21  # Have Kbuild supply the path to objdump so we handle cross compilation.
  22  objdump="$1"
  23  vmlinux="$2"
  24  
  25  bad_relocs=$(
  26  "$objdump" -R "$vmlinux" |
  27         # Only look at relocation lines.
  28         grep -E '\<R_' |
  29         # These relocations are okay
  30         # On PPC64:
  31         #       R_PPC64_RELATIVE, R_PPC64_NONE
  32         #       R_PPC64_ADDR64 mach_<name>
  33         # On PPC:
  34         #       R_PPC_RELATIVE, R_PPC_ADDR16_HI,
  35         #       R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
  36         #       R_PPC_NONE
  37         grep -F -w -v 'R_PPC64_RELATIVE
  38  R_PPC64_NONE
  39  R_PPC_ADDR16_LO
  40  R_PPC_ADDR16_HI
  41  R_PPC_ADDR16_HA
  42  R_PPC_RELATIVE
  43  R_PPC_NONE' |
  44         grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_'
  45  )
  46  
  47  if [ -z "$bad_relocs" ]; then
  48         exit 0
  49  fi
  50  
  51  printf "WARNING: %d bad relocations\n" $(printf "$bad_relocs\n" | wc -l)
                                             ^––SC2046 Quote this to prevent word splitting.
					     https://github.com/koalaman/shellcheck/wiki/SC2046
                                                      ^––SC2059 Don't use variables in the printf format string. Use printf "..%s.." "$foo".
						      https://github.com/koalaman/shellcheck/wiki/SC2059
  52  printf "$bad_relocs\n"
             ^––SC2059 Don't use variables in the printf format string. Use printf "..%s.." "$foo".
	     https://github.com/koalaman/shellcheck/wiki/SC2059
  53  
  54  # If we see this type of relocation it's an idication that
  55  # we /may/ be using an old version of binutils.
  56  if echo "$bad_relocs\n" | grep -q -F -w R_PPC64_UADDR64; then
                          ^––SC2028 echo won't expand escape sequences. Consider printf.
			  https://github.com/koalaman/shellcheck/wiki/SC2028
  57         printf "WARNING: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel\n"
  58  fi
  59
