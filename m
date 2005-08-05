Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Fri, 5 Aug 2005 13:53:22 +0200
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
	<20050805174705.731ffa05.sfr@canb.auug.org.au>
In-Reply-To: <20050805174705.731ffa05.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508051353.23750.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
	Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freedag 05 August 2005 09:47, Stephen Rothwell wrote:
> cd linux/include
> mkdir asm-powerpc
> cd asm-ppc
> for i in *
> do
> =A0=A0=A0=A0=A0=A0=A0=A0[ -e ../asm-ppc64/$i ] || mv $i ../asm-powerpc/$i
> done
> cd ../asm-ppc64
> for i in *
> do
> =A0=A0=A0=A0=A0=A0=A0=A0[ -e ../asm-ppc/$i ] || mv $i ../asm-powerpc/$i
> done

While I really like your approach in general (I've done it the
same way when merging asm-s390{,x]), I think we should take
a little care to move only the files that we really want in
asm/powerpc.
E.g, most of the files that are in asm-ppc but not in asm-ppc64
seem so be board-specific or cpu-specific, so I'd not move them
around before (unless) moving the platform code for those as well.

Also, for everything below include/asm-ppc64/iSeries, it would
make sense to rename the files to lowercase in the same
step and change all their users.

> for i in *
> do
> =A0=A0=A0=A0=A0=A0=A0=A0[ -f ../asm-ppc64/$i ] && cmp -s $i ../asm-ppc64/=
$i &&
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mv $i ../asm-powerpc/$i &=
& rm ../asm-ppc64/$i
> done

Another help for merging further is to do=20

for i in `ls include/asm-ppc` ; do=20
	if [ -e include/asm-ppc64/$i ] ; then
		diff --ifdef __powerpc64__ include/asm-{ppc,ppc64}/$i > \
			include/asm-generic/$i ;
	fi
done

Note that you need to hand-edit practically every file that you get from
this, but many of them become trivial to merge.

Another interesting point about it is which define to use. For s390, we
decided to '#ifdef __s390x__' rather than '#ifdef CONFIG_ARCH_S390X' or
'ifdef CONFIG_64BIT', because CONFIG_* does not work when including the
headers from user space.
Using CONFIG_64BIT instead of __powerpc64__ only within #ifdef __KERNEL__
would be correct but less consistant.

	Arnd <><
