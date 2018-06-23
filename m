Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41CHRb4FyNzF13P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 11:10:19 +1000 (AEST)
Date: Fri, 22 Jun 2018 20:10:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
Message-ID: <20180623011009.GX16221@gate.crashing.org>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
 <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Fri, Jun 22, 2018 at 11:43:44AM -0300, Breno Leitao wrote:
> On 06/21/2018 08:18 PM, Segher Boessenkool wrote:
> > On Wed, Jun 20, 2018 at 07:51:11PM -0300, Breno Leitao wrote:
> >> -	strncpy(prog, argv[0], strlen(argv[0]));
> >> +	strncpy(prog, argv[0], sizeof(prog) - 1);
> > 
> > 	strncpy(prog, argv[0], sizeof prog);
> > 	if (prog[sizeof prog - 1])
> > 		scream_bloody_murder();
> > 
> > Silently using the wrong data is a worse habit than not checking for
> > overflows ;-)
> 
> Completely agree! Thanks for bringing this up.
> 
> If you don't mind, I would solve this problem slightly different, as it seems
> to be more readable.
> 
> -       strncpy(prog, argv[0], strlen(argv[0]));
> +       if (strlen(argv[0]) >= LEN_MAX){
> +               fprintf(stderr, "Very big executable name: %s\n", argv[0]);
> +               return 1;
> +       }
> +
> +       strncpy(prog, argv[0], sizeof(prog) - 1);

The strlen reads all of argv[0], which can be very big in theory.  It won't
matter in this test file -- program arguments cannot be super long, for one
thing -- but it's not a good idea in general (that is one of the problems
of strlcpy, btw).

Best of course is to avoid string length restrictions completely, if you can.


Segher
