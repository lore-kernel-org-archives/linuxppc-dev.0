Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17017.44421.790813.918463@cargo.ozlabs.ibm.com>
Date: Thu, 5 May 2005 15:22:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050505044737.GY1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
	<20050505044737.GY1221@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini writes:

> Why won't it work with generic gcc4 ?  Will something more than a lot of
> extra nops be added?

Well, say you are compiling for 405.  You either need to have a gcc
that was configured with --with-cpu=405, or you need to have hacked
arch/ppc/Makefile to add -mcpu=405.  In both cases the problem doesn't
arise.  It only arises if you have a biarch gcc4 that was configured
without any --with-cpu=xxx option and is run without any -mcpu=xxx
option.

If you think we should have -mcpu=xxx on the command line for 4xx,
44x, 8xx, etc., then that's fine, but that is a separate problem from
what my patch was addressing (one which my patch might make it easier
to fix, though).

Paul.
