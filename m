Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41CHDS5zpKzF13P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 11:00:40 +1000 (AEST)
Date: Fri, 22 Jun 2018 20:00:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
Message-ID: <20180623010023.GW16221@gate.crashing.org>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
 <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
 <9cd93c1d-c067-3a18-bfd8-fef1ef443739@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9cd93c1d-c067-3a18-bfd8-fef1ef443739@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 22, 2018 at 04:51:21PM +0200, Christophe LEROY wrote:
> Le 22/06/2018 à 16:43, Breno Leitao a écrit :
> >+               fprintf(stderr, "Very big executable name: %s\n", argv[0]);
> >+               return 1;
> >+       }
> >+
> >+       strncpy(prog, argv[0], sizeof(prog) - 1);
> 
> You have checked before that argv[0] is not too long, so you should not 
> need to use strncpy(), strcpy() would do it.

If you don't care about the bytes of prog after the first zero byte, sure.


Segher
