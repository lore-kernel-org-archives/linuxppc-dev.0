Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 327FEDE128
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 04:53:38 +1000 (EST)
Message-Id: <88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: issues w/init
Date: Thu, 16 Apr 2009 13:53:32 -0500
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2009, at 1:21 PM, Kumar Gala wrote:

> Ben,
>
> The following patch is causing me issues w/init SEGV on boot.  This  
> is a pretty old version of init and I'm wondering what the commit  
> you had related to old ABI breakage:
>
> commit 8d30c14cab30d405a05f2aaceda1e9ad57800f36
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Feb 10 16:02:37 2009 +0000
>
>    powerpc/mm: Rework I$/D$ coherency (v3)
>
>    This patch reworks the way we do I and D cache coherency on  
> PowerPC.
>
>
> ---
>                /*
>                 * Allow execution from readable areas if the MMU  
> does not
>                 * provide separate controls over reading and  
> executing.
> +                *
> +                * Note: That code used to not be enabled for 4xx/ 
> BookE.
> +                * It is now as I/D cache coherency for these is  
> done at
> +                * set_pte_at() time and I see no reason why the test
> +                * below wouldn't be valid on those processors. This  
> -may-
> +                * break programs compiled with a really old ABI  
> though.
>                 */
>
> - k

A bit more debug info that might be helpful, I'm hitting this bad_area  
fault :

                 if (!(vma->vm_flags & VM_EXEC) &&
                     (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
                      !(vma->vm_flags & (VM_READ | VM_WRITE))))
                         goto bad_area;

bad_area 7 = 48024bf4 vm_flags:0810 0873
SEGV 3 address:48024bf4 trap:400 error_code:0

[root:~] cat /proc/1/maps
00100000-00103000 r-xp 00100000 00:00 0          [vdso]
0feab000-0ffbe000 r-xp 00000000 00:0d 7127086    /lib/libc-2.2.5.so
0ffbe000-0ffcb000 ---p 00113000 00:0d 7127086    /lib/libc-2.2.5.so
0ffcb000-0ffeb000 rw-p 00110000 00:0d 7127086    /lib/libc-2.2.5.so
0ffeb000-0fff0000 rw-p 0ffeb000 00:00 0
10000000-10008000 r-xp 00000000 00:0d 9093222    /sbin/init
10017000-10018000 rw-p 00007000 00:0d 9093222    /sbin/init
10018000-1001c000 rwxp 10018000 00:00 0          [heap]
48000000-48013000 r-xp 00000000 00:0d 7127082    /lib/ld-2.2.5.so
48022000-48026000 rw-p 00012000 00:0d 7127082    /lib/ld-2.2.5.so
bfd0e000-bfd23000 rwxp bffeb000 00:00 0          [stack]
