Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17031.56167.926193.391545@cargo.ozlabs.ibm.com>
Date: Mon, 16 May 2005 09:29:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1116198114.5095.43.camel@gaston>
References: <4287CF06.5000809@BitWagon.com> <1116198114.5095.43.camel@gaston>
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> We "inherited" from some historic junk in the prep and chrp support,
> that a lot of embedded platforms blindly copied, where archs use
> io_block_mapping() early during boot to hard-wire various IO stuffs in
> various places in the address space, including just after 2Gb. It's
> totally bogus, but nobody really cared to fix it so far. The 2Gb
> TASK_SIZE limit doesn't seem to have ever been an issue for ppc32 users
> so far I must say, at least you are the first one to complain ;)

I believe that prep and chrp are also now OK with a 3GB TASK_SIZE
limit, it's just various embedded board ports that will blow up with
3GB.  We should change the default to 3GB to encourage the embedded
guys to fix their ports properly (or else to put in the appropriate
Kconfig stuff to force it back to 2GB for their port).

Paul.
