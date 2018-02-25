Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqF3V3nnYzF1P9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 06:13:06 +1100 (AEDT)
Date: Sun, 25 Feb 2018 12:53:38 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
Message-ID: <20180225185337.GM21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180225172236.29650-2-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Sun, Feb 25, 2018 at 06:22:16PM +0100, Mathieu Malaterre wrote:
> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=1):

> -	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
> +	for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {

You could just write != instead of < ?  Seems more readable.

Maybe something can be done to ARRAY_SIZE to make this not warn.


Segher
