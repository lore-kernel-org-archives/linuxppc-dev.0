Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMVjm1M5kzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:04:27 +1100 (AEDT)
Date: Mon, 13 Feb 2017 09:44:37 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc: Blacklist GCC 5.4 6.1 and 6.2
Message-ID: <20170213154437.GP21840@gate.crashing.org>
References: <20170213033536.8908-1-cyrilbur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170213033536.8908-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On Mon, Feb 13, 2017 at 02:35:36PM +1100, Cyril Bur wrote:
> A bug in the -02 optimisation of GCC 5.4 6.1 and 6.2 causes
> setup_command_line() to not pass the correct first argument to strcpy
> and therefore not actually copy the command_line.

There is no such thing as an "-O2 optimisation".

> At the time of writing GCC 5.4 is the most recent and is affected. GCC
> 6.3 contains the backported fix, has been tested and appears safe to
> use.

6.3 is (of course) the newer release; 5.4 is a maintenance release of
a compiler that is a year older.

> +# - gcc-5.4, 6.1, 6.2 don't copy the command_line around correctly

> +		echo -n '*** GCC-5.4 6.1 6.2 have a bad -O2 optimisation ' ; \
> +		echo 'which will cause lost command_line options (at least).' ; \

Maybe something more like

"GCC 5.4, 6.1, and 6.2 have a bug that results in a kernel that does
not boot.  Please use GCC 6.3 or later.".

Please mention the GCC PR # somewhere in the code, too?


Segher
