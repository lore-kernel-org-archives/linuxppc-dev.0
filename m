Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 07/15] powerpc: Move CPU_FTRS_BASE_BOOK3E into cputable.h
	& update FTR masks
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1a24282746fd056fb51dda3b25d160d2fc609da5.1302856271.git.michael@ellerman.id.au>
Date: Mon, 18 Apr 2011 07:37:35 -0500
Message-Id: <F5D0207F-8EF1-439A-B7C4-53CB89778B32@kernel.crashing.org>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<1a24282746fd056fb51dda3b25d160d2fc609da5.1302856271.git.michael@ellerman.id.au>
To: Michael Ellerman <michael@ozlabs.org>
Cc: Jimi Xenidis <jimix@watson.ibm.com>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>, imunsie@au.ibm.com,
	jack@codezen.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2011, at 3:32 AM, Michael Ellerman wrote:

> From: Michael Ellerman <michael@ellerman.id.au>
> 
> Where they belong with all the others. Remove SMT which may not be
> true for all BOOK3E parts.
> 
> Currently the FTRS_POSSIBLE & FTRS_ALWAYS are defined for 64 or 32 bit.
> Now that we have BOOK3E we need to split it three ways, BOOK3S, BOOK3E,
> and 32-bit.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/include/asm/cputable.h |   17 +++++++++++++----
> arch/powerpc/kernel/cputable.c      |    3 ---
> 2 files changed, 13 insertions(+), 7 deletions(-)

will probably need some updating based on:

commit 11ed0db9f6c7811233632d2ab79c50c011b89902
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Wed Apr 6 00:11:06 2011 -0500

    powerpc/book3e: Fix CPU feature handling on 64-bit e5500
    
    The CPU_FTRS_POSSIBLE and CPU_FTRS_ALWAYS defines did not encompass
    e5500 CPU features when built for 64-bit.  This causes issues with
    cpu_has_feature() as it utilizes the POSSIBLE & ALWAYS defines as part
    of its check.
    
    Create a unique CPU_FTRS_E5500 (as its different from CPU_FTRS_E500MC),
    created a new group for 64-bit Book3e based CPUs and add CPU_FTRS_E5500
    to that group.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

- k
