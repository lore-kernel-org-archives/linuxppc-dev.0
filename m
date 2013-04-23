Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 19:12:47 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130423091246.GA18195@concordia>
References: <1470334.YUWOQ37ijW@ernie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470334.YUWOQ37ijW@ernie>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 06:44:13PM +0200, Dennis Schridde wrote:
> Hello!

Hi Dennis,


> [1.] One line summary of the problem:
> Only 2 of 4 cores used on IBM Cell blades and no threads shown in spufs
> 
> 
> [2.] Full description of the problem/report:
> On my IBM Cell blades, only 2 out of the 4 CPU cores are being used, even when 
> several threads are running. 

Yes you're right, I see that too.

For me it is fixed by applying the following patch, it should be in v3.10:

  http://patchwork.ozlabs.org/patch/230103/

Maybe you can try it.


> Also /spu is always empty, despite the SPUs being 

Yes I see that too.

> For testing, I started an instance of cellminer with --ppe 2 --spe 16 (2 
> threads on the PPEs, 16 on the SPEs) and htop reports two CPU cores being used 
> at 100% and two others at 0%, while 4 threads are running (each at 50% CPU 
> utilisation -> they share a core).

Does your cellminer actually work? ie. does it run OK?

I am using a fractal benchmark I had lying around, and it appears to
work, and runs fast enough that it must be running on the SPUs (I think).

So it sounds like we have some weirdness with stuff not appearing in
/spu, but spu programs are still able to run. Which is odd to say the
least.

cheers
