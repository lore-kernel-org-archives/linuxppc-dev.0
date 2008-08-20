Return-Path: <robert.richter@amd.com>
Date: Wed, 20 Aug 2008 14:39:45 +0200
From: Robert Richter <robert.richter@amd.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc/cell/oprofile: fix mutex locking for spu-oprofile
Message-ID: <20080820123944.GQ13011@erda.amd.com>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<18591.30474.127939.243247@cargo.ozlabs.ibm.com>
	<200808110918.57293.arnd@arndb.de>
	<200808110925.08485.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <200808110925.08485.arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11.08.08 09:25:07, Arnd Bergmann wrote:
> From: Carl Love <cel@us.ibm.com>
> 
> The issue is the SPU code is not holding the kernel mutex lock while
> adding samples to the kernel buffer.
> 
> This patch creates per SPU buffers to hold the data.  Data
> is added to the buffers from in interrupt context.  The data
> is periodically pushed to the kernel buffer via a new Oprofile
> function oprofile_put_buff(). The oprofile_put_buff() function
> is called via a work queue enabling the funtion to acquire the
> mutex lock.
> 
> The existing user controls for adjusting the per CPU buffer
> size is used to control the size of the per SPU buffers.
> Similarly, overflows of the SPU buffers are reported by
> incrementing the per CPU buffer stats.  This eliminates the
> need to have architecture specific controls for the per SPU
> buffers which is not acceptable to the OProfile user tool
> maintainer.
> 
> The export of the oprofile add_event_entry() is removed as it
> is no longer needed given this patch.
> 
> Note, this patch has not addressed the issue of indexing arrays
> by the spu number.  This still needs to be fixed as the spu
> numbering is not guarenteed to be 0 to max_num_spus-1.
> 
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Robert Richter <robert.richter@amd.com>

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
