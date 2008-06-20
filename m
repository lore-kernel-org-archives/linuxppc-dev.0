Return-Path: <sanjay3000@yahoo.com>
Received: from web33104.mail.mud.yahoo.com (web33104.mail.mud.yahoo.com
	[209.191.69.134]) by ozlabs.org (Postfix) with SMTP id 13BE7DE820
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 03:46:37 +1000 (EST)
Date: Fri, 20 Jun 2008 10:46:36 -0700 (PDT)
From: Sanjay Patel <sanjay3000@yahoo.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: Gunnar von Boehn <VONBOEHN@de.ibm.com>
In-Reply-To: <OF2260963C.4B69232D-ONC125746E.0032489D-C125746E.003FD09E@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <247666.12345.qm@web33104.mail.mud.yahoo.com>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: sanjay3000@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--- On Fri, 6/20/08, Gunnar von Boehn <VONBOEHN@de.ibm.com> wrote:
> How important is best performance for the unaligned copy
> to/from uncacheable memory?
> The challenge of the CELL chip is that X-form of the shift
> instructions are microcoded.
> The shifts are needed to implement a copy that reads and
> writes always aligned.

Hi Gunnar,

I have no idea how important unaligned or uncacheable copy perf is for Cell Linux. My experience is from Mac OS X for PPC, where we used dcbz in a general-purpose memcpy but were forced to pull that optimization because of the detrimental perf effect on important applications.

I may be missing something, but I don't see how Cell's microcoded shift is much of a factor here. The problem is that the dcbz will generate the alignment exception regardless of whether the data is actually unaligned or not. Once you're on that code path, performance can't be good, can it?

--Sanjay




      
