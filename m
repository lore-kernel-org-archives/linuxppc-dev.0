Message-ID: <XFMail.991208160213.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.SGI.4.10.9912081623090.145056-100000@brule.borg.umn.edu>
Date: Wed, 08 Dec 1999 16:02:13 -0700 (MST)
From: Gary Thomas <gdt@linuxppc.org>
To: Grant Erickson <grant@lcse.umn.edu>
Subject: RE: PPC Cache Flush and Invalidate Routines
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 08-Dec-99 Grant Erickson wrote:
> 
> In trying to accomodate the 4xx-based code into the Linux kernel, I've
> encountered an issue which relates to the cache flushing and invalidation
> routines in misc.S.
> 
> Among the 4xx-based processors, the 403s have 16 byte cache lines and the
> 405s have 32 byte cache lines. Among the 8xx processors, all appear to
> have 16 byte cache lines. All the rest seem to have 32 byte cache lines.
> 
> There are several solutions here:
> 
>  - Use ifdef's as is done at present.
> 
>  - Check the PVR on entry to each of these routines and "do the right
>    thing".
> 
>  - Set global variables ppc_cache_linesize and ppc_cache_lineshift
>    somewhere in MMU_init or setup_arch which then get loaded in the cache
>    routines.
> 
> The first option keeps the code small and fast, but doesn't easily cover
> the dichotomy between the line sizes in 403 and 405 with a simple
> CONFIG_4xx.
> 
> The second option incurs a lot of unnecessary overhead per invocation of
> the routines and adds a lot of special-case code to each routine.
> 
> The final option seems the best compromise, increasing kernel memory usage
> by 8 bytes and adding a little code to load the values of
> ppc_cache_line{size,shift}. All the overhead is then left to a one time
> invocation in MMU_init or setup_arch.
> 
> Thoughts, opinions?
> 

Perhaps calling these routines via a vector whose value is computed at
boot/setup time that DTRT (does the right thing).  This would keep the
overhead down to a single load and still provide the desired functionality.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
