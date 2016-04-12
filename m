Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkbPy2d88zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 15:40:53 +1000 (AEST)
Date: Tue, 12 Apr 2016 00:40:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org, michael.neuling@au1.ibm.com,
 michaele@au1.ibm.com
Subject: Re: [PATCH 2/3] powerpc: Load Monitor Register Support
Message-ID: <20160412054041.GA21633@gate.crashing.org>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-3-git-send-email-jack@codezen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460401065-10540-3-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Apr 11, 2016 at 01:57:44PM -0500, Jack Miller wrote:
>  __init_FSCR:
>  	mfspr	r3,SPRN_FSCR
> +	andi.   r3,r3,(~FSCR_LM)@L
>  	ori	r3,r3,FSCR_TAR|FSCR_DSCR|FSCR_EBB
>  	mtspr	SPRN_FSCR,r3
>  	blr

This clears the top 48 bits as well.  Shouldn't matter currently; but
more robust (and easier to read, if you know the idiom) is

	ori	r3,r3,FSCR_LM|FSCR_TAR|FSCR_DSCR|FSCR_EBB
	xori	r3,r3,FSCR_LM


Segher
