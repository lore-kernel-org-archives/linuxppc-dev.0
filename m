Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE()
Date: Thu, 13 Sep 2007 14:17:48 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<200709121047.05471.arnd@arndb.de>
	<1189649141.19087.13.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1189649141.19087.13.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709131417.48748.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 September 2007, Michael Ellerman wrote:
> Well that'd be nice, but I don't see anywhere that that happens. AFAICT
> the acquire we do in the first coredump callback is the first the SPU
> contexts know about their PPE process dying. And spufs is still live, so
> I think we definitely need to grab the mutex, or we might race with
> userspace accessing spufs files.

Right, I was only thinking about the dumping process itself, but there
may be other processes that still have files open for that context.

	Arnd <><
