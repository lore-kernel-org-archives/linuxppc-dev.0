Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Bd1p2418zF0xF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 09:19:09 +1000 (AEST)
Date: Thu, 21 Jun 2018 18:18:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
Message-ID: <20180621231856.GO16221@gate.crashing.org>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529535071-14555-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 07:51:11PM -0300, Breno Leitao wrote:
> -	strncpy(prog, argv[0], strlen(argv[0]));
> +	strncpy(prog, argv[0], sizeof(prog) - 1);

	strncpy(prog, argv[0], sizeof prog);
	if (prog[sizeof prog - 1])
		scream_bloody_murder();

Silently using the wrong data is a worse habit than not checking for
overflows ;-)


Segher
