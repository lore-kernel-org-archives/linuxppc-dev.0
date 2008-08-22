Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] powerpc: new copy_4K_page()
Date: Fri, 22 Aug 2008 14:32:59 +1000
References: <200808141617.32033.markn@au1.ibm.com>
In-Reply-To: <200808141617.32033.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808221432.59480.markn@au1.ibm.com>
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Aug 2008 04:17:32 pm Mark Nelson wrote:
> Hi All,
> 
> What follows is an updated version of copy_4K_page that has been tuned
> for the Cell processor. With this new routine it was found that the
> system time measured when compiling a 2.6.26 pseries_defconfig was
> reduced by ~10s:
> 
> mainline (2.6.27-rc1-00632-g2e1e921):
> 
> real    17m8.727s
> user    59m48.693s
> sys     3m56.089s
> 
> real    17m9.350s
> user    59m44.822s
> sys     3m56.666s
> 
> new routine:
> 
> real    17m7.311s
> user    59m51.339s
> sys     3m47.043s
> 
> real    17m7.863s
> user    59m49.028s
> sys     3m46.608s
> 
> This same routine was also found to improve performance on 970 CPUs
> too (but by a much smaller amount):
> 
> mainline (2.6.27-rc1-00632-g2e1e921):
> 
> real    16m8.545s
> user    14m38.134s
> sys     1m55.156s
> 
> real    16m7.089s
> user    14m37.974s
> sys     1m55.010s
> 
> new routine:
> 
> real    16m11.641s
> user    14m37.251s
> sys     1m52.618s
> 
> real    16m6.139s
> user    14m38.282s
> sys     1m53.184s
> 
> 
> I also did testing on Power{3..6} and I found that Power3, Power5 and
> Power6 did better with this new routine when the dcbt and dcbz
> weren't used (in which case they achieved performance comparable to
> the existing kernel copy_4K_page routine). Power4 on other hand
> performed slightly better with the dcbt and dcbz included (still
> comparable to the current kernel copy_4K_page).
> 
> So in order to get the best performance across the board I created a
> new CPU feature that will govern whether the dcbt and dcbz are used
> (and un-creatively named it CPU_FTR_CP_USE_DCBTZ). I added it to the
> CPU features of Cell, Power4 and 970.
> Unfortunately I don't have access to a PA6T but judging by the
> marketing material I could find, it looks like it has a strong enough
> hardware prefetcher that it probably wouldn't benefit from the dcbt
> and dcbz...
> 
> Okay, that's probably enough prattling along - you can all go and look
> at the code now.
> 
> All comments appreciated
> 
> [I decided to post the whole copy routine rather than a diff between
> it and the current one because I found the diff quite unreadable. I'll post
> a real patchset after I've addressed any comments.]
> 
> Many thanks!
> 

The actual patches for the new copy_4K_page() follow this.

Note: I changed the order of the patches so that the new CPU feature
bit is introduced in the first patch and then the new copy_4K_page
is introduced in the second patch.
