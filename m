Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F25B2B7CF8
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 07:10:30 +1100 (EST)
Subject: Re: [PATCH 1/4] 8xx: Optimze TLB Miss handlers
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
Date: Fri, 26 Feb 2010 14:10:31 -0600
Message-Id: <C13A88EA-3A60-41BB-BB26-C1DC9CF37422@kernel.crashing.org>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 26, 2010, at 2:29 AM, Joakim Tjernlund wrote:

> 	li	r11, 0x00f0
> -	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
> +	rlwimi	r10, r11, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
> 	DO_8xx_CPU6(0x2d80, r3)
> 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */

Cool, didn't know 'as' supported this notation.

- k
