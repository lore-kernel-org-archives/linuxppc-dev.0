Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5F08EDDE19
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 03:25:45 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20081122030653.GU6830@localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f35ce64a4d02ccbf84d3288dad3dc0f8@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: badness in xics_set_cpu_giq on JS20 blade
Date: Sat, 22 Nov 2008 10:30:38 -0600
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Nov 22 at 14:06:53 EST in 2008, Nathan Lynch wrote:
> With 2.6.28-rc5 the WARN_ON in xics_set_cpu_giq is triggering on a
> JS20.  I changed it to a WARN to get the actual status returned:
>
> [boot]0020 XICS Init
> set-indicator returned -22
> ------------[ cut here ]------------
> Badness at arch/powerpc/platforms/pseries/xics.c:733
...
> Call Trace:
> [c0000000006b3ca0] [c000000000047450] .xics_set_cpu_giq+0x50/0x68 
> (unreliable)
> [c0000000006b3d10] [c0000000005927b8] .xics_init_IRQ+0x2f4/0x338
> [c0000000006b3de0] [c000000000591bcc] .pseries_xics_init_IRQ+0x14/0x2c
> [c0000000006b3e60] [c000000000580488] .init_IRQ+0x40/0x5c
> [c0000000006b3ee0] [c0000000005787d8] .start_kernel+0x250/0x478
> [c0000000006b3f90] [c0000000000083b8] .start_here_common+0x1c/0x64
...
> -22 is -EINVAL, which maps to a -3 return code from RTAS (see
> rtas_error_rc).
>
> The system appears to boot and function normally after this, though.
> FWIW, it looks like its firmware is up to date (FW08401160 from March
> 2008).

b4963255ad5a426f04a0bb15c4315fa4bb40cde9 "Factor out cpu 
joining/unjoining the GIQ" consolidated the join and remove call sites. 
  Looking closer it also added warn if rtas-indicator returned an error 
on join in addition to leave.

I don't have my PAPR here, but from rtas_error_rc (rtas.c) -3 is /* Bad 
indicator/domain/etc */.  This indicator was added to support cpu add 
and remove.  I'm guessing js20 doesn't support that from rtas (ie 
doesn't support cpu hotadd), and the indicator is not available.  (I 
know js21 has it because I had a bit of time to see its broken 
emulation of this call once).

When we get control of a cpu from OF it is already in the joined state. 
  We join on all threads because we need to do so on secondary threads 
and because we did a remove on (previously all, but now secondary) 
threads during kexec.

If memory serves, there is a property in the rtas node to indicate each 
sensor that is present.  If so, we should search for that property 
before calling set-indicator.

milton
