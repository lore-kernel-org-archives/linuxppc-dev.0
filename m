Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 3/3] cell: prevent alignment interrupt on
	local store
Date: Thu, 12 Apr 2007 20:55:04 +0200
References: <20070410111508.GA2969@localhost.localdomain>
	<20070412042337.GA21832@aepfle.de>
	<200704122043.38679.arnd@arndb.de>
In-Reply-To: <200704122043.38679.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704122055.05048.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 April 2007, Arnd Bergmann wrote:
> On Thursday 12 April 2007, Olaf Hering wrote:
> > How much will this impact performance on a 970, 74xx or POWER6 if
> > everything gets compiled with '--mcpu=$cell', compared to what is used
> > today? One gets at least altivec that way.
> 
> Building with -mcpu=cell won't work on 970 or g4, because that enables
> a few extra instructions that were not present in the older cpus.
> 
> If you know you want to build with altivec (i.e. not run on power4 or
> older), then '-m32 -mcpu=7450 -mtune=cell' or '-m64 -mcpu=970 -mtune=cell'
> would be a reasonable thing to try.

Ok, ignore my comment, as benh pointed out even power5 doesn't have altivec.
I don't know how many versions of libc you are currently building, but it
probably makes sense to have at least one that uses altivec, and one for
in-order (e.g. cell) and out-of-order (e.g. power5) pipelines each.

	Arnd <><
