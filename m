Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18759.14782.643034.16205@cargo.ozlabs.ibm.com>
Date: Tue, 16 Dec 2008 16:16:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] less use of NODE_DATA()
In-Reply-To: <20081209182139.4FF468F1@kernel>
References: <20081209182130.DB2150A2@kernel> <20081209182139.4FF468F1@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	linuxppc-dev@ozlabs.org, "Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Hansen writes:

> The use of NODE_DATA() in the ppc init code is fragile.  We use
> it for some nodes as we are initializing others.  As the loop
> initializing them has gotten more complex and broken out into
> several functions it gets harder and harder to remember how
> this goes.

With this one applied (it needed some adjustment because of
differences in dbg() lines), I get a hang on boot on a POWER6
partition after printing:

Linux version 2.6.28-rc8-test (paulus@drongo) (gcc version 4.3.2 (Debian 4.3.2-1) ) #64 SMP Tue Dec 16 16:14:45 EST 2008
[boot]0012 Setup Arch
Node 0 Memory:
Node 1 Memory: 0x0-0x100000000

It appears that this partition has all its memory on node 1.  It did
boot OK with your patches up to 5/8 applied.

Paul.
