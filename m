Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 4/4] Add support to OProfile
	=?iso-8859-1?q?for=09profiling_Cell_BE_SPUs_--?= update
Date: Wed, 31 Jan 2007 07:06:11 +0100
References: <45BE4ED0.5030808@us.ibm.com> <45BFBB78.7060907@us.ibm.com>
	<1170199869.5235.38.camel@dyn9047021078.beaverton.ibm.com>
In-Reply-To: <1170199869.5235.38.camel@dyn9047021078.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701310706.12356.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net, Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 31 January 2007 00:31, Carl Love wrote:
> Unfortunately, the only way we know how to
> figure out what the LFSR value that corresponds to the number in the
> sequence that is N before the last value (0xFFFFFF) is to calculate the
> previous value N times. =A0It is like trying to ask what is the pseudo
> random number that is N before this pseudo random number?

Well, you can at least implement the lfsr both ways, and choose the one
that is faster to get at, like

u32 get_lfsr(u32 v)
{
	int i;
	u32 r =3D 0xffffff;
	if (v < 0x7fffff) {
		for (i =3D 0; i < v; i++)
			r =3D lfsr_forwards(r);
	} else {
		for (i =3D 0; i < (0x1000000 - v); i++)
			r =3D lfsr_backwards(r);
	}
	return r;
}

Also, if the value doesn't have to be really exact, you could have
a small lookup table with precomputed values, like:

u32 get_lfsr(u32 v)
{
	static const lookup[256] =3D {
		0xab3492, 0x3e3f34, 0xc47610c, ... /* insert actual values */
	};

	return lookup[v >> 16];
}

	Arnd <><
